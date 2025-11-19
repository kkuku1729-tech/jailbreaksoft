-- ExpensiveMods Jailbreak Cheat
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- GUI Creation
local ExpensiveModsGUI = Instance.new("ScreenGui")
local DragCircle = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local TabContainer = Instance.new("Frame")
local ButtonContainer = Instance.new("ScrollingFrame")

ExpensiveModsGUI.Name = "ExpensiveModsGUI"
ExpensiveModsGUI.Parent = game.CoreGui
ExpensiveModsGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Drag Circle
DragCircle.Name = "DragCircle"
DragCircle.Parent = ExpensiveModsGUI
DragCircle.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
DragCircle.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
DragCircle.Position = UDim2.new(0, 50, 0, 50)
DragCircle.Size = UDim2.new(0, 40, 0, 40)
DragCircle.Font = Enum.Font.GothamBold
DragCircle.Text = "EM"
DragCircle.TextColor3 = Color3.new(1, 1, 1)
DragCircle.TextSize = 14
DragCircle.ZIndex = 2
DragCircle.AutoButtonColor = false

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExpensiveModsGUI
MainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
MainFrame.BorderColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Top Bar
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 35)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "ExpensiveMods"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 14
CloseButton.AutoButtonColor = false

-- Tab Container
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 0, 0, 35)
TabContainer.Size = UDim2.new(0, 100, 1, -35)

-- Button Container
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Parent = MainFrame
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(0, 100, 0, 35)
ButtonContainer.Size = UDim2.new(1, -100, 1, -35)
ButtonContainer.CanvasSize = UDim2.new(0, 0, 2, 0)
ButtonContainer.ScrollBarThickness = 4
ButtonContainer.ScrollingDirection = Enum.ScrollingDirection.Y

-- Variables
local Tabs = {}
local CurrentTab = nil
local Aimbot = {
    Enabled = false,
    FOV = 50,
    Target = nil
}
local ESP = {
    Enabled = false
}
local Fly = {
    Enabled = false
}
local Noclip = {
    Enabled = false
}
local AutoArrest = {
    Enabled = false
}

-- Animation Functions
local function TweenButton(button)
    local originalSize = button.Size
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    local tween1 = TweenService:Create(button, tweenInfo, {Size = originalSize - UDim2.new(0, 4, 0, 4)})
    local tween2 = TweenService:Create(button, tweenInfo, {Size = originalSize})
    
    tween1:Play()
    tween1.Completed:Connect(function()
        tween2:Play()
    end)
end

local function TweenToggle(toggle, enabled)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if enabled then
        TweenService:Create(toggle, tweenInfo, {BackgroundColor3 = Color3.new(0, 0.5, 0)}):Play()
        TweenService:Create(toggle.ToggleDot, tweenInfo, {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
    else
        TweenService:Create(toggle, tweenInfo, {BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)}):Play()
        TweenService:Create(toggle.ToggleDot, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
    end
end

-- GUI Functions
local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, 0, 0, 45)
    TabButton.Position = UDim2.new(0, 0, 0, (#TabContainer:GetChildren() - 1) * 45)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.new(1, 1, 1)
    TabButton.TextSize = 12
    TabButton.AutoButtonColor = false
    
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = name
    TabFrame.Parent = ButtonContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 0, 0)
    TabFrame.Visible = false
    
    Tabs[name] = TabFrame
    
    TabButton.MouseButton1Click:Connect(function()
        TweenButton(TabButton)
        for tabName, tabFrame in pairs(Tabs) do
            tabFrame.Visible = false
        end
        TabFrame.Visible = true
        CurrentTab = name
    end)
    
    return TabFrame
end

local function CreateToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    local ToggleLabel = Instance.new("TextLabel")
    local ToggleButton = Instance.new("TextButton")
    local ToggleDot = Instance.new("Frame")
    
    ToggleFrame.Name = "ToggleFrame"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, -20, 0, 35)
    ToggleFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 40)
    
    ToggleLabel.Name = "ToggleLabel"
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    ToggleLabel.Size = UDim2.new(0, 150, 1, 0)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.new(1, 1, 1)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.Text = ""
    ToggleButton.TextColor3 = Color3.new(0, 0, 0)
    ToggleButton.TextSize = 14
    ToggleButton.AutoButtonColor = false
    
    ToggleDot.Name = "ToggleDot"
    ToggleDot.Parent = ToggleButton
    ToggleDot.BackgroundColor3 = Color3.new(1, 1, 1)
    ToggleDot.BorderSizePixel = 0
    ToggleDot.Position = UDim2.new(0, 2, 0.5, -8)
    ToggleDot.Size = UDim2.new(0, 16, 0, 16)
    
    local enabled = false
    
    ToggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        TweenToggle(ToggleButton, enabled)
        callback(enabled)
    end)
    
    return ToggleButton
end

