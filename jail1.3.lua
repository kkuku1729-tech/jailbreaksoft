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

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ExpensiveModsGUI
MainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
MainFrame.BorderColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Top Bar
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 30)

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
CloseButton.Size = UDim2.new(0, 25, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 14

-- Tab Container
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 0, 0, 30)
TabContainer.Size = UDim2.new(0, 80, 1, -30)

-- Button Container
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Parent = MainFrame
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(0, 80, 0, 30)
ButtonContainer.Size = UDim2.new(1, -80, 1, -30)
ButtonContainer.CanvasSize = UDim2.new(0, 0, 2, 0)
ButtonContainer.ScrollBarThickness = 3

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
        TweenService:Create(toggle.ToggleDot, tweenInfo, {Position = UDim2.new(1, -12, 0.5, 0)}):Play()
    else
        TweenService:Create(toggle, tweenInfo, {BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)}):Play()
        TweenService:Create(toggle.ToggleDot, tweenInfo, {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
    end
end

-- GUI Functions
local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.new(1, 1, 1)
    TabButton.TextSize = 12
    
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = name
    TabFrame.Parent = ButtonContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
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
    local ToggleButton = Instance.new("TextButton")
    local ToggleLabel = Instance.new("TextLabel")
    local ToggleDot = Instance.new("Frame")
    
    ToggleFrame.Name = "ToggleFrame"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    
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
    ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.Text = ""
    ToggleButton.TextColor3 = Color3.new(0, 0, 0)
    ToggleButton.TextSize = 14
    
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
    SliderFrame.Size = UDim2.new(1, -20, 0, 50)
    
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
    SliderTrack.Position = UDim2.new(0, 0, 0, 25)
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
    
    return {updateValue = updateValue}
end

-- Create Tabs
local CombatTab = CreateTab("Combat")
local VisualsTab = CreateTab("Visuals")
local MovementTab = CreateTab("Movement")
local PoliceTab = CreateTab("Police")

-- Combat Tab
CreateToggle(CombatTab, "Aimbot", function(enabled)
    Aimbot.Enabled = enabled
end)

local fovSlider = CreateSlider(CombatTab, "Aimbot FOV", 10, 200, function(value)
    Aimbot.FOV = value
end)

-- Visuals Tab
CreateToggle(VisualsTab, "ESP", function(enabled)
    ESP.Enabled = enabled
end)

-- Movement Tab
CreateToggle(MovementTab, "Fly Hack", function(enabled)
    Fly.Enabled = enabled
end)

CreateToggle(MovementTab, "Noclip", function(enabled)
    Noclip.Enabled = enabled
end)

-- Police Tab
CreateToggle(PoliceTab, "Auto Arrest", function(enabled)
    AutoArrest.Enabled = enabled
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

-- Game Functions
-- Aimbot
RunService.RenderStepped:Connect(function()
    if Aimbot.Enabled and LocalPlayer.Character then
        local nearestPlayer = nil
        local nearestDistance = Aimbot.FOV
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local screenPoint, visible = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                
                if visible and distance < nearestDistance then
                    nearestPlayer = player
                    nearestDistance = distance
                end
            end
        end
        
        if nearestPlayer then
            Aimbot.Target = nearestPlayer
        end
    end
end)

-- ESP
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

-- Fly Hack
local bodyVelocity
RunService.RenderStepped:Connect(function()
    if Fly.Enabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            humanoid.PlatformStand = true
            
            if not bodyVelocity then
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                bodyVelocity.Parent = rootPart
            end
            
            local moveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            bodyVelocity.Velocity = moveDirection * 50
        end
    elseif bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
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

-- Auto Arrest
RunService.RenderStepped:Connect(function()
    if AutoArrest.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local policeTeam = game:GetService("Teams"):FindFirstChild("Police")
        if policeTeam and LocalPlayer.Team == policeTeam then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Team ~= policeTeam and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < 50 then
                        -- Auto arrest logic would go here
                        -- This is a placeholder for the actual arrest function
                    end
                end
            end
        end
    end
end)

-- Show first tab by default
if next(Tabs) then
    local firstTab = next(Tabs)
    Tabs[firstTab].Visible = true
    CurrentTab = firstTab
end
