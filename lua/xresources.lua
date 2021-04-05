-- ========================================
-- Function to get colors from xresources
-- ========================================
local function get_xresources_color (c)
   local command = io.popen('xrdb -query | grep ' .. c .. ' -m 1 | cut -f 2')
   local color = command:read("*l")
   return color
end

-- ======================================
-- funtion to get lighter color
-- ======================================
local function get_lighter_color(c, hex)
   local before_color = get_xresources_color(c)
   local t = tostring(before_color)
   local s = string.sub(t, 2, 7)
   local after_color = tonumber('0x' .. s) + hex
   local final_color = "#" .. string.format("%x", after_color)
   return final_color
end

-- ======================================
-- funtion to get darker color
-- ======================================
local function get_darker_color(c, hex)
   local before_color = get_xresources_color(c)
   local t = tostring(before_color)
   local s = string.sub(t, 2, 7)
   local after_color = tonumber('0x' .. s) - hex
   local final_color = "#" .. string.format("%x", after_color)
   return final_color
end

-- =================
-- Color properties
-- =================
local xresources = {
   fg = get_xresources_color('foreground');
   bg = get_xresources_color('background');
   black = get_xresources_color('color0');
   red = get_xresources_color('color1');
   green = get_xresources_color('color2');
   yellow =get_xresources_color('color3');
   blue = get_xresources_color('color4');
   purple = get_xresources_color('color5'),
   cyan = get_xresources_color('color6');
   white = get_xresources_color('color7');
   light_black = get_xresources_color('color8');
   light_red = get_xresources_color('color9');
   light_green = get_xresources_color('color10');
   light_yellow = get_xresources_color('color11');
   light_blue = get_xresources_color('color12');
   light_purple = get_xresources_color('color13');
   ligt_cyan = get_xresources_color('color14');
   light_white = get_xresources_color('color15');
   grey = vim.o.background == 'light' and get_darker_color('background', 0xf0f10) or get_lighter_color('background', 0xf0f10);
   grey1 = vim.o.background == 'light' and get_darker_color('background', 0x363940) or get_lighter_color('background', 0x363940);
   none = 'NONE';
}

-- ======================
-- Terminal colors
-- ======================
function xresources.terminal_color()
   vim.g.terminal_color_0 = xresources.bg
   vim.g.terminal_color_1 = xresources.red
   vim.g.terminal_color_2 = xresources.green
   vim.g.terminal_color_3 = xresources.yellow
   vim.g.terminal_color_4 = xresources.blue
   vim.g.terminal_color_5 = xresources.purple
   vim.g.terminal_color_6 = xresources.cyan
   vim.g.terminal_color_7 = xresources.fg
   vim.g.terminal_color_8 = xresources.bg
   vim.g.terminal_color_9 = xresources.red
   vim.g.terminal_color_10 = xresources.green
   vim.g.terminal_color_11 = xresources.yellow
   vim.g.terminal_color_12 = xresources.blue
   vim.g.terminal_color_13 = xresources.purple
   vim.g.terminal_color_14 = xresources.cyan
   vim.g.terminal_color_15 = xresources.fg
end

