-- Jupytext - Jupyter notebook as plain text
return {
  'goerz/jupytext.vim',
  ft = { 'ipynb', 'python', 'markdown', 'julia', 'r' },
  build = function()
    -- Ensure jupytext is installed
    vim.fn.system('pip install jupytext')
  end,
  config = function()
    require('plugins.config.jupytext')
  end,
}
