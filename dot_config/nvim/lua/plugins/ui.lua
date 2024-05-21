return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override = {
        ts = {
          name = "Ts",
          icon = "󰛦",
          color = "#3178C6",
        },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<C-/>", "<Cmd>ToggleTerm<Cr>", desc = "Toggle Term (root dir)" },
      { "<C-_>", "<Cmd>ToggleTerm<Cr>", desc = "which_key_ignore" },
      { "<Leader>fT", "<Cmd>ToggleTerm dir=%:p:h<Cr>", desc = "Toggle Term (cwd)" },
      { "<Leader>ft", "<Cmd>ToggleTerm<Cr>", desc = "Toggle Term (root dir)" },
    },
    opts = {
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⡶⠶⠾⠿⠟⠻⠿⠷⠶⢶⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⠾⠛⢉⣁⣤⣤⣶⣶⣶⣶⣶⣶⣶⣶⣤⣤⣈⡉⠛⠷⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⢀⣴⠿⠋⣡⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣌⠙⠿⣦⡀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⢀⣴⠟⢁⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡈⠻⣦⡀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⣴⡟⢁⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠋⠉⢸⣿⣿⣿⣿⣦⡈⢻⣦⠀⠀⠀⠀
        ⠀⠀⢀⣾⠏⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠋⠉⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣄⠹⣷⡀⠀⠀
        ⠀⢀⣾⠃⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣆⠘⣷⡀⠀
        ⠀⣼⠇⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣍⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⡆⠸⣧⠀
        ⢠⡿⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢿⡄
        ⣸⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣇
        ⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠸⣿
        ⣿⡆⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢰⣿
        ⢹⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣷⣤⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⡏
        ⠘⣷⠀⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣾⠃
        ⠀⢻⡆⠸⣿⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⢰⡟⠀
        ⠀⠈⢿⡄⠹⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⢠⡿⠁⠀
        ⠀⠀⠈⢿⣆⠙⣿⣿⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⣰⡿⠁⠀⠀
        ⠀⠀⠀⠀⠻⣧⡈⠻⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢁⣼⠟⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠈⠻⣦⡈⠻⣿⣿⣿⣿⣷⣄⣀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢁⣴⠟⠁⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠈⠻⣶⣄⡙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⢋⣠⣶⠟⠁⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⢶⣤⣈⡉⠛⠛⠿⠿⠿⠿⠿⠿⠿⠿⠛⠛⢉⣁⣤⡶⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠷⠶⢶⣶⣦⣴⣶⡶⠶⠾⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
