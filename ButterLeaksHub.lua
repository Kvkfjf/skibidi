local function LoadHub()
    local Success, Error = pcall(function()
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
            [4623386862] = "https://raw.githubusercontent.com/Kvkfjf/skibidi/main/RaceClicker.lua",
            -- Add more games here
        }

        -- Simple Notification Function
        local function Notify(title, text, duration)
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

        -- Check for Updates
        local function CheckVersion()
            local success, latestVersion = pcall(function()
                return game:HttpGet("https://raw.githubusercontent.com/Kvkfjf/skibidi/main/version.txt")
            end)
            
            if success and latestVersion and latestVersion:match("%d+%.%d+%.%d+") ~= Config.Version then
                Notify("Update Available!", "New version: " .. latestVersion .. "\nCurrent version: " .. Config.Version, 10)
            end
        end

        -- Main Loader Function
        local function LoadScript()
            local gameId = game.PlaceId
            local scriptUrl = Games[gameId]
            
            if scriptUrl then
                -- Show welcome notification
                local gameName = pcall(function() 
                    return game:GetService("MarketplaceService"):GetProductInfo(gameId).Name 
                end) and game:GetService("MarketplaceService"):GetProductInfo(gameId).Name or "this game"
                
                Notify("Butt3rL3aks Hub", "Loading script for " .. gameName, 3)
                
                -- Load game script
                local success, err = pcall(function()
                    loadstring(game:HttpGet(scriptUrl))()
                end)
                
                if not success then
                    Notify("Error", "Failed to load script: " .. tostring(err), 10)
                    return false
                end
                return true
            else
                Notify("Game Not Supported", "This game is not supported yet!\nJoin our Discord for updates: " .. Config.Discord, 10)
                return false
            end
        end

        -- Anti-AFK
        local function SetupAntiAFK()
            local VirtualUser = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end

        -- Initialize
        spawn(function()
            SetupAntiAFK()
            CheckVersion()
            if LoadScript() then
                Notify("Success", "Script loaded successfully!", 5)
            end
        end)

        -- Credits
        Notify("Credits", "Made by kvkfjf\nDiscord: " .. Config.Discord, 5)
    end)

    if not Success then
        local function SimpleNotify(title, text)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = title,
                Text = text,
                Duration = 10
            })
        end
        SimpleNotify("Error", "Failed to load hub: " .. tostring(Error))
    end
end

LoadHub()
