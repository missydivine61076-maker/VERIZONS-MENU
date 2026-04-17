-- VERIZONS MOD MENU FOR RIVALS
-- A clean, legitimate mod menu with cosmetics and utilities

local modMenu = {}
modMenu.enabled = true
modMenu.uiVisible = true

-- Menu Configuration
local menuConfig = {
    version = "1.0.0",
    author = "VERIZONS",
    position = UDim2.new(0, 20, 0, 20),
    size = UDim2.new(0, 250, 0, 400)
}

-- Feature Toggles
local features = {
    soundboard = true,
    cosmetics = true,
    stats = true,
    ui = true
}

-- Soundboard Sounds
local soundboard = {
    sounds = {
        victory = "rbxassetid://12221844",
        defeat = "rbxassetid://12221848",
        swoosh = "rbxassetid://12221967",
        ding = "rbxassetid://12221888"
    }
}

-- Create Main GUI
function modMenu:createUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VerizonModMenu"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = menuConfig.size
    mainFrame.Position = menuConfig.position
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -40, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "VERIZONS MENU v" .. menuConfig.version
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -37, 0, 2)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Text = "X"
    closeBtn.Parent = titleBar
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Scroll Frame for Features
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Size = UDim2.new(1, -10, 1, -50)
    scrollFrame.Position = UDim2.new(0, 5, 0, 45)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.Parent = mainFrame
    
    -- Cosmetics Section
    self:addSection(scrollFrame, "COSMETICS", {
        {name = "Dark Skin", toggle = true},
        {name = "Neon Glow", toggle = true},
        {name = "Trail Effects", toggle = true}
    })
    
    -- Soundboard Section
    self:addSection(scrollFrame, "SOUNDBOARD", {
        {name = "Victory Sound", button = true},
        {name = "Defeat Sound", button = true},
        {name = "Mute Sounds", toggle = true}
    })
    
    -- Stats Section
    self:addSection(scrollFrame, "STATS", {
        {name = "Show FPS", toggle = true},
        {name = "Ping Display", toggle = true},
        {name = "Win Counter", toggle = true}
    })
    
    -- Settings Section
    self:addSection(scrollFrame, "SETTINGS", {
        {name = "Menu Transparency", slider = true},
        {name = "Notifications", toggle = true}
    })
    
    -- Update ScrollFrame CanvasSize
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, scrollFrame.UIListLayout.AbsoluteContentSize.Y + 10)
    scrollFrame.UIListLayout.Changed:Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, scrollFrame.UIListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    return screenGui
end

-- Add Section Function
function modMenu:addSection(parent, title, items)
    -- Add UIListLayout if not present
    if not parent:FindFirstChild("UIListLayout") then
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 5)
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = parent
    end
    
    -- Section Frame
    local section = Instance.new("Frame")
    section.Name = title
    section.Size = UDim2.new(1, -10, 0, 20 + (#items * 30))
    section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    section.BorderSizePixel = 1
    section.BorderColor3 = Color3.fromRGB(60, 60, 60)
    section.Parent = parent
    
    -- Section Title
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Size = UDim2.new(1, 0, 0, 20)
    sectionTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sectionTitle.TextColor3 = Color3.fromRGB(100, 180, 255)
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextSize = 12
    sectionTitle.Text = title
    sectionTitle.Parent = section
    
    -- Add Items
    for i, item in ipairs(items) do
        if item.toggle then
            self:addToggleButton(section, item.name, i)
        elseif item.button then
            self:addButton(section, item.name, i)
        elseif item.slider then
            self:addSlider(section, item.name, i)
        end
    end
end

-- Add Toggle Button
function modMenu:addToggleButton(parent, name, index)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 25)
    container.BackgroundTransparency = 1
    container.Parent = parent
    container.LayoutOrder = index
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.Text = name
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.25, -5, 1, 0)
    toggle.Position = UDim2.new(0.75, 0, 0, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 10
    toggle.Text = "OFF"
    toggle.Parent = container
    
    local isEnabled = false
    toggle.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        toggle.BackgroundColor3 = isEnabled and Color3.fromRGB(0, 150, 76) or Color3.fromRGB(60, 60, 60)
        toggle.Text = isEnabled and "ON" or "OFF"
    end)
end

-- Add Button
function modMenu:addButton(parent, name, index)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 25)
    btn.Position = UDim2.new(0, 5, 0, 20 + (index * 30))
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Text = name
    btn.Parent = parent
    btn.LayoutOrder = index
    
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
        wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        self:playSound(name)
    end)
end

-- Add Slider
function modMenu:addSlider(parent, name, index)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 30)
    container.BackgroundTransparency = 1
    container.Parent = parent
    container.LayoutOrder = index
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 12)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.Gotham
    label.TextSize = 10
    label.Text = name
    label.Parent = container
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -10, 0, 8)
    sliderBg.Position = UDim2.new(0, 5, 0, 15)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderBg.Parent = container
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    sliderFill.Parent = sliderBg
end

-- Play Sound Function
function modMenu:playSound(soundName)
    local soundId = soundboard.sounds[soundName:lower():gsub(" ", "")] or soundboard.sounds.ding
    if soundId then
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = 0.5
        sound.Parent = workspace
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 2)
    end
end

-- Initialize Menu
function modMenu:init()
    if modMenu.enabled then
        self:createUI()
        print("VERIZONS MOD MENU LOADED - Press Insert to toggle")
    end
end

-- Keyboard Toggle (Insert key)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        modMenu.uiVisible = not modMenu.uiVisible
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("VerizonModMenu")
        if gui then
            gui.Enabled = modMenu.uiVisible
        end
    end
end)

-- Start Menu
modMenu:init()

return modMenu
