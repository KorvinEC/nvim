local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local copy_insert = function(index)
  return f(function(arg)
    return arg[1]
  end, { index })
end

local ifmain = s(
  "ifmain",
  fmt(
    [[
    def {}():
        {}


    if __name__ == "__main__":
        {}()
    ]],
    {
      i(1, "main"),
      i(2, "pass"),
      copy_insert(1)
    }
  )
)

local aifmain = s(
  "aifmain",
  fmt(
    [[
    from asyncio import run


    async def {}():
        {}


    if __name__ == "__main__":
        run({}())
    ]],
    {
      i(1, "main"),
      i(2, "pass"),
      copy_insert(1)
    }
  )
)


-- Function to check if logger import exists in the current buffer
local function has_logger_import()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- Find the first non-import/non-comment line to determine import section end
  local import_section_end = 0
  for index, line in ipairs(lines) do
    local trimmed = line:match("^%s*(.-)%s*$") -- trim whitespace
    if trimmed == "" then
      -- Skip empty lines
    elseif trimmed:match("^#") then
      -- Skip comments
    elseif trimmed:match("^from%s+") or trimmed:match("^import%s+") then
      -- This is an import line
      import_section_end = index
      -- Check if this line contains the logger import we're looking for
      if trimmed:match("from%s+logging%s+import.*getLogger") or
          trimmed:match("from%s+logger%s+import.*getLogger") then
        return true, 0
      end
    else
      -- First non-import line found
      break
    end
  end

  return false, import_section_end
end

-- Function to add logger import if not present
local function ensure_logger_import()
  local has_import, import_end_line = has_logger_import()

  if not has_import then
    local buf = vim.api.nvim_get_current_buf()
    local import_line = "from logging import getLogger"

    -- Insert the import line after the last import or at the beginning
    vim.api.nvim_buf_set_lines(buf, import_end_line, import_end_line, false, { import_line, "" })

    return "logger = getLogger(__name__)\n\n"
  end

  return ""
end


local function logger_import()
  ensure_logger_import()

  return sn(
    nil,
    c(
      1,
      {
        t "debug",
        t "info",
        t "warning",
        t "error",
        t "critical"
      }
    )
  )
end


local logger = s(
  "logger",
  fmt(
    [[
    logger.{}({})
    ]],
    {
      d(1, logger_import),
      c(2, {
        fmt([["{}"]], i(1)),
        fmt([[f"{{{}}}"]], i(1)),
        fmt([[f"{{{} = }}"]], i(1))
      })
    }
  )
)

return {
  ifmain,
  aifmain,
  logger,
}
