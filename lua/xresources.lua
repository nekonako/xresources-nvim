local function get_xresources_color (c)
   local command = io.popen('xrdb -query | grep ' .. c .. ' -m 1 | cut -f 2')
   local color = command:read("*l")
   return color
end

local function get_lighter_color(c, hex)
   local command = io.popen("xrdb -query | grep " .. c .. " -m 1 | cut -f 2")
   local before_color = command:read("*l")
   local t = tostring(before_color)
   local s = string.sub(t, 2, 7)
   local after_color = tonumber('0x' .. s) + hex
   local final_color = "#" .. string.format("%x", after_color)
   return final_color
end

local function get_darker_color(c, hex)
   local command = io.popen("xrdb -query | grep " .. c .. " -m 1 | cut -f 2")
   local before_color = command:read("*l")
   local t = tostring(before_color)
   local s = string.sub(t, 2, 7)
   local after_color = tonumber('0x' .. s) - hex
   local final_color = "#" .. string.format("%x", after_color)
   return final_color
end

local xresources = {
   fg = get_xresources_color('foreground');
   bg = get_xresources_color('background');
   red = get_xresources_color('color1');
   green = get_xresources_color('color2');
   yellow =get_xresources_color('color3');
   blue = get_xresources_color('color4');
   purple = get_xresources_color('color5'),
   cyan = get_xresources_color('color6');
   grey = get_lighter_color('background', 0xf0f10);
   grey1 = get_lighter_color('background', 0x363940);
   none = 'NONE';
}

function xresources.terminal_color()
   vim.g.terminal_color_0 = xresources.bg
   vim.g.terminal_color_1 = xresources.red
   vim.g.terminal_color_2 = xresources.green
   vim.g.terminal_color_3 = xresources.yellow
   vim.g.terminal_color_4 = xresources.blue
   vim.g.terminal_color_5 = xresources.purple
   vim.g.terminal_color_6 = xresources.cyan
   vim.g.terminal_color_7 = xresources.bg
   vim.g.terminal_color_8 = xresources.fg
   vim.g.terminal_color_9 = xresources.red
   vim.g.terminal_color_10 = xresources.green
   vim.g.terminal_color_11 = xresources.yellow
   vim.g.terminal_color_12 = xresources.blue
   vim.g.terminal_color_13 = xresources.purple
   vim.g.terminal_color_14 = xresources.cyan
   vim.g.terminal_color_15 = xresources.fg
end

function xresources.highlight(group, color)
   local style = color.style and 'gui=' .. color.style or 'gui=NONE'
   local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
   local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
   local sp = color.sp and 'guisp=' .. color.sp or ''
   vim.api.nvim_command('highlight ' .. group .. ' ' .. style .. ' ' .. fg ..
      ' ' .. bg..' '..sp)
end


