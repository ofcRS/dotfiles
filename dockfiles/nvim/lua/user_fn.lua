local function bookmark_selected_files()
  -- Get the start and end lines of the visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Iterate through the selected lines
  for line = start_line, end_line do
    -- Move the cursor to the current line
    vim.api.nvim_win_set_cursor(0, {line, 0})

    -- Get the file under the cursor
    local node = require'nvim-tree.lib'.get_node_at_cursor()
    
    if node then
      -- Toggle the bookmark for the current file
      require'nvim-tree.marks'.toggle_mark(node)
    end
  end

  -- Refresh NvimTree to show the changes
  require'nvim-tree'.refresh()
end

vim.api.nvim_create_user_command("BookmarkSelectedFiles", 
function()
  -- Get the start and end lines of the visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Iterate through the selected lines
  for line = start_line, end_line do
    -- Move the cursor to the current line
    vim.api.nvim_win_set_cursor(0, {line, 0})

    -- Get the file under the cursor
    local node = require'nvim-tree.lib'.get_node_at_cursor()
    
    if node then
      -- Toggle the bookmark for the current file
      require'nvim-tree.marks'.toggle_mark(node)
    end
  end

  -- Refresh NvimTree to show the changes
  require'nvim-tree'.refresh()
end
, { })
