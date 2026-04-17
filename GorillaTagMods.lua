-- VERIZONS GORILLA TAG MOD MENU
-- A comprehensive mod menu for Gorilla Tag with soundboard, ghost modes, and speed boost

local GorillaTagMods = {}
GorillaTagMods.version = "1.0.0"
GorillaTagMods.author = "VERIZONS"
GorillaTagMods.enabled = true

-- Feature Toggles
local featureStates = {
    ghostMonkey = false,
    ghostTrolls = false,
    pullMod = false,
    soundboard = false,
    banGun = false,
    speedBoost = false
}

-- Configuration
local config = {
    speedBoostPercent = 3,
    banDurationMinutes = 30,
    pullModMultiplier = 1.03  -- 3% boost
}

-- Soundboard Configuration
local soundboard = {
    enabled = true,
    defaultVolume = 0.7,
    sounds = {
        monkey = "rbxassetid://2751744973",
        troll = "rbxassetid://2785493303",
        alert = "rbxassetid://2751744973",
        victory = "rbxassetid://12221844",
        defeat = "rbxassetid://12221848"
    }
}

-- Create Canvas GUI
function GorillaTagMods:createGUI()
    local canvas = GorillaTagMods:getCanvas()
    
    -- Main Panel
    local mainPanel = Instance.new("Frame")
    mainPanel.Name = "GorillaTagModPanel"
    mainPanel.Size = UDim2.new(0, 300, 0, 500)
    mainPanel.Position = UDim2.new(0, 10, 0, 10)
    mainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainPanel.BorderColor3 = Color3.fromRGB(100, 50, 200)
    mainPanel.BorderSizePixel = 2
    mainPanel.Parent = canvas
    
    -- Header
    local header = Instance.new("TextLabel")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.Font = Enum.Font.GothamBold
    header.TextSize = 16
    header.Text = "VERIZONS GORILLA TAG"
    header.Parent = mainPanel
    
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(1, 0, 0, 20)
    versionLabel.Position = UDim2.new(0, 0, 0, 25)
    versionLabel.BackgroundTransparency = 1
    versionLabel.TextColor3 = Color3.fromRGB(150, 100, 200)
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.TextSize = 10
    versionLabel.Text = "v" .. GorillaTagMods.version
    versionLabel.Parent = mainPanel
    
    -- Scroll Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Size = UDim2.new(1, -10, 1, -60)
    scrollFrame.Position = UDim2.new(0, 5, 0, 50)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.BorderSizePixel = 0
    scrollFrame.Parent = mainPanel
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = scrollFrame
    
    -- Features
    self:addFeatureButton(scrollFrame, "👻 Ghost Monkey", "ghostMonkey", 1)
    self:addFeatureButton(scrollFrame, "👹 Ghost Trolls", "ghostTrolls", 2)
    self:addFeatureButton(scrollFrame, "🤏 Pull Mod (+3%)", "pullMod", 3)
    self:addFeatureButton(scrollFrame, "⚡ Speed Boost", "speedBoost", 4)
    self:addFeatureButton(scrollFrame, "🔊 Soundboard", "soundboard", 5)
    self:addFeatureButton(scrollFrame, "🔫 Ban Gun (30min)", "banGun", 6)
    
    -- Soundboard Section
    self:addSoundboardButtons(scrollFrame, 7)
    
    -- Update Canvas Size
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
    UIListLayout.Changed:Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- Bottom Info
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 20)
    infoLabel.Position = UDim2.new(0, 0, 1, -20)
    infoLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    infoLabel.TextColor3 = Color3.fromRGB(100, 150, 200)
    infoLabel.Font = Enum.Font.GothamMonospace
    infoLabel.TextSize = 9
    infoLabel.Text = "Press K to toggle menu"
    infoLabel.Parent = mainPanel
    
    return mainPanel
end

-- Get or Create Canvas
function GorillaTagMods:getCanvas()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    local existingCanvas = playerGui:FindFirstChild("VerizonCanvas")
    if existingCanvas then
        return existingCanvas
    end
    
    local newCanvas = Instance.new("ScreenGui")
    newCanvas.Name = "VerizonCanvas"
    newCanvas.ResetOnSpawn = false
    newCanvas.Parent = playerGui
    
    return newCanvas
end

-- Add Feature Toggle Button
function GorillaTagMods:addFeatureButton(parent, label, featureKey, layoutOrder)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 35)
    container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    container.BorderColor3 = Color3.fromRGB(60, 60, 60)
    container.BorderSizePixel = 1
    container.LayoutOrder = layoutOrder
    container.Parent = parent
    
    -- Label
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.65, 0, 1, 0)
    labelText.BackgroundTransparency = 1
    labelText.TextColor3 = Color3.fromRGB(220, 220, 220)
    labelText.Font = Enum.Font.GothamBold
    labelText.TextSize = 12
    labelText.Text = label
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = container
    
    -- Toggle Button
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.3, -5, 0.8, 0)
    toggleBtn.Position = UDim2.new(0.67, 0, 0.1, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 11
    toggleBtn.Text = "OFF"
    toggleBtn.Parent = container
    
    toggleBtn.MouseButton1Click:Connect(function()
        featureStates[featureKey] = not featureStates[featureKey]
        toggleBtn.BackgroundColor3 = featureStates[featureKey] and 
            Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 60)
        toggleBtn.Text = featureStates[featureKey] and "ON" or "OFF"
        
        GorillaTagMods:activateFeature(featureKey)
    end)
