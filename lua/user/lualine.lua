local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnosticss = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

 -- Show debugging info in lualine - https://github.com/nvim-lualine/lualine.nvim/discussions/911
local utils = require("lualine.utils.utils")
local highlight = require("lualine.highlight")

local diagnostics_message = require("lualine.component"):extend()

diagnostics_message.default = {
	colors = {
		error = utils.extract_color_from_hllist(
			{ "fg", "sp" },
			{ "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
			"#e32636"
		),
		warning = utils.extract_color_from_hllist(
			{ "fg", "sp" },
			{ "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
			"#ffa500"
		),
		info = utils.extract_color_from_hllist(
			{ "fg", "sp" },
			{ "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
			"#ffffff"
		),
		hint = utils.extract_color_from_hllist(
			{ "fg", "sp" },
			{ "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
			"#273faf"
		),
	},
}
function diagnostics_message:init(options)
	diagnostics_message.super:init(options)
	self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
	self.highlights = { error = "", warn = "", info = "", hint = "" }
	self.highlights.error = highlight.create_component_highlight_group(
		{ fg = self.options.colors.error },
		"diagnostics_message_error",
		self.options
	)
	self.highlights.warn = highlight.create_component_highlight_group(
		{ fg = self.options.colors.warn },
		"diagnostics_message_warn",
		self.options
	)
	self.highlights.info = highlight.create_component_highlight_group(
		{ fg = self.options.colors.info },
		"diagnostics_message_info",
		self.options
	)
	self.highlights.hint = highlight.create_component_highlight_group(
		{ fg = self.options.colors.hint },
		"diagnostics_message_hint",
		self.options
	)
end

function diagnostics_message:update_status(is_focused)
  table.unpack = table.unpack or unpack
	local r, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
	local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
	if #diagnostics > 0 then
		local diag = diagnostics[1]
		for _, d in ipairs(diagnostics) do
			if d.severity < diag.severity then
				diagnostics = d
			end
		end
		local icons = { " ", " ", " ", " " }
		local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
		return highlight.component_format_highlight(hl[diag.severity]) .. icons[diag.severity] .. " " .. diag.message
	else
		return ""
	end
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {"branch"},
    lualine_c = { {
				diagnostics_message,
				colors = {
					error = "#BF616A",
					warn = "#EBCB8B",
					info = "#A3BE8C",
					hint = "#88C0D0",
				},
			},},
    lualine_x = { diff, spaces, "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
}
