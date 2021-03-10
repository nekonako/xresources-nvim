# Xresources-nvim
Neovim colorscheme based on your xresources color

### Require
- Neovim 0.5
- xrdb

### Install
***Vim plug***
```
Plug 'nekonako/xresorces-nvim'
```

### Usage
`lua require('xresources')`
or
colorscheme xresorces

### Preview
!['xresources color by Fikri Omar']('shot-2.png')
!['xresources color by me']('shot-1.png')

### useful function
   ```
local function get_xresources_color (c)
   local command = io.popen('xrdb -query | grep ' .. c .. ' -m 1 | cut -f 2')
   local color = command:read("*l")
   return color
end
   ```

this function get color for xresources, can be use to your plugin

### Thanks
- [Glapnir]('https//github.com/glapnir')
- [elianiva]('https://github.com/elianiva')
- [Fikri Omar]('https://github.com/fikriomar16')
- [Dotfiles indonesia]('https://t.me/dotfiles_id')
- [Vim indonesia]('https://t.me/VimID')


