return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod',                     lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_table_helpers = {
      mysql = {
        Count = 'select count(*) from "{table}"',
        Explain = 'EXPLAIN ANALYZE {last_query}'
      }
    }

    -- Databases
    vim.g.dbs = {
      { name = "IronSight", url = "mysql://root:" .. (os.getenv("ASPIRE_MYSQL_PASS") or "") .. "@127.0.0.1:3306/IronSight" },
      { name = "IorDB", url = "mysql://root:" .. (os.getenv("ASPIRE_MYSQL_PASS") or "") .. "@127.0.0.1:3306/IorDB" },
      { name = "HubDB",     url = "mysql://root:" .. (os.getenv("ASPIRE_MYSQL_PASS") or "") .. "@127.0.0.1:3306/HubDB" },
      { name = "HubDB_OLD",     url = "mysql://root:" .. (os.getenv("ASPIRE_MYSQL_PASS") or "") .. "@127.0.0.1:3306/HubDB_OLD" },
      { name = "LatestDB",     url = "mysql://root:" .. (os.getenv("ASPIRE_MYSQL_PASS") or "") .. "@127.0.0.1:3306/LatestDB" },
      { name = "WhitecapDB",     url = "mysql://root:" .. (os.getenv("ASPIRE_MYSQL_PASS") or "") .. "@127.0.0.1:3306/WhitecapDB" },
    }

    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = '~/scripts/db_ui_queries'
    vim.g.db_ui_tmp_query_location = '~/scripts/db_ui_queries/tmp'
    vim.g.db_ui_default_query = 'select * from "{table}" limit 10'
    -- vim.keymap.set('<leader>F', '<Plug>(DBUI_JumpToForeignKey)', {silent = true})
  end,
}
