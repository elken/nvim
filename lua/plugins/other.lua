-- Allow jumping between "alternative" files (eg tests and their source files)
return {
  "rgroli/other.nvim",
  keys = {
    {
      "go",
      "<cmd>Other<cr>",
      desc = "Other file",
    },
  },
  opts = {
    mappings = {
      "laravel",
      "livewire",
      -- Lib -> Test
      {
        pattern = "/lib/(.*).rb",
        target = {
          { context = "test", target = "/spec/%1_spec.rb" },
        },
      },
      -- Test -> Lib
      {
        pattern = "/spec/(.*)_spec.rb",
        target = {
          { context = "source", target = "/lib/%1.rb" },
        },
      },
    },
    style = {
      border = "rounded",
    },
  },
}
