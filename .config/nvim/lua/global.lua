-- Initial setup of Variables
local function is_windows()
    return vim.loop.os_uname().sysname == "Windows"
end

-- On Windows: C:\Users\<profile>\
-- On Linux: /home/<profile>
local home_path = vim.env.HOME
local config_path = vim.env.HOME .. "/.config/nvim"
local config_data_path = home_path .. "/.local/share/nvim"

if is_windows() then
    home_path = vim.env.USERPROFILE
    config_path = vim.env.LOCALAPPDATA .. "/nvim"
    config_path = vim.env.LOCALAPPDATA .. "/nvim-data"
end

return {
    home_path = home_path,
    config_path = config_path,
    config_data_path = config_data_path,
}
