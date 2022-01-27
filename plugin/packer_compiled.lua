-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\Bury\\AppData\\Local\\Temp/nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\Bury\\AppData\\Local\\Temp/nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\Bury\\AppData\\Local\\Temp/nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\Bury\\AppData\\Local\\Temp/nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\Bury\\AppData\\Local\\Temp/nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["AckslD/nvim-neoclip.lua"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\AckslD/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["Chiel92/vim-autoformat"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Chiel92/vim-autoformat",
    url = "https://github.com/Chiel92/vim-autoformat"
  },
  ["Yggdroot/indentLine"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Yggdroot/indentLine",
    url = "https://github.com/Yggdroot/indentLine"
  },
  ["andrejlevkovitch/vim-lua-format"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\andrejlevkovitch/vim-lua-format",
    url = "https://github.com/andrejlevkovitch/vim-lua-format"
  },
  ["arkav/lualine-lsp-progress"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\arkav/lualine-lsp-progress",
    url = "https://github.com/arkav/lualine-lsp-progress"
  },
  ["christoomey/vim-tmux-navigator"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\christoomey/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["eddyekofo94/gruvbox-flat.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\eddyekofo94/gruvbox-flat.nvim",
    url = "https://github.com/eddyekofo94/gruvbox-flat.nvim"
  },
  ["hrsh7th/cmp-buffer"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hrsh7th/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["hrsh7th/cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hrsh7th/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["hrsh7th/cmp-path"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hrsh7th/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["hrsh7th/cmp-vsnip"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hrsh7th/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["hrsh7th/nvim-cmp"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hrsh7th/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["hrsh7th/vim-vsnip"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hrsh7th/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["hrsh7th/vim-vsnip-integ"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hrsh7th/vim-vsnip-integ",
    url = "https://github.com/hrsh7th/vim-vsnip-integ"
  },
  ["iamcco/markdown-preview.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\iamcco/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["ilyachur/cmake4vim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\ilyachur/cmake4vim",
    url = "https://github.com/ilyachur/cmake4vim"
  },
  ["kevinhwang91/nvim-bqf"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\kevinhwang91/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["kyazdani42/nvim-tree.lua"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\kyazdani42/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["kyazdani42/nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\kyazdani42/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["lervag/vimtex"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lervag/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["lewis6991/gitsigns.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lewis6991/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["mg979/vim-visual-multi"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\mg979/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["neovim/nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neovim/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["norcalli/nvim-colorizer.lua"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\norcalli/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lua/plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lua/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["nvim-lualine/lualine.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lualine/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-telescope/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["nvim-telescope/telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-telescope/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["preservim/nerdcommenter"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\preservim/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["rafamadriz/friendly-snippets"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\rafamadriz/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["ray-x/lsp_signature.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\ray-x/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["romgrk/barbar.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\romgrk/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["tami5/lspsaga.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tami5/lspsaga.nvim",
    url = "https://github.com/tami5/lspsaga.nvim"
  },
  ["tpope/vim-dispatch"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tpope/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["tpope/vim-surround"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tpope/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["wbthomason/packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\wbthomason/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["windwp/nvim-autopairs"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\windwp/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["xubury/toolchains"] = {
    loaded = true,
    path = "C:\\Users\\Bury\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\xubury/toolchains",
    url = "https://github.com/xubury/toolchains"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
