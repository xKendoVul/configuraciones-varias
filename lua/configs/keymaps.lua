local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