-- ====================
-- Highlight function
-- ====================
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

      -- ==================
      -- Syntax group
      -- ===================
      Boolean = {fg=xresources.yellow};
      Comment = {fg=xresources.grey1};
      Constant = {fg=xresources.cyan};
      Character = {fg=xresources.green};
      Conditional = {fg=xresources.purple};
      Debug = {};
      Define = {fg=xresources.purple};
      Delimiter = {};
      Error = {fg=xresources.red};
      Exception = {fg=xresources.purple};
      Float = {fg=xresources.yellow};
      Function = {fg=xresources.blue};
      Identifier = {fg=xresources.red};
      Ignore = {};
      Include = {fg=xresources.blue};
      Keyword = {fg=xresources.red};
      Label = {fg=xresources.purple};
      Macro = {fg=xresources.purple};
      Number = {fg=xresources.yellow};
      Operator = {fg=xresources.purple};
      PreProc = {fg=xresources.yellow};
      PreCondit = {fg=xresources.yellow};
      Repeat = {fg=xresources.purple};
      Statement = {fg=xresources.purple};
      StorageClass = {fg=xresources.yellow};
      Special = {fg=xresources.blue};
      SpecialChar = {fg=xresources.yellow};
      Structure = {fg=xresources.yellow};
      String = {fg=xresources.green};
      SpecialComment = {fg=xresources.grey1};
      Typedef = {fg=xresources.yellow};
      Tag = {};
      Type = {fg=xresources.yellow};
      Todo = {fg=xresources.purple};
      Underlined = {fg=xresources.none,style='underline'};

      -- =============
      -- Treesitter
      -- ==============
      TSError = { fg = xresources.red };
      TSPunctDelimitter = {};
      TSPunctBracket = {fg = xresources.cyan};
      TSPunctSpecial = { fg = xresources.blue };
      TSConstant = { fg = xresources.cyan };
      TSConstBuiltin = { fg = xresources.cyan };
      TSContMacro = { fg = xresources.purple };
      TSString = { fg = xresources.green };
      TSStringRegex = { fg = xresources.red };
      TSCharacter = { fg = xresources.green };
      TSNumber = { fg = xresources.yellow };
      TSBoolean = { fg = xresources.yellow };
      TSFloat = { fg = xresources.yellow };
      TSAnnotation = { fg = xresources.blue };
      TSAttribute = { fg = xresources.yellow };
      TSNamespace = { fg = xresources.purple };
      TSFunctionBuiltin = { fg = xresources.blue };
      TSFunction = { fg = xresources.blue };
      TSFuncMacro = { fg = xresources.blue };
      TSParameter = { fg = xresources.red };
      TSParameterReference = { fg = xresources.red };
      TSMethod = { fg = xresources.yellow };
      TSField = { fg = xresources.red };
      TSProperty = { fg = xresources.red };
      TSConstructor = { fg = xresources.cyan };
      TSConditional= { fg = xresources.purple };
      TSRepeat= { fg = xresources.purple };
      TSLabel= { fg = xresources.purple };
      TSKeyword= { fg = xresources.red };
      TSKeywordFunction= { fg = xresources.cyan };
      TSKeywordOperator= { fg = xresources.purple };
      TSOperator= { fg = xresources.purple };
      TSExeption= { fg = xresources.purple };
      TSType= { fg = xresources.yellow };
      TSTypeBuiltin= { fg = xresources.yellow };
      TSStructure= { fg = xresources.yellow };
      TSInclude= { fg = xresources.blue };
      TSVariable= {fg = xresources.fg};
      TSVariableBuiltin= { fg = xresources.cyan };
      TSText= {};
      TSStrong= { fg = xresources.purple };
      TSEmphasis= { fg = xresources.cyan };
      TSUnderline= { fg = xresources.yellow };
      TSTitle= { fg = xresources.yellow };
      TSLiteral= { fg = xresources.green };
      TSUri= { fg = xresources.green };
      TSTag= {};
      TSTagDelimitter= {};

      -- ===================
      -- Highlight Group
      -- ===================
      BufferInactive= { fg=xresources.fg,bg=xresources.grey };
      BufferInactiveTarge = { fg=xresources.fg, bg=xresources.grey };
      BufferInactiveSign = { fg=xresources.blue, bg=xresources.grey };
      BufferCurrent = { fg=xresources.yellow, bg=xresources.bg, style ='bold'};
      BufferCurrentSign = { fg=xresources.blue, bg=xresources.bg };
      BufferTabPageFill = { fg=xresources.blue, bg=xresources.bg };
      BufferCurrentMod = { fg=xresources.blue, bg=xresources.bg };
      BufferInactiveMod = { fg=xresources.blue, bg=xresources.grey };
      ColorColumn = {fg=xresources.none,bg=xresources.grey};
      Conceal = {fg=xresources.grey,bg=xresources.none};
      CursorLineNr = {fg=xresources.blue};
      CursorIM = {fg=xresources.none,bg=xresources.none,style='reverse'};
      CursorColumn = {fg=xresources.none,bg=xresources.grey};
      CursorLine = {fg=xresources.none,bg=xresources.grey};
      Cursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      DiffAdd = {fg=xresources.bg,bg=xresources.green};
      DiffChange = {fg=xresources.bg,bg=xresources.yellow};
      DiffDelete = {fg=xresources.bg,bg=xresources.red};
      DiffText = {fg=xresources.bg,bg=xresources.fg};
      Directory = {fg=xresources.grey,bg=xresources.none};
      debugBreakpoint = {fg=xresources.bg,bg=xresources.red};
      EndOfBuffer = {fg=xresources.bg,bg=xresources.none};
      ErrorMsg = {fg=xresources.red,bg=xresources.none,style='bold'};
      FoldColumn = {fg=xresources.fg,bg=xresources.bg};
      Folded = {fg=xresources.grey,bg=xresources.grey};
      iCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      IncSearch = {fg=xresources.grey,bg=xresources.yellow,style=xresources.none};
      lCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      LineNr = {fg=xresources.grey1};
      ModeMsg = {fg=xresources.fg,bg=xresources.none,style='bold'};
      MatchParen = {fg=xresources.red,bg=xresources.none};
      Normal = {fg = xresources.fg,bg=xresources.bg};
      NormalFloat = {fg=xresources.white,bg=xresources.grey};
      NonText = {fg=xresources.grey};
      Pmenu = {fg=xresources.fg,bg=xresources.grey};
      PmenuSel = {fg=xresources.grey,bg=xresources.blue};
      PmenuSelBold = {fg=xresources.grey,g=xresources.blue};
      PmenuSbar = {fg=xresources.none,bg=xresources.grey};
      PmenuThumb = {fg=xresources.purple,bg=xresources.green};
      Question = {fg=xresources.yellow};
      QuickFixLine = {fg=xresources.purple,style='bold'};
      StatusLine = {fg=xresources.grey,bg=xresources.grey,style=xresources.none};
      StatusLineNC = {fg=xresources.grey,bg=xresources.grey,style=xresources.none};
      SpellBad = {fg=xresources.red,bg=xresources.none,style='undercurl'};
      SpellCap = {fg=xresources.blue,bg=xresources.none,style='undercurl'};
      SpellLocal = {fg=xresources.cyan,bg=xresources.none,style='undercurl'};
      SpellRare = {fg=xresources.purple,bg=xresources.none,style = 'undercurl'};
      SignColumn = {fg=xresources.fg,bg=xresources.bg};
      Search = {fg=xresources.bg,bg=xresources.yellow};
      SpecialKey = {fg=xresources.grey};
      TabLineSel = {bg=xresources.bg};
      Title = {fg=xresources.green,style='bold'};
      Terminal = {fg = xresources.fg,bg=xresources.bg};
      TabLineFill = {style=xresources.none};
      VertSplit = {fg=xresources.grey,bg=xresources.grey};
      vCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      WarningMsg = {fg=xresources.yellow,bg=xresources.none,style='bold'};
      Whitespace = {fg=xresources.grey};
      WildMenu = {fg=xresources.fg,bg=xresources.green};
      Visual = {fg=xresources.none,bg=xresources.grey};
      VisualNOS = {fg=xresources.bg,bg=xresources.fg};
   }
   return syntax
