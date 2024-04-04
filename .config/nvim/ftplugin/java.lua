local global = require('global')

vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Check to see what OS is currently being used.


local jdtls = require('jdtls')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Paths
local jdtls_path = global.config_data_path .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_dir = vim.fs.dirname(vim.fs.find({ 'pom.xml', '.git' }, { upward = true })[1])

print(root_dir)

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- Completions
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)

local function get_config_dir()
  -- Unlike some other programming languages (e.g. JavaScript)
  -- lua considers 0 truthy!
  if vim.fn.has('linux') == 1 then
    return 'config_linux'
  elseif vim.fn.has('mac') == 1 then
    return 'config_mac'
  else
    return 'config_win'
  end
end

local config = {
	settings = {
		["java.format.settings.url"] = "https://gist.githubusercontent.com/fbricon/c5960a86f0a21405a61b79c0f1b4a0fc/raw/16b9b75077d08ae8b36706718a8393268d2ea5d2/formatter.xml",
        --[[
        java = {
          format = {
            enabled = true,
            settings = {
              -- https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
              url = "C:/Users/Bryan/test.xml",
              profile = "MyFormat",
            },
          },
        },
        --]]
    },
    --capabilities = capabilities,
	cmd = {
		-- 💀
		"java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar", launcher_jar,
		"-configuration", vim.fs.normalize(jdtls_path .. "/" .. get_config_dir()),
		"-data",
		vim.fs.normalize(global.home_path .. "/code/java/workspaces/" .. workspace_dir),
	},

    root_dir = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1]),
	init_options = {
		--bundles = {},
        extendedCapabilities = jdtls.extendedCapabilities,
	},
}

config.on_attach = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    jdtls.setup.add_commands()
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', "<A-o>", jdtls.organize_imports, opts)
    vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
    vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
    vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
    vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
    vim.keymap.set('n', "crc", jdtls.extract_constant, opts)

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

 config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  end
local bundles = {
	vim.fn.glob(
		global.home_path .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.51.1.jar",
		1
	),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(global.home_path .. "/vscode-java-test/server/*.jar", 1), "\n"))
config["init_options"] = {
	bundles = bundles,
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

-- Commands
vim.cmd([[ command! -buffer JdtUpdateDebugConfigs lua require('jdtls.dap').setup_dap_main_class_configs() ]])