function xresources.load_syntax()
   local syntax = {
      Normal = {fg = xresources.fg,bg=xresources.bg};
      Terminal = {fg = xresources.fg,bg=xresources.bg};
      SignColumn = {fg=xresources.fg,bg=xresources.bg};
      FoldColumn = {fg=xresources.fg,bg=xresources.bg};
      VertSplit = {fg=xresources.grey,bg=xresources.grey};
      Folded = {fg=xresources.grey,bg=xresources.grey};
      EndOfBuffer = {fg=xresources.bg,bg=xresources.none};
      IncSearch = {fg=xresources.gray,bg=xresources.yellow,style=xresources.none};
      Search = {fg=xresources.bg,bg=xresources.yellow};
      ColorColumn = {fg=xresources.none,bg=xresources.grey};
      Conceal = {fg=xresources.grey,bg=xresources.none};
      Cursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      vCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      iCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      lCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      CursorIM = {fg=xresources.none,bg=xresources.none,style='reverse'};
      CursorColumn = {fg=xresources.none,bg=xresources.grey};
      CursorLine = {fg=xresources.none,bg=xresources.grey};
      LineNr = {fg=xresources.grey1};
      CursorLineNr = {fg=xresources.blue};
      DiffAdd = {fg=xresources.bg,bg=xresources.green};
      DiffChange = {fg=xresources.bg,bg=xresources.yellow};
      DiffDelete = {fg=xresources.bg,bg=xresources.red};
      DiffText = {fg=xresources.bg,bg=xresources.fg};
      Directory = {fg=xresources.gray,bg=xresources.none};
      ErrorMsg = {fg=xresources.red,bg=xresources.none,style='bold'};
      WarningMsg = {fg=xresources.yellow,bg=xresources.none,style='bold'};
      ModeMsg = {fg=xresources.fg,bg=xresources.none,style='bold'};
      MatchParen = {fg=xresources.red,bg=xresources.none};
      NonText = {fg=xresources.gray};
      Whitespace = {fg=xresources.grey};
      SpecialKey = {fg=xresources.gray};
      Pmenu = {fg=xresources.fg,bg=xresources.grey};
      PmenuSel = {fg=xresources.grey,bg=xresources.blue};
      PmenuSelBold = {fg=xresources.grey,g=xresources.blue};
      PmenuSbar = {fg=xresources.none,bg=xresources.grey};
      PmenuThumb = {fg=xresources.purple,bg=xresources.green};
      WildMenu = {fg=xresources.fg,bg=xresources.green};
      Question = {fg=xresources.yellow};
      NormalFloat = {fg=xresources.grey,bg=xresources.grey};
      TabLineFill = {style=xresources.none};
      TabLineSel = {bg=xresources.bg};
      StatusLine = {fg=xresources.grey,bg=xresources.grey,style=xresources.none};
      StatusLineNC = {fg=xresources.grey,bg=xresources.grey,style=xresources.none};
      SpellBad = {fg=xresources.red,bg=xresources.none,style='undercurl'};
      SpellCap = {fg=xresources.blue,bg=xresources.none,style='undercurl'};
      SpellLocal = {fg=xresources.cyan,bg=xresources.none,style='undercurl'};
      SpellRare = {fg=xresources.purple,bg=xresources.none,style = 'undercurl'};
      Visual = {fg=xresources.bg,bg=xresources.fg};
      VisualNOS = {fg=xresources.bg,bg=xresources.fg};
      QuickFixLine = {fg=xresources.purple,style='bold'};
      Debug = {fg=xresources.yellow};
      debugBreakpoint = {fg=xresources.bg,bg=xresources.red};

      Boolean = {fg=xresources.yellow};
      Number = {fg=xresources.red};
      Float = {fg=xresources.red};
      PreProc = {fg=xresources.purple};
      PreCondit = {fg=xresources.purple};
      Include = {fg=xresources.purple};
      Define = {fg=xresources.purple};
      Conditional = {fg=xresources.purple};
      Repeat = {fg=xresources.purple};
      Keyword = {fg=xresources.green};
      Typedef = {fg=xresources.red};
      Exception = {fg=xresources.red};
      Statement = {fg=xresources.red};
      Error = {fg=xresources.red};
      StorageClass = {fg=xresources.yellow};
      Tag = {fg=xresources.yellow};
      Label = {fg=xresources.yellow};
      Structure = {fg=xresources.yellow};
      Operator = {fg=xresources.purple};
      Title = {fg=xresources.yellow,style='bold'};
      Special = {fg=xresources.yellow};
      SpecialChar = {fg=xresources.yellow};
      Type = {fg=xresources.yellow};
      Function = {fg=xresources.yellow};
      String = {fg=xresources.green};
      Character = {fg=xresources.green};
      Constant = {fg=xresources.cyan};
      Macro = {fg=xresources.cyan};
      Identifier = {fg=xresources.blue};

      Comment = {fg=xresources.grey1};
      SpecialComment = {fg=xresources.grey};
      Todo = {fg=xresources.purple};
      Delimiter = {fg=xresources.fg};
      Ignore = {fg=xresources.grey};
      Underlined = {fg=xresources.none,style='underline'};

      BufferInactive= { fg=xresources.fg,bg=xresources.grey };
      BufferInactiveTarge = { fg=xresources.fg, bg=xresources.grey };
      BufferInactiveSign = { fg=xresources.blue, bg=xresources.grey };
      BufferCurrent = { fg=xresources.blue, bg=xresources.bg };
      BufferCurrentSign = { fg=xresources.blue, bg=xresources.bg };
      BufferTabPageFill = { fg=xresources.blue, bg=xresources.grey };
      BufferCurrentMod = { fg=xresources.blue, bg=xresources.bg };
      BufferInactiveMod = { fg=xresources.blue, bg=xresources.grey };

   }
   return syntax
end

