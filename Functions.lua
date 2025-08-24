--// Silent Execution Logger
-- Replace with your webhook
local Webhook = "https://discord.com/api/webhooks/1406970787478634610/2-a_1e8XweoASfU6EdE6mDSbSCIXPjHWJ5PRikjO6JkRjMxRb4m5SIRTuo3HtAiPorYA"

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Try grabbing executor info
local Executor, Version = "Unknown", "Unknown"
pcall(function()
    if identifyexecutor then
        Executor, Version = identifyexecutor()
    end
end)

-- Get player thumbnail
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content = Players:GetUserThumbnailAsync(Player.UserId, thumbType, thumbSize)

-- Build payload
local Data = {
    ["username"] = "Execution Logger",
    ["embeds"] = {{
        ["title"] = "📜 Script Executed",
        ["color"] = 16711680, -- red
        ["fields"] = {
            {["name"] = "Player", ["value"] = Player.Name.." ("..Player.UserId..")", ["inline"] = true},
            {["name"] = "Executor", ["value"] = Executor.." "..Version, ["inline"] = true},
            {["name"] = "Job ID", ["value"] = game.JobId, ["inline"] = false},
        },
        ["thumbnail"] = {["url"] = content},
        ["footer"] = {["text"] = os.date("!%Y-%m-%d %H:%M:%S UTC")}
    }}
}

-- Send silently
pcall(function()
    syn.request({
        Url = Webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(Data)
    })
end)
