--[[
    🧈 Butt3rL3aks Hub | V1.0.0
    Made by kvkfjf
    Join our Discord: https://discord.gg/S7qUMBNq6f
]]

-- Script Configuration
local Config = {
    Version = "1.0.0",
    Updated = "2024-01-21",
    Discord = "discord.gg/S7qUMBNq6f"
}

-- Game Detection
local Games = {
    [4623386862] = "https://raw.githubusercontent.com/butterleaks/roblox-scripts/main/RaceClicker/Games/RaceClicker.lua",
    -- Add more games here
}

-- Load Notification Library
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()

-- Create Notification
local function Notify(title, text, duration)
    NotificationLibrary:Notify({Title = title, Description = text, Duration = duration or 5})
end

-- Check for Updates
local function CheckVersion()
    local success, latestVersion = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/butterleaks/roblox-scripts/main/version.txt")
    end)
    
    if success and latestVersion ~= Config.Version then
        Notify("Update Available!", "New version: " .. latestVersion .. "\nCurrent version: " .. Config.Version, 10)
    end
end

-- Main Loader Function
local function LoadScript()
    local gameId = game.PlaceId
    local scriptUrl = Games[gameId]
    
    if scriptUrl then
        -- Show welcome notification
        Notify("Butt3rL3aks Hub", "Loading script for " .. game:GetService("MarketplaceService"):GetProductInfo(gameId).Name, 3)
        
        -- Load game script
        local success, err = pcall(function()
            loadstring(game:HttpGet(scriptUrl))()
        end)
        
        if not success then
            Notify("Error", "Failed to load script: " .. tostring(err), 10)
        end
    else
        Notify("Game Not Supported", "This game is not supported yet!\nJoin our Discord for updates: " .. Config.Discord, 10)
    end
end

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Initialize
CheckVersion()
LoadScript()

-- Credits
Notify("Credits", "Made by kvkfjf\nDiscord: " .. Config.Discord, 5)
