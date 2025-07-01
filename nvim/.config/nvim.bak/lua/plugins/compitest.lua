return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  opts = {
    compile_command = {
      go = { exec = "go", args = { "build", "$(FNAME)" } },
    },
    run_command = {
      go = { exec = "go", args = { "run", "$(FNAME)" } },
    },
    received_files_extension = "go",
  },
}
