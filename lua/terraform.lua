local M = {}

function M.terraform_state()
  local picker = require "snacks.picker"

  ---@type snacks.picker.finder.Item[]
  local items = {}

  -- terraform state list の出力を取得
  local handle = io.popen "terraform state list 2>/dev/null"
  if not handle then
    Snacks.notify("No terraform state or not in a terraform directory", "warn")
    return
  end
  local result = handle:read "*a"
  handle:close()

  if result == "" then
    Snacks.notify("No resources found in terraform state", "warn")
    return
  end

  -- 行ごとにsplit して items を作成
  for i, state_name in result:gmatch "[^\n]+" do
    if state_name ~= "" then
      table.insert(items, {
        idx = i,
        source = i,
        text = state_name,
        file = state_name,
      })
    end
  end

  if #items == 0 then
    Snacks.notify("No resources found in terraform state", "warn")
    return
  end

  ---@type snacks.picker.Config
  picker.pick {
    source = "terraform",
    items = items,
    format = function(item, _)
      local ret = {}
      ret[#ret + 1] = { item.text }
      return ret
    end,
    confirm = function(the_picker, item)
      if item then
        the_picker:close()
        Snacks.notify("Resource: " .. item.text, "info")
        -- Additional actions can be added here (e.g., open file, show details)
      end
    end,
    preview = function(ctx)
      if not ctx then return false end
      -- Show resource details from state
      local details = {}
      table.insert(details, "Resource: " .. ctx.item.text)
      table.insert(details, "---")

      -- Run terraform state show for the selected resource
      local cmd = "terraform state show " .. vim.fn.shellescape(ctx.item.text) .. " 2>/dev/null"
      local show_handle = io.popen(cmd)
      if show_handle then
        local show_result = show_handle:read "*a"
        show_handle:close()
        for line in show_result:gmatch "[^\n]+" do
          table.insert(details, line)
        end
      end

      return true
    end,
  }
end
return M
