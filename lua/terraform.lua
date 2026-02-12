local M = {}

function M.terraform_state()
  local picker = require "snacks.picker"

  ---@type snacks.picker.finder.Item[]
  local items = {}
  local result = vim.system({ "terraform", "state", "list" }, { text = true }):wait()
  local out = vim.fn.split(result.stdout, "\n")
  local err = vim.fn.split(result.stderr, "\n")

  if #out == 0 then
    Snacks.notify("No resources found in terraform state", "warn")
    return
  end

  for i, line in ipairs(out) do
    table.insert(items, {
      idx = i,
      source = i,
      text = line,
      file = line,
    })
  end

  if #items == 0 then
    Snacks.notify("No resources found in terraform state", "warn")
    return
  end

  local cwd = vim.fn.getcwd()
  ---@type snacks.picker.Config
  picker.pick {
    source = "terraform",
    cwd = cwd,
    items = items,
    format = function(item, _)
      local ret = {}
      ret[#ret + 1] = { item.text }
      return ret
    end,
    confirm = function(pick, item)
      if not item then
        pick:close()
        return
      end

      local resource, name = string.match(item.text, "(.*)%.(.*)")
      local pattern = string.format('%s" "%s', resource, name)
      local g = vim.system({ "grep", "-rn", pattern, vim.fn.getcwd() }):wait()
      local lines = vim.fn.split(g.stdout, "\n")

      local path
      local lnum
      for _, line in ipairs(lines) do
        path, lnum = line:match "(.*):(%d+)"
      end
      vim.api.nvim_command("e +" .. lnum .. " " .. path)
      pick:close()
    end,
    preview = function(ctx)
      local function trim(s) return (s:gsub("^%s*(.-)%s*$", "%1")) end

      local cmd = { "terraform", "state", "show", trim(ctx.item.text) }
      Snacks.picker.preview.cmd(cmd, ctx)

      return true
    end,
  }
end
return M
