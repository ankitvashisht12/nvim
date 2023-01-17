local colorscheme = "tokyonight-storm" -- "rose-pine"
-- require("tokyonight").setup({
--   on_highlights = function(hl, c)
--     hl.NvimTreeWinSeparator = { bg = "#00ff00", fg = "#1f2335" }
--     hl.NvimTreeOpenedFile = { bg = "#ff0000" }
--       hl.NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_search }
--      hl.NvimTreeNormalNC = { bg = "#1e517d", fg = "#a9b1d6" }
--     hl.NvimTreeRootFolder = { fg = c.blue, style = "bold" }
--      hl.NvimTreeGitDirty = { fg = c.git.change }
--      hl.NvimTreeGitNew = { fg = c.git.add }
--      hl.NvimTreeGitDeleted = { fg = c.git.delete }
--      hl.NvimTreeSpecialFile = { fg = c.purple, style = "underline" }
--      hl.LspDiagnosticsError = { fg = c.error }
--      hl.LspDiagnosticsWarning = { fg = c.warning }
--      hl.LspDiagnosticsInformation = { fg = c.info }
--      hl.LspDiagnosticsHint = { fg = c.hint }
--      hl.NvimTreeIndentMarker = { fg = c.fg_gutter }
--      hl.NvimTreeImageFile = { fg = c.fg_sidebar }
--      hl.NvimTreeSymlink = { fg = c.blue }
--   end,
-- })

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

-- make nvim transparent
-- vim.api.nvim_set_hl(0, "Normal", { background = "none"})
-- vim.api.nvim_set_hl(0, "NormalFloat", { background = "none"})
