return {
  'dhruvasagar/vim-table-mode',
  ft = { 'markdown', 'text' },
  config = function()
    vim.g.table_mode_corner = '|'
    vim.g.table_mode_corner_corner = '|'
    vim.g.table_mode_header_fillchar = '-'
    vim.g.table_mode_tableize_map = '<leader>tm'
    vim.g.table_mode_delete_row_map = '<leader>tdd'
    vim.g.table_mode_delete_column_map = '<leader>tdc'
    vim.g.table_mode_insert_column_before_map = '<leader>tic'
    vim.g.table_mode_insert_column_after_map = '<leader>tia'
  end,
}
