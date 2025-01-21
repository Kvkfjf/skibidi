--[[
    🧈 Butt3rL3aks Hub | Main Loader
    Made by kvkfjf
    Join our Discord: https://discord.gg/S7qUMBNq6f
]]

local function LoadHub()
    local Success, Error = pcall(function()
        -- Services
        local Players = game:GetService("Players")
        local VirtualUser = game:GetService("VirtualUser")
        local StarterGui = game:GetService("StarterGui")
        
        -- Simple Notification Function
        local function Notify(title, text, duration)
            StarterGui:SetCore("SendNotification", {
                Title = title,
                Text = text,
                Duration = duration or 5
            })
        end

        -- Anti AFK
        Players.LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        
        -- Game Detection
        local Games = {
            -- FPS Games
            [301549746] = "https://raw.githubusercontent.com/Kvkfjf/skibidi/main/CounterBlox.lua", -- Counter Blox
            
            -- Simulator Games
            [8737899170] = "https://raw.githubusercontent.com/Kvkfjf/skibidi/main/PetSimulator99.lua", -- Pet Simulator 99
            [3175647227] = "https://raw.githubusercontent.com/Kvkfjf/skibidi/main/MuscleLegends.lua", -- Muscle Legends
            
            -- Racing Games
            [4623386862] = "https://raw.githubusercontent.com/Kvkfjf/skibidi/main/RaceClicker.lua" -- Race Clicker
        }
        
        -- Welcome Message
        Notify("Welcome!", "Loading Butt3rL3aks Hub...", 3)
        
        -- Load Game Script
        local gameId = game.PlaceId
        local scriptUrl = Games[gameId]
        
        if scriptUrl then
            -- Show loading notification
            local gameName = pcall(function() 
                return game:GetService("MarketplaceService"):GetProductInfo(gameId).Name 
            end) and game:GetService("MarketplaceService"):GetProductInfo(gameId).Name or "this game"
            
            Notify("Loading...", "Loading script for " .. gameName, 3)
            
            -- Load game script
            local success, err = pcall(function()
                loadstring(game:HttpGet(scriptUrl))()
            end)
            
            if not success then
                Notify("Error", "Failed to load script: " .. tostring(err), 10)
                return false
            end
            
            Notify("Success!", "Script loaded successfully!", 5)
            return true
        else
            Notify("Game Not Supported", "This game is not supported yet!\nJoin our Discord for updates: discord.gg/S7qUMBNq6f", 10)
            return false
        end
    end)

    if not Success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = "Failed to load hub: " .. tostring(Error),
            Duration = 10
        })
    end
end

LoadHub()
