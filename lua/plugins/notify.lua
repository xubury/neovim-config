local function format_title(title, client_name)
    local str = ""
    if client_name then
        str = client_name
        if title and #title > 0 then
            str = str .. ": " .. title
        end
    else
        str = title or ""
    end
    return str
end

local function format_message(message, percentage)
    return (percentage and percentage .. "%\t" or "") .. (message or "")
end

local notify = require("notify")
local M = {}
M.__index = M
M.spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
M.freq = 100

function M.new(_, freq, frames)
    local t = {}
    t.freq = freq
    t.spinner_frames = frames
    return setmetatable(t, M)
end

function M:update()
    if self.spinner then
        self.notification = notify(nil, nil,
            { hide_from_history = true, icon = self.spinner_frames[self.spinner + 1], replace = self.notification, })
        local new_spinner = (self.spinner + 1) % #self.spinner_frames
        self.spinner = new_spinner
        vim.defer_fn(function()
            self:update()
        end, self.freq)
    end
end

function M:start(table)
    self.notification = notify(table.message or "Progress", "info", {
        title = format_title(table.title, table.client_name), icon = self.spinner_frames[1], timeout = false,
        hide_from_history = false,
    })
    self.spinner = 0
    self:update()
end

function M:send_message(message, percentage)
    if self.spinner then
        self.notification = notify(format_message(message, percentage), "info", {
            replace = self.notification,
            hide_from_history = false,
        })
    end
end

function M:complete(table)
    local msg = format_message(table.message, table.percentage)
    msg = msg == "" and "Complete" or msg
    self.notification = notify(msg, table.type or "info",
        { icon = table.icon or "", replace = self.notification, timeout = table.timeout or 1000 })
    self.spinner = nil
end

return M
