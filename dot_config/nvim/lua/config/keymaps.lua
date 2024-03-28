local keymap = vim.keymap

keymap.set("n", "D", '"_D', { desc = "Delete characters until the end of line" })
keymap.set("n", "tc", "<Cmd>tabclose<Cr>", { desc = "Close Current Tab" })
keymap.set("n", "te", "<Cmd>tabedit<Cr>", { desc = "Open New Tab" })
keymap.set("n", "x", '"_x', { desc = "Delete character under the cursor" })
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all " })
keymap.set("n", "<C-w>|", "<Cmd>vs<Cr><C-w>l", { desc = "Split horizontally " })
keymap.set("n", "<C-w>-", "<Cmd>sp<Cr><C-w>j", { desc = "Split vertically " })
keymap.set("n", "<C-w>^", "<Cmd>resize +1<Cr>", { desc = "Increase window height" })
keymap.set("n", "<C-w>v", "<Cmd>resize -1<Cr>", { desc = "Deccrease window height" })

keymap.set("i", "<C-h>", "<Bs>", { desc = "Backspace" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Right" })
keymap.set("i", "jk", "<Esc>", { desc = "Escape" })

keymap.set({ "n", "t" }, "<C-h>", "<C-h>")
keymap.set({ "n", "t" }, "<C-j>", "<C-j>")
keymap.set({ "n", "t" }, "<C-k>", "<C-k>")
keymap.set({ "n", "t" }, "<C-l>", "<C-l>")
