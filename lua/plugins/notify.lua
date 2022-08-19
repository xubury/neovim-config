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

local M = {}
local notify = require("notify")
M.spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
M.__index = M

function M.new(frames)
    local t = {}
    t.spinner_frames = frames
    setmetatable(t, M)
    return t
end

function M:update()
    if self.spinner then
        local new_spinner = (self.spinner + 1) % #self.spinner_frames
        self.spinner = new_spinner

        self.notification = notify(nil, nil, {
            hide_from_history = true,
            icon = self.spinner_frames[new_spinner],
            replace = self.notification,
        })

        vim.defer_fn(function() self:update() end, 100)
    end
end

function M:start(table)
    self.notification = notify(table.message or "Progress", "info", {
        title = format_title(table.title, table.client_name),
        icon = self.spinner_frames[1],
        timeout = false,
        hide_from_history = false,
    })
    self.spinner = 1

    self:update()
end

function M:send_message(message, percentage)
    self.notification = notify(format_message(message, percentage), "info", {
        replace = self.notification,
        hide_from_history = false,
    })
end

function M:complete(table)
    local msg = format_message(table.message, table.percentage)
    self.notification = notify(msg ~= "" and msg or "Complete",
        table.type or "info", {
        icon = table.icon or "",
        replace = self.notification,
        timeout = table.timeout or 3000
    })
    self.spinner = nil
end

return M
