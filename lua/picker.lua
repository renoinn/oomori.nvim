local M = {}

function M.picker()
  local list = {
    { text = "hoge1", file = "hoge.txt" },
    { text = "hoge2", file = "hoge.txt" },
    { text = "hoge3", file = "hoge.txt" },
  }

  ---@type snacks.picker.Item[]
  local items = {}
  for i, v in ipairs(list) do
    ---@type snacks.picker.Item
    local item = {
      idx = i,
      score = i,
      text = v.text,
      file = v.file,
    }
    table.insert(items, item)
  end

  local picker = require "snacks.picker"
  ---@type snacks.picker
  picker {
    source = "hoge",
    items = items,
    confirm = function(the_picker, item)
      the_picker:close()
      vim.notify(item.text)
    end,
    format = "text",
    preview = "none",
  }
end

return M
