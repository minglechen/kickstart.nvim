-- Pad a line with multiple delimiters
vim.keymap.set('i', '<C-j>', function()
  local current_line = vim.api.nvim_get_current_line()
  local delimiter = '|' -- Change this to your desired delimiter

  -- Find all occurrences of the delimiter
  local positions = {}
  local last_pos = 1
  while true do
    local start_pos, end_pos = string.find(current_line, delimiter, last_pos, true)
    if start_pos then
      table.insert(positions, start_pos)
      last_pos = end_pos + 1
    else
      break
    end
  end

  if #positions > 0 then
    -- Use the position of the first delimiter as the padding reference
    local first_delimiter_pos = positions[1]

    local new_parts = {}
    local start_of_chunk = 1

    for i, pos in ipairs(positions) do
      table.insert(new_parts, string.rep(' ', pos - start_of_chunk)) -- Add spaces before the delimiter
      table.insert(new_parts, delimiter) -- Add the delimiter
      start_of_chunk = pos + 1
    end

    -- Add the final part of the line after the last delimiter
    local final_chunk = string.sub(current_line, start_of_chunk)
    table.insert(new_parts, final_chunk)

    local new_line = table.concat(new_parts)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local new_cursor_col = cursor_pos[2]
    for i = #positions, 1, -1 do
      if positions[i] <= cursor_pos[2] then
        new_cursor_col = positions[i] + 1
        break
      end
    end
    cursor_pos[2] = new_cursor_col
    vim.api.nvim_buf_set_lines(0, cursor_pos[1], cursor_pos[1], true, { new_line })
    vim.api.nvim_win_set_cursor(0, { cursor_pos[1] + 1, cursor_pos[2] })
  else
    print 'No delimiter found on the current line.'
  end
end, { desc = 'Pad multiple delimiters on a line with whitespace' })