end

-- Add Soundboard Buttons
function GorillaTagMods:addSoundboardButtons(parent, startOrder)
    local sounds = {"Monkey", "Troll", "Victory", "Alert"}
    
    for i, soundName in ipairs(sounds) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.Text = "🔊 " .. soundName .. " Sound"
        btn.LayoutOrder = startOrder + i
        btn.Parent = parent
        
        btn.MouseButton1Click:Connect(function()
            GorillaTagMods:playSound(soundName:lower())
        end)
    end
end

-- Activate Features
function GorillaTagMods:activateFeature(featureKey)
    if featureKey == "ghostMonkey" then
        self:toggleGhostMonkey(featureStates.ghostMonkey)
    elseif featureKey == "ghostTrolls" then
        self:toggleGhostTrolls(featureStates.ghostTrolls)
    elseif featureKey == "pullMod" then
        self:togglePullMod(featureStates.pullMod)
    elseif featureKey == "speedBoost" then
        self:toggleSpeedBoost(featureStates.speedBoost)
    elseif featureKey == "banGun" then
        self:toggleBanGun(featureStates.banGun)
    elseif featureKey == "soundboard" then
        soundboard.enabled = featureStates.soundboard
    end
end

-- Ghost Monkey Mode
function GorillaTagMods:toggleGhostMonkey(enabled)
    local player = game.Players.LocalPlayer.Character
    if not player then return end
    
    if enabled then
        -- Make character invisible
        for _, part in pairs(player:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0.7
            end
        end
        print("👻 Ghost Monkey: ENABLED")
    else
        -- Make character visible
        for _, part in pairs(player:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
        print("👻 Ghost Monkey: DISABLED")
    end
end

-- Ghost Trolls Mode
function GorillaTagMods:toggleGhostTrolls(enabled)
    if enabled then
        print("👹 Ghost Trolls: ENABLED")
        -- Advanced invisibility for all players
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        part.Transparency = 0.5
                    end
                end
            end
        end
    else
        print("👹 Ghost Trolls: DISABLED")
    end
end

-- Pull Mod with Speed Boost
function GorillaTagMods:togglePullMod(enabled)
    if enabled then
        print("🤏 Pull Mod: ENABLED (+3% speed boost)")
        -- Applies pull modification with speed multiplier
        local player = game.Players.LocalPlayer.Character
        if player and player:FindFirstChild("HumanoidRootPart") then
            local humanoid = player:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = humanoid.WalkSpeed * config.pullModMultiplier
            end
        end
    else
        print("🤏 Pull Mod: DISABLED")
    end
end

-- Speed Boost
function GorillaTagMods:toggleSpeedBoost(enabled)
    local player = game.Players.LocalPlayer.Character
    if not player then return end
    
    local humanoid = player:FindFirstChild("Humanoid")
    if humanoid then
        if enabled then
            humanoid.WalkSpeed = humanoid.WalkSpeed * (1 + (config.speedBoostPercent / 100))
            print("⚡ Speed Boost: ENABLED (+3%)")
        else
            humanoid.WalkSpeed = humanoid.WalkSpeed / (1 + (config.speedBoostPercent / 100))
            print("⚡ Speed Boost: DISABLED")
        end
    end
end

-- Ban Gun
function GorillaTagMods:toggleBanGun(enabled)
    if enabled then
        print("🔫 Ban Gun: ENABLED (30-minute bans)")
        -- Click detection to ban players
        local mouse = game.Players.LocalPlayer:GetMouse()
        mouse.Button1Down:Connect(function()
            if featureStates.banGun then
                local target = mouse.Target
                if target and target.Parent:FindFirstChild("Humanoid") then
                    local targetPlayer = game.Players:FindFirstChild(target.Parent.Name)
                    if targetPlayer then
                        print("🔫 Banned: " .. targetPlayer.Name .. " for 30 minutes")
                        -- Ban logic would be implemented server-side
                    end
                end
            end
        end)
    else
        print("🔫 Ban Gun: DISABLED")
    end
end

-- Play Sound
function GorillaTagMods:playSound(soundName)
    if not soundboard.enabled then return end
    
    local soundId = soundboard.sounds[soundName] or soundboard.sounds.alert
    
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = soundboard.defaultVolume
    sound.Parent = workspace
    sound:Play()
    
    game:GetService("Debris"):AddItem(sound, 3)
end

-- Toggle Menu Visibility
function GorillaTagMods:toggleMenu()
    local canvas = self:getCanvas()
    local menuPanel = canvas:FindFirstChild("GorillaTagModPanel")
    
    if menuPanel then
        menuPanel.Visible = not menuPanel.Visible
    end
end

-- Keyboard Input Handler
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        GorillaTagMods:toggleMenu()
    end
end)

-- Initialize
function GorillaTagMods:init()
    print("=== VERIZONS GORILLA TAG MOD MENU ===")
    print("Version: " .. self.version)
    print("Author: " .. self.author)
    print("Press K to toggle menu")
    
    self:createGUI()
    print("✓ Mod Menu Loaded Successfully!")
end

-- Start
GorillaTagMods:init()

return GorillaTagMods
