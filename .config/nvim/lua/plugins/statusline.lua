local gl = require('galaxyline')
local condition = require('galaxyline.condition')

local C = require('utils').colors()
local colors = C.colors

local function mode_alias(m)
  local alias = {
    n = 'NORMAL',
    i = 'INSERT',
    c = 'COMMAND',
    R = 'REPLACE',
    t = 'TERMINAL',
    [''] = 'V-BLOCK',
    V = 'V-LINE',
    v = 'VISUAL',
  }

  return alias[m] or ''
end

local function mode_color(m)
  local mode_colors = {
    normal =  colors.green,
    insert =  colors.blue,
    visual =  colors.purple,
    replace =  colors.red,
  }

  local color = {
    n = mode_colors.normal,
    i = mode_colors.insert,
    c = mode_colors.replace,
    R = mode_colors.replace,
    t = mode_colors.insert,
    [''] = mode_colors.visual,
    V = mode_colors.visual,
    v = mode_colors.visual,
  }

  return color[m] or colors.bg_light
end

-- combine 2 or more conditions
local function combine(...)
  local arg = {...}
  return function()
    for _, cond in ipairs(arg) do
      if not cond() then return false end
    end

    return true
  end
end

local num_icon_colors = 5
local icon_colors = {
  colors.green,
  colors.yellow,
  colors.red,
  colors.blue,
  colors.purple
}

-- disable for these file types
gl.short_line_list = { 'startify', 'nerdtree', 'term', 'fugitive', 'NvimTree' }

gl.section.left[1] = {
  PrefixIcon = {
    separator = '  ',
    separator_highlight = function()
      local color = vim.b.statusline_icon_color or icon_colors[vim.fn.bufnr() % num_icon_colors + 1]
      vim.b.statusline_icon_color = color
      return {color, condition.hide_in_width() and colors.bg_light or colors.bg_dim}
    end,
    highlight = function()
      local color = vim.b.statusline_icon_color or icon_colors[vim.fn.bufnr() % num_icon_colors + 1]
      vim.b.statusline_icon_color = color
      return {colors.bg, color}
    end,
    provider = function() return "  󰀘 " end,
  }
}

gl.section.left[2] = {
  CWD = {
    condition = condition.hide_in_width,
    separator = '  ',
    separator_highlight = function()
      return {colors.bg_light, condition.buffer_not_empty() and colors.bg_dim or colors.bg}
    end,
    highlight = {colors.white, colors.bg_light},
    provider = function()
      local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      return '󰉖 ' .. dirname .. ' '
    end,
  }
}

gl.section.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
  }
}

gl.section.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
    separator_highlight = {colors.bg_dim, colors.bg},
    separator = '  ',
  }
}

gl.section.left[5] = {
  DiffAdd = {
    icon = '  ',
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    highlight = {colors.white, colors.bg},
  }
}

gl.section.left[6] = {
  DiffModified = {
    icon = '  ',
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    highlight = {colors.gray, colors.bg},
  }
}

gl.section.left[7] = {
  DiffRemove = {
    icon = '  ',
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    highlight = {colors.gray, colors.bg},
  }
}

-- FIXME: language server status
-- gl.section.left[8] = {
--   CocStatus = {
--     condition = condition.hide_in_width,
--     highlight = {colors.gray, colors.bg},
--     provider = function()
--       return vim.fn['coc#status']()
--         -- :gsub('\u{274c}', '\u{f06a}')         -- 
--         -- :gsub('\u{26a0}\u{fe0f}', '\u{f071}') -- 
--         -- :gsub('^W(%d)$', '\u{f071} %1')       --   (ccls)
--     end
--   }
-- }

-- FIXME: language server current function
-- gl.section.left[9] = {
--   CocFunction = {
--     icon = 'λ ',
--     highlight = {colors.gray, colors.bg},
--     condition = condition.hide_in_width,
--     provider = function()
--       local has_func, func_name = pcall(vim.api.nvim_buf_get_var, 0, 'coc_current_function')
--       if not has_func then return '' end
--       return func_name or ''
--     end,
--   }
-- }

gl.section.right[1] = {
  FileType = {
    highlight = {colors.gray, colors.bg},
    provider = function()
      local buf = require('galaxyline.provider_buffer')
      return string.lower(buf.get_buffer_filetype())
    end,
  }
}

gl.section.right[2] = {
  GitBranch = {
    icon = '󰊢 ',
    separator = '  ',
    highlight = {colors.teal, colors.bg},
    provider = 'GitBranch',
    condition = combine(
      condition.hide_in_width,
      condition.check_git_workspace
    ),
  }
}

gl.section.right[3] = {
  FileLocation = {
    icon = ' ',
    separator = ' ',
    separator_highlight = {colors.bg_dim, colors.bg},
    highlight = {colors.gray, colors.bg_dim},
    provider = function()
      local current_col = vim.fn.col('.')
      local total_cols = vim.fn.col('$')
      local suffix = ' ' .. current_col .. ':' .. total_cols

      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')

      if current_line == 1 then
        return 'Top' .. suffix
      elseif current_line == total_lines then
        return 'Bot' .. suffix
      end

      local percent, _ = math.modf((current_line / total_lines) * 100)
      return '' .. percent .. '%' .. suffix
    end,
  }
}

vim.api.nvim_command('hi GalaxyViModeReverse guibg=' .. colors.bg_dim)

gl.section.right[4] = {
  ViMode = {
    icon = ' ',
    separator = ' ',
    separator_highlight = 'GalaxyViModeReverse',
    highlight = {colors.bg, mode_color()},
    provider = function()
      local m = vim.fn.mode() or vim.fn.visualmode()
      local mode = mode_alias(m)
      local color = mode_color(m)
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. color)
      vim.api.nvim_command('hi GalaxyViModeReverse guibg=' .. colors.bg_dim .. ' guifg=' .. color)
      return ' ' .. mode .. ' '
    end,
  }
}