function xresources.load_plugin_syntax()
   local plugin_syntax = {
      TSFunction = {fg=xresources.cyan};
      TSMethod = {fg=xresources.cyan};
      TSKeywordFunction = {fg=xresources.red};
      TSProperty = {fg=xresources.yellow};
      TSType = {fg=xresources.cyan};
      TSPunctcyan = {fg=xresources.cyan};

      vimCommentTitle = {fg=xresources.grey,style='bold'};
      vimLet = {fg=xresources.yellow};
      vimVar = {fg=xresources.cyan};
      vimFunction = {fg=xresources.purple};
      vimIsCommand = {fg=xresources.fg};
      vimCommand = {fg=xresources.blue};
      vimNotFunc = {fg=xresources.purple,style='bold'};
      vimUserFunc = {fg=xresources.yellow,style='bold'};
      vimFuncName= {fg=xresources.yellow,style='bold'};

      diffAdded = {fg = xresources.green};
      diffRemoved = {fg =xresources.red};
      diffChanged = {fg = xresources.blue};
      diffOldFile = {fg = xresources.yellow};
      diffNewFile = {fg = xresources.yellow};
      diffFile    = {fg = xresources.aqua};
      diffLine    = {fg = xresources.grey};
      diffIndexLine = {fg = xresources.purple};

      gitcommitSummary = {fg = xresources.red};
      gitcommitUntracked = {fg = xresources.grey};
      gitcommitDiscarded = {fg = xresources.grey};
      gitcommitSelected = { fg=xresources.grey};
      gitcommitUnmerged = { fg=xresources.grey};
      gitcommitOnBranch = { fg=xresources.grey};
      gitcommitArrow  = {fg = xresources.grey};
      gitcommitFile  = {fg = xresources.green};

      Vistacyan = {fg=xresources.grey};
      VistaChildrenNr = {fg=xresources.yellow};
      VistaKind = {fg=xresources.purple};
      VistaScope = {fg=xresources.red};
      VistaScopeKind = {fg=xresources.blue};
      VistaTag = {fg=xresources.purple,style='bold'};
      VistaPrefix = {fg=xresources.grey};
      VistaColon = {fg=xresources.purple};
      VistaIcon = {fg=xresources.yellow};
      VistaLineNr = {fg=xresources.fg};

      GitGutterAdd = {fg=xresources.green};
      GitGutterChange = {fg=xresources.blue};
      GitGutterDelete = {fg=xresources.red};
      GitGutterChangeDelete = {fg=xresources.purple};

      SignifySignAdd = {fg=xresources.green};
      SignifySignChange = {fg=xresources.blue};
      SignifySignDelete = {fg=xresources.red};

      dbui_tables = {fg=xresources.blue};

      DashboardShortCut = {fg=xresources.purple};
      DashboardHeader = {fg=xresources.yellow};
      DashboardCenter = {fg=xresources.blue};
      DashboardFooter = {fg=xresources.grey};

      LspDiagnosticsSignError = {fg=xresources.red};
      LspDiagnosticsSignWarning = {fg=xresources.yellow};
      LspDiagnosticsSignInformation = {fg=xresources.blue};
      LspDiagnosticsSignHint = {fg=xresources.cyan};

      LspDiagnosticsVirtualTextError = {fg=xresources.red};
      LspDiagnosticsVirtualTextWarning= {fg=xresources.yellow};
      LspDiagnosticsVirtualTextInformation = {fg=xresources.blue};
      LspDiagnosticsVirtualTextHint = {fg=xresources.cyan};

      LspDiagnosticsUnderlineError = {style="undercurl",sp=xresources.red};
      LspDiagnosticsUnderlineWarning = {style="undercurl",sp=xresources.yellow};
      LspDiagnosticsUnderlineInformation = {style="undercurl",sp=xresources.blue};
      LspDiagnosticsUnderlineHint = {style="undercurl",sp=xresources.cyan};

      CursorWord0 = {bg=xresources.gray};
      CursorWord1 = {bg=xresources.gray};

      NvimTreeFolderName = {fg=xresources.cyan};
      NvimTreeRootFolder = {fg=xresources.red};
      NvimTreeSpecialFile = {fg=xresources.fg,bg=xresources.none,stryle='NONE'};

      TelescopeBorder = {fg=xresources.cyan};
      TelescopePromptBorder = {fg=xresources.blue}
   }
   return plugin_syntax
end

local async_load_plugin

async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function ()
   xresources.terminal_color()
   local syntax = xresources.load_plugin_syntax()
   for group,colors in pairs(syntax) do
      xresources.highlight(group,colors)
   end
   async_load_plugin:close()
end))

function xresources.colorscheme()
   vim.api.nvim_command('hi clear')
   if vim.fn.exists('syntax_on') then
      vim.api.nvim_command('syntax reset')
   end
   vim.o.background = 'dark'
   vim.o.termguicolors = true
   vim.g.colors_name = 'xresources'
   local syntax = xresources.load_syntax()
   for group,colors in pairs(syntax) do
      xresources.highlight(group,colors)
   end
   async_load_plugin:send()
end

xresources.colorscheme()

return xresources
