return {
  "windwp/nvim-ts-autotag",
  lazy = false,
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false
      }
    })
  end
  --  opts = {
  --    per_filetype = {
  --      "html",
  --     "javascript",
  --     "javascriptreact",
  --    "typescript",
  --    "typescriptreact",
  -- }
  --}
}