local function CreateSlider(parent, text, min, max, callback)
    local SliderFrame = Instance.new("Frame")
    local SliderLabel = Instance.new("TextLabel")
    local SliderValue = Instance.new("TextLabel")
    local SliderTrack = Instance.new("Frame")
    local SliderButton = Instance.new("TextButton")
    local SliderFill = Instance.new("Frame")
    
    SliderFrame.Name = "SliderFrame"
    SliderFrame.Parent = parent
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Size = UDim2.new(1, -20, 0, 60)
    SliderFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 65)
    
    SliderLabel.Name = "SliderLabel"
    SliderLabel.Parent = SliderFrame
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Position = UDim2.new(0, 0, 0, 0)
    SliderLabel.Size = UDim2.new(0, 150, 0, 20)
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.Text = text
    SliderLabel.TextColor3 = Color3.new(1, 1, 1)
    SliderLabel.TextSize = 14
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    SliderValue.Name = "SliderValue"
    SliderValue.Parent = SliderFrame
    SliderValue.BackgroundTransparency = 1
    SliderValue.Position = UDim2.new(1, -50, 0, 0)
    SliderValue.Size = UDim2.new(0, 50, 0, 20)
    SliderValue.Font = Enum.Font.Gotham
    SliderValue.Text = tostring(min)
    SliderValue.TextColor3 = Color3.new(1, 1, 1)
    SliderValue.TextSize = 14
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
    
    SliderTrack.Name = "SliderTrack"
    SliderTrack.Parent = SliderFrame
    SliderTrack.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Position = UDim2.new(0, 0, 0, 30)
    SliderTrack.Size = UDim2.new(1, 0, 0, 10)
    
    SliderFill.Name = "SliderFill"
    SliderFill.Parent = SliderTrack
    SliderFill.BackgroundColor3 = Color3.new(0, 0.5, 1)
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = SliderTrack
    SliderButton.BackgroundColor3 = Color3.new(1, 1, 1)
    SliderButton.BorderSizePixel = 0
    SliderButton.Position = UDim2.new(0.5, -5, 0, -2)
    SliderButton.Size = UDim2.new(0, 10, 0, 14)
    SliderButton.Font = Enum.Font.SourceSans
    SliderButton.Text = ""
    SliderButton.TextColor3 = Color3.new(0, 0, 0)
    SliderButton.TextSize = 14
    SliderButton.AutoButtonColor = false
    
    local dragging = false
    local currentValue = min
    
    local function updateValue(value)
        currentValue = math.floor(value)
        SliderValue.Text = tostring(currentValue)
        local fillSize = (currentValue - min) / (max - min)
        SliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
        SliderButton.Position = UDim2.new(fillSize, -5, 0, -2)
        callback(currentValue)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local trackAbsPos = SliderTrack.AbsolutePosition
            local trackAbsSize = SliderTrack.AbsoluteSize
            local relativeX = (mousePos.X - trackAbsPos.X) / trackAbsSize.X
            relativeX = math.clamp(relativeX, 0, 1)
            local value = min + (max - min) * relativeX
            updateValue(value)
        end
    end)
    
    updateValue(min)
    return {updateValue = updateValue}
end

-- Create Tabs в правильном порядке
local CombatTab = CreateTab("Combat")
local VisualsTab = CreateTab("Visuals") 
local MovementTab = CreateTab("Movement")
local PoliceTab = CreateTab("Police")

-- Combat Tab Elements
CreateToggle(CombatTab, "Aimbot", function(enabled)
    Aimbot.Enabled = enabled
    print("Aimbot:", enabled)
end)

local fovSlider = CreateSlider(CombatTab, "Aimbot FOV", 10, 200, function(value)
    Aimbot.FOV = value
    print("FOV:", value)
end)

-- Visuals Tab Elements
CreateToggle(VisualsTab, "ESP", function(enabled)
    ESP.Enabled = enabled
    print("ESP:", enabled)
end)

CreateToggle(VisualsTab, "Box ESP", function(enabled)
    print("Box ESP:", enabled)
end)

CreateToggle(VisualsTab, "Name ESP", function(enabled)
    print("Name ESP:", enabled)
end)

-- Movement Tab Elements
CreateToggle(MovementTab, "Fly Hack", function(enabled)
    Fly.Enabled = enabled
    print("Fly:", enabled)
end)

CreateToggle(MovementTab, "Noclip", function(enabled)
    Noclip.Enabled = enabled
    print("Noclip:", enabled)
end)

CreateToggle(MovementTab, "Speed Hack", function(enabled)
    print("Speed Hack:", enabled)
end)

-- Police Tab Elements
CreateToggle(PoliceTab, "Auto Arrest", function(enabled)
    AutoArrest.Enabled = enabled
    print("Auto Arrest:", enabled)
end)

CreateToggle(PoliceTab, "Long Arrest", function(enabled)
    print("Long Arrest:", enabled)
end)

CreateToggle(PoliceTab, "Auto Gun", function(enabled)
    print("Auto Gun:", enabled)
end)

-- Drag Circle Functionality
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    DragCircle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

DragCircle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = DragCircle.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

DragCircle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

DragCircle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        MainFrame.Position = UDim2.new(0, DragCircle.AbsolutePosition.X + 50, 0, DragCircle.AbsolutePosition.Y)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Show first tab by default
if next(Tabs) then
    for tabName, tabFrame in pairs(Tabs) do
        tabFrame.Visible = false
    end
    local firstTabName = "Combat"
    Tabs[firstTabName].Visible = true
    CurrentTab = firstTabName
end

-- Game Functions
local ESPBoxes = {}
RunService.RenderStepped:Connect(function()
    if ESP.Enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if not ESPBoxes[player] then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.FillColor = Color3.new(1, 0, 0)
                    highlight.OutlineColor = Color3.new(1, 1, 0)
                    ESPBoxes[player] = highlight
                end
            else
                if ESPBoxes[player] then
                    ESPBoxes[player]:Destroy()
                    ESPBoxes[player] = nil
                end
            end
        end
    else
        for player, highlight in pairs(ESPBoxes) do
            highlight:Destroy()
        end
        ESPBoxes = {}
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if Noclip.Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("ExpensiveMods loaded! Click the circle to open menu.")
