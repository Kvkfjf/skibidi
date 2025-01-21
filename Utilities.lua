--[[
    🧈 Butt3rL3aks | Utility Functions
    Made by kvkfjf
    Join our Discord: https://discord.gg/S7qUMBNq6f
]]

local Utilities = {}

-- Services
Utilities.Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    VirtualUser = game:GetService("VirtualUser"),
    TweenService = game:GetService("TweenService"),
    HttpService = game:GetService("HttpService")
}

-- Constants
Utilities.Constants = {
    Version = "1.0.0",
    BaseUrl = "https://raw.githubusercontent.com/Kvkfjf/skibidi/main/",
    Discord = "discord.gg/S7qUMBNq6f"
}

-- Notification System
function Utilities:Notify(title, text, duration)
    if syn then
        syn.toast_notification({
            Title = title,
            Content = text,
            Duration = duration or 5,
            Type = "info"
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end
end

-- Anti AFK
function Utilities:SetupAntiAFK()
    local VirtualUser = self.Services.VirtualUser
    self.Services.Players.LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- Safe HTTP Get
function Utilities:HttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    return success and result or nil
end

return Utilities
