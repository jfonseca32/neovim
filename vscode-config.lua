local vscode = require("vscode")
local map = vim.keymap.set

local function action(name, opts)
	return function()
		vscode.action(name, opts)
	end
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.timeoutlen = 300

if vim.g.vscode_clipboard then
	vim.g.clipboard = vim.g.vscode_clipboard
end

map("n", "<Esc>", "<cmd>nohlsearch<CR>", {
	desc = "Clear search highlight",
})

map({ "n", "x" }, "<Tab>", "$", {
	desc = "Move to end of line",
})

map({ "n", "x" }, "q", "0", {
	desc = "Move to beginning of line",
})

map("n", "<leader>q", action("workbench.actions.view.problems"), {
	desc = "Open diagnostic [Q]uickfix/Problems",
})

map("n", "<C-h>", action("workbench.action.focusLeftGroup"), {
	desc = "Move focus to the left window",
})

map("n", "<C-l>", action("workbench.action.focusRightGroup"), {
	desc = "Move focus to the right window",
})

map("n", "<C-j>", action("workbench.action.focusBelowGroup"), {
	desc = "Move focus to the lower window",
})

map("n", "<C-k>", action("workbench.action.focusAboveGroup"), {
	desc = "Move focus to the upper window",
})

map("n", "<C-o>", action("workbench.action.navigateBack"), {
	desc = "Jump back",
})

map("n", "<C-i>", action("workbench.action.navigateForward"), {
	desc = "Jump forward",
})

map("n", "<C-t>", action("workbench.action.navigateBack"), {
	desc = "Jump back",
})

vim.api.nvim_create_user_command("DiffOrig", function()
	vscode.action("workbench.files.action.compareWithSaved")
end, {
	force = true,
	desc = "Compare current file with saved version",
})

map("n", "<leader>do", "<cmd>DiffOrig<CR>", {
	desc = "[D]iff [O]riginal",
})

map("n", "<leader>u", action("workbench.action.localHistory.restoreViaPicker"), {
	desc = "[U]ndo / local history",
})

map("n", "<leader>sf", action("workbench.action.quickOpen"), {
	desc = "[S]earch [F]iles",
})

map("n", "<leader>sg", action("workbench.action.findInFiles"), {
	desc = "[S]earch by [G]rep",
})

map({ "n", "x" }, "<leader>sw", function()
	vscode.action("workbench.action.findInFiles", {
		args = { query = vim.fn.expand("<cword>") },
	})
end, {
	desc = "[S]earch current [W]ord",
})

map("n", "<leader>sd", action("workbench.actions.view.problems"), {
	desc = "[S]earch [D]iagnostics",
})

map("n", "<leader>sc", action("workbench.action.showCommands"), {
	desc = "[S]earch [C]ommands",
})

map("n", "<leader>ss", action("workbench.action.showCommands"), {
	desc = "[S]earch [S]elect command",
})

map("n", "<leader>sk", action("workbench.action.openGlobalKeybindings"), {
	desc = "[S]earch [K]eymaps",
})

map("n", "<leader>s.", action("workbench.action.openRecent"), {
	desc = "[S]earch recent files/workspaces",
})

map("n", "<leader>sr", action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup"), {
	desc = "[S]earch [R]ecent editor",
})

map("n", "<leader><leader>", action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup"), {
	desc = "Find existing buffers/editors",
})

map("n", "<leader>/", action("actions.find"), {
	desc = "[/] Search current buffer",
})

map("n", "<leader>s/", action("workbench.action.findInFiles"), {
	desc = "[S]earch [/] in files",
})

map("n", "<leader>sh", action("workbench.action.showCommands"), {
	desc = "[S]earch [H]elp/commands",
})

map("n", "grr", action("editor.action.goToReferences"), {
	desc = "[G]oto [R]eferences",
})

map("n", "gri", action("editor.action.goToImplementation"), {
	desc = "[G]oto [I]mplementation",
})

map("n", "grd", action("editor.action.revealDefinitionAside"), {
	desc = "[G]oto [D]efinition",
})

map("n", "grD", vim.lsp.buf.declaration, {
	desc = "[G]oto [D]eclaration",
})

map("n", "grt", action("editor.action.goToTypeDefinition"), {
	desc = "[G]oto [T]ype Definition",
})

map("n", "grn", action("editor.action.rename"), {
	desc = "[R]e[n]ame",
})

map({ "n", "x" }, "gra", action("editor.action.quickFix"), {
	desc = "[G]oto Code [A]ction",
})

map("n", "gO", action("workbench.action.gotoSymbol"), {
	desc = "Open Document Symbols",
})

map("n", "gW", action("workbench.action.showAllSymbols"), {
	desc = "Open Workspace Symbols",
})

map("n", "K", action("editor.action.showHover"), {
	desc = "Show hover information",
})

map("n", "]d", action("editor.action.marker.nextInFiles"), {
	desc = "Next diagnostic",
})

map("n", "[d", action("editor.action.marker.prevInFiles"), {
	desc = "Previous diagnostic",
})

map("n", "<leader>gs", action("workbench.view.scm"), {
	desc = "[G]it [S]tatus",
})

map("n", "]c", action("workbench.action.editor.nextChange"), {
	desc = "Next Git change",
})

map("n", "[c", action("workbench.action.editor.previousChange"), {
	desc = "Previous Git change",
})

map("n", "<leader>f", action("editor.action.formatDocument"), {
	desc = "[F]ormat buffer",
})

map("x", "<leader>f", action("editor.action.formatSelection"), {
	desc = "[F]ormat selection",
})

local function gh(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({ gh("nvim-mini/mini.nvim") })

require("mini.ai").setup({
	mappings = {
		around_next = "aa",
		inside_next = "ii",
	},
	n_lines = 500,
})

require("mini.surround").setup()

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = vim.api.nvim_create_augroup("vscode-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
