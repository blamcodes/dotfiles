local vault_paths = {
  { name = "work", path = vim.fn.expand("~") .. "/Documents/ironsight-obsidian" },
  { name = "personal", path = vim.fn.expand("~") .. "/Documents/obsidian" },
  -- Add more vaults here as needed
}

return {
  "obsidian-nvim/obsidian.nvim",
  -- enabled = false,
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = (function()
    local events = {}

    -- Add events for each vault if the directory exists
    for _, vault in ipairs(vault_paths) do
      if vim.loop.fs_stat(vault.path) then
        table.insert(events, "BufReadPre " .. vault.path .. "/*.md")
        table.insert(events, "BufNewFile " .. vault.path .. "/*.md")
      end
    end

    return events
  end)(),
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = (function()
      local workspaces = {}

      -- Add workspaces for each vault if the directory exists
      for _, vault in ipairs(vault_paths) do
        if vim.loop.fs_stat(vault.path) then
          table.insert(workspaces, {
            name = vault.name,
            path = vault.path,
          })
        end
      end

      return workspaces
    end)(),
  },
  -- Completion Settings
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  -- Picker Settings
  picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    -- TODO: neeeds to be updated to snacks picker
    name = "mini.pick",
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    note_mappings = {
      -- Create a new note from your query.
      new = "<C-x>",
      -- Insert a link to the selected note.
      insert_link = "<C-i>",
    },
    tag_mappings = {
      -- Add tag(s) to current note.
      tag_note = "<C-x>",
      -- Insert a tag at the current location.
      insert_tag = "<C-i>",
    },
  },

  -- UI Settings
  ui = {
    enable = true,          -- set to false to disable all additional syntax features
    update_debounce = 200,  -- update delay after a text change (in milliseconds)
    max_file_length = 5000, -- disable UI features for files with more than this many lines
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
  }
}
