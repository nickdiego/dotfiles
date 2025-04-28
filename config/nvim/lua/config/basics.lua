-- Generic configs which, for some reason, were moved from legacy .vimrc into
-- this lua file. Stuff will gradually be migrated here over time.

-- Lua equivalent for the provided Vimscript autocmd group

-- Auto commands to handle buffer relative/absolute line numbers auto switching
-- based on the current mode, etc. Special buffer types to be skipped from this
-- lofic (no line numbers at all), must be included in the `skiplist` below.
local function setup_line_numbers_switching()
  local skiplist = { "snacks_picker_list" }
  local skip_filetype = function (ft)
    for _, excluded_ft in ipairs(skiplist) do
      if ft == excluded_ft then
        return true
      end
    end
    return false
  end

  vim.api.nvim_create_augroup('numbertoggle', { clear = true })
  vim.api.nvim_create_autocmd(
    { 'BufEnter', 'FocusGained', 'InsertLeave' },
    {
      group = 'numbertoggle',
      pattern = '*',
      callback = function (ev)
        if not skip_filetype(vim.bo[ev.buf].filetype) then
          vim.opt.relativenumber = true
        end
      end
    })
  vim.api.nvim_create_autocmd(
    { 'BufLeave', 'FocusLost', 'InsertEnter' },
    {
      group = 'numbertoggle',
      pattern = '*',
      callback = function (ev)
        if not skip_filetype(vim.bo[ev.buf].filetype) then
          vim.opt.relativenumber = false
        end
      end
    })
end

setup_line_numbers_switching()
