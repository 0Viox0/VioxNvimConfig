return {
  "navarasu/onedark.nvim",
  priority = 1000,
  opts = {
    style = 'warm',
    -- transparent = true,
  },
  init = function()
    require('onedark').load()
  end
}