end

-- ================================
-- Language specific highlighting
-- ================================
function xresources.load_plugin_syntax()
   local plugin_syntax = {

      -- ================
      -- CSS
      -- ================
      cssAttrComma= {fg=xresources.purple};
      cssAttributeSelector= {fg=xresources.green};
      cssBraces= {fg=xresources.white};
      cssClassName= {fg=xresources.yellow};
      cssClassNameDot= {fg=xresources.yellow};
      cssDefinition= {fg=xresources.purple};
      cssFontAttr= {fg=xresources.yellow};
      cssFontDescriptor= {fg=xresources.purple};
      cssFunctionName= {fg=xresources.blue};
      cssIdentifier= {fg=xresources.blue};
      cssImportant= {fg=xresources.purple};
      cssInclude= {fg=xresources.white};
      cssIncludeKeyword= {fg=xresources.purple};
      cssMediaType= {fg=xresources.yellow};
      cssProp= {fg=xresources.white};
      cssPseudoClassId= {fg=xresources.yellow};
      cssSelectorOp= {fg=xresources.purple};
      cssSelectorOp2= {fg=xresources.purple};
      cssTagName= {fg=xresources.red};

      -- ================
      -- GO
      -- =================
      goDeclaration= {fg=xresources.purple};
      goBuiltins= {fg=xresources.cyan};
      goFunctionCall= {fg=xresources.blue};
      goVarDefs= {fg=xresources.red};
      goVarAssign= {fg=xresources.red};
      goVar= {fg=xresources.purple};
      goConst= {fg=xresources.purple};
      goType= {fg=xresources.yellow};
      goTypeName= {fg=xresources.yellow};
      goDeclType= {fg=xresources.cyan};
      goTypeDecl= {fg=xresources.purple};

      -- ==============
      -- JavaScript
      -- ==============
      javaScriptBraces={fg = xresources.yellow };
      javaScriptFunction ={ fg =xresources.purple };
      javaScriptIdentifier = { fg = xresources.purple };
      javaScriptNull = { fg = xresources.yellow };
      javaScriptNumber ={ fg = xresources.yellow };
      javaScriptRequire ={ fg =xresources.cyan };
      javaScriptReserved = { fg = xresources.purple };
      -- ==============================================
      -- https://github.com/pangloss/vim-javascript
      -- ==============================================
      jsArrowFunction = { fg = xresources.purple };
      jsClassKeyword ={ fg = xresources.purple };
      jsClassMethodType = { fg = xresources.purple };
      jsDocParam = { fg = xresources.blue };
      jsDocTags ={ fg = xresources.purple };
      jsExport ={ fg = xresources.purple };
      jsExportDefault ={ fg = xresources.purple };
      jsExtendsKeyword = { fg = xresources.purple };
      jsFrom = { fg = xresources.purple };
      jsFuncCall = { fg = xresources.blue };
      jsFunction ={ fg = xresources.purple };
      jsGenerator = { ffg = xresources.yellow };
      jsGlobalObjects = { fg = xresources.yellow };
      jsImport ={ fg = xresources.purple };
      jsModuleAs = { fg = xresources.purple };
      jsModuleWords = { fg = xresources.purple };
      jsModules ={ fg = xresources.purple };
      jsNull ={ fg = xresources.yellow };
      jsOperator = { fg = xresources.purple };
      jsStorageClass = { fg = xresources.purple };
      jsSuper = { fg = xresources.red };
      jsTemplateBraces = { fg = xresources.red };
      jsTemplateVar ={ fg = xresources.green };
      jsThis = { fg = xresources.red };
      jsUndefined = { fg = xresources.yellow };
      -- =====================================
      --  https://github.com/othree/yajs.vim
      --  =======================================
      javascriptArrowFunc ={ fg = xresources.purple };
      javascriptClassExtends = { fg = xresources.purple };
      javascriptClassKeyword ={ fg = xresources.purple };
      javascriptDocNotation ={ fg = xresources.purple };
      javascriptDocParamName = { fg = xresources.blue };
      javascriptDocTags ={ fg = xresources.purple };
      javascriptEndColons = { fg = xresources.white };
      javascriptExport ={ fg = xresources.purple };
      javascriptFuncArg ={ fg = xresources.white };
      javascriptFuncKeyword ={ fg = xresources.purple };
      javascriptIdentifier ={ fg = xresources.red };
      javascriptImport ={ fg = xresources.purple };
      javascriptMethodName ={ fg =xresources.white };
      javascriptObjectLabel = { fg =xresources.white };
      javascriptOpSymbol= { fg =xresources.cyan};
      javascriptOpSymbols ={ fg = xresources.syan };
      javascriptPropertyName = { fg = xresources.green };
      javascriptTemplateSB = { fg = xresources.red };
      javascriptVariable ={ fg = xresources.purple };

      -- ============
      -- Vim
      -- ============
      vimCommentTitle = {fg=xresources.grey};
      vimLet = {fg=xresources.yellow};
      vimVar = {fg=xresources.cyan};
      vimFunction = {fg=xresources.purple};
      vimIsCommand = {fg=xresources.fg};
      vimCommand = {fg=xresources.blue};
      vimNotFunc = {fg=xresources.purple};
      vimUserFunc = {fg=xresources.yellow};
      vimFuncName= {fg=xresources.yellow};

      -- =======
      -- Diff
      -- ========
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

      -- ===================
      -- Vim GitGutter
      -- ==================
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

      -- =========================
      -- Neovim LSP
      -- =========================
      LspDiagnosticsSignError = {fg=xresources.red};
      LspDiagnosticsSignWarning = {fg=xresources.yellow};
      LspDiagnosticsSignInformation = {fg=xresources.blue};
      LspDiagnosticsSignHint = {fg=xresources.cyan};
      LspDiagnosticsVirtualTextError = {fg=xresources.red};
      LspDiagnosticsVirtualTextWarning= {fg=xresources.yellow};
      LspDiagnosticsVirtualTextInformation = {fg=xresources.green};
      LspDiagnosticsVirtualTextHint = {fg=xresources.yellow};
      LspDiagnosticsUnderlineError = {style="undercurl",sp=xresources.red};
      LspDiagnosticsUnderlineWarning = {style="undercurl",sp=xresources.yellow};
      LspDiagnosticsUnderlineInformation = {style="undercurl",sp=xresources.blue};
      LspDiagnosticsUnderlineHint = {style="undercurl",sp=xresources.cyan};

      CursorWord0 = {bg=xresources.grey};
      CursorWord1 = {bg=xresources.grey};

      -- ==================
      -- Nvim Tree
      -- ==================
      NvimTreeFolderName = {fg=xresources.cyan};
      NvimTreeRootFolder = {fg=xresources.red};
      NvimTreeSpecialFile = {fg=xresources.fg,bg=xresources.none,stryle='NONE'};
      NvimTreeFolderIcon = { fg = xresources.blue};
      -- ==================
      -- Telescope Nvim
      -- ==================
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
