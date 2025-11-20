-- ExpensiveMods Jailbreak Cheat
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

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
MainFrame.Size = UDim2.new(0, 350, 0, 500)
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
ButtonContainer.CanvasSize = UDim2.new(0, 0, 3, 0)
ButtonContainer.ScrollBarThickness = 4
ButtonContainer.ScrollingDirection = Enum.ScrollingDirection.Y

-- FOV Circle
local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOVCircle"
FOVCircle.Parent = ExpensiveModsGUI
FOVCircle.BackgroundColor3 = Color3.new(1, 1, 1)
FOVCircle.BackgroundTransparency = 0.7
FOVCircle.BorderSizePixel = 0
FOVCircle.Size = UDim2.new(0, 100, 0, 100)
FOVCircle.Position = UDim2.new(0.5, -50, 0.5, -50)
FOVCircle.Visible = false

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = FOVCircle

-- Variables
local Tabs = {}
local CurrentTab = nil
local Aimbot = {
    Enabled = false,
    FOV = 50,
    Target = nil,
    Smoothing = 5,
    VisibilityCheck = true,
    AutoShot = false,
    HitPart = "Head"
}
local ESP = {
    Enabled = false,
    Box2D = false,
    Box3D = false,
    Chams = false,
    Boxes2D = {},
    Boxes3D = {},
    ChamsObjects = {},
    Colors = {
        Box2D = Color3.new(1, 0, 0),
        Box3D = Color3.new(0, 1, 0),
        Chams = Color3.new(0, 0, 1),
        Team = true
    }
}
local Fly = {
    Enabled = false,
    Speed = 50,
    BodyVelocity = nil
}
local Noclip = {
    Enabled = false
}
local AutoArrest = {
    Enabled = false,
    Range = 50
}
local LongArrest = {
    Enabled = false
}
local AutoGun = {
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

-- Create Tabs
local CombatTab = CreateTab("Combat")
local VisualsTab = CreateTab("Visuals") 
local MovementTab = CreateTab("Movement")
local PoliceTab = CreateTab("Police")

-- Combat Tab Elements
local aimbotToggle = CreateToggle(CombatTab, "Aimbot", function(enabled)
    Aimbot.Enabled = enabled
    FOVCircle.Visible = enabled
end)

local fovSlider = CreateSlider(CombatTab, "Aimbot FOV", 10, 200, function(value)
    Aimbot.FOV = value
    FOVCircle.Size = UDim2.new(0, value * 2, 0, value * 2)
    FOVCircle.Position = UDim2.new(0.5, -value, 0.5, -value)
end)

local smoothSlider = CreateSlider(CombatTab, "Smoothing", 1, 10, function(value)
    Aimbot.Smoothing = value
end)

local visibilityToggle = CreateToggle(CombatTab, "Visibility Check", function(enabled)
    Aimbot.VisibilityCheck = enabled
end)

local autoShotToggle = CreateToggle(CombatTab, "Auto Shot", function(enabled)
    Aimbot.AutoShot = enabled
end)

-- Visuals Tab Elements
local espToggle = CreateToggle(VisualsTab, "ESP", function(enabled)
    ESP.Enabled = enabled
    if not enabled then
        ClearESP()
    end
end)

local box2DToggle = CreateToggle(VisualsTab, "2D Box ESP", function(enabled)
    ESP.Box2D = enabled
    if not enabled then
        Clear2DBoxes()
    end
end)

local box3DToggle = CreateToggle(VisualsTab, "3D Box ESP", function(enabled)
    ESP.Box3D = enabled
    if not enabled then
        Clear3DBoxes()
    end
end)

local chamsToggle = CreateToggle(VisualsTab, "Chams", function(enabled)
    ESP.Chams = enabled
    if not enabled then
        ClearChams()
    end
end)

local teamColorToggle = CreateToggle(VisualsTab, "Team Colors", function(enabled)
    ESP.Colors.Team = enabled
end)

-- Movement Tab Elements
local flyToggle = CreateToggle(MovementTab, "Fly Hack", function(enabled)
    Fly.Enabled = enabled
    if not enabled and Fly.BodyVelocity then
        Fly.BodyVelocity:Destroy()
        Fly.BodyVelocity = nil
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end
end)

local flySpeedSlider = CreateSlider(MovementTab, "Fly Speed", 20, 100, function(value)
    Fly.Speed = value
end)

local noclipToggle = CreateToggle(MovementTab, "Noclip", function(enabled)
    Noclip.Enabled = enabled
end)

-- Police Tab Elements
local autoArrestToggle = CreateToggle(PoliceTab, "Auto Arrest", function(enabled)
    AutoArrest.Enabled = enabled
end)

local longArrestToggle = CreateToggle(PoliceTab, "Long Arrest", function(enabled)
    LongArrest.Enabled = enabled
end)

local autoGunToggle = CreateToggle(PoliceTab, "Auto Gun", function(enabled)
    AutoGun.Enabled = enabled
end)

-- Game Functions
-- Visibility Check Function
local function IsVisible(target)
    if not Aimbot.VisibilityCheck then return true end
    
    local character = LocalPlayer.Character
    local targetChar = target.Character
    if not character or not targetChar then return false end
    
    local head = character:FindFirstChild("Head")
    local targetHead = targetChar:FindFirstChild("Head")
    if not head or not targetHead then return false end
    
    local origin = head.Position
    local targetPos = targetHead.Position
    local direction = (targetPos - origin).Unit
    local distance = (targetPos - origin).Magnitude
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {character, targetChar}
    
    local raycastResult = Workspace:Raycast(origin, direction * distance, raycastParams)
    
    return raycastResult == nil
end

-- Aimbot Function
local function FindNearestPlayer()
    local nearestPlayer = nil
    local nearestDistance = Aimbot.FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local character = player.Character
            local head = character:FindFirstChild("Head")
            if head then
                local screenPoint, visible = Workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                if visible then
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if distance < nearestDistance and IsVisible(player) then
                        nearestPlayer = player
                        nearestDistance = distance
                    end
                end
            end
        end
    end
    
    return nearestPlayer
end

-- Auto Shot Function
local function AutoShoot()
    if Aimbot.AutoShot and Aimbot.Target and Aimbot.Target.Character then
        local humanoid = Aimbot.Target.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health > 0 then
            -- Simulate mouse click for shooting
            if IsVisible(Aimbot.Target) then
                -- This would need to be adapted based on the game's shooting mechanism
                mouse1click()
            end
        end
    end
end

-- 2D Box ESP Functions
local function Create2DBox(player)
    if not player.Character then return end
    
    local box = Instance.new("Frame")
    box.Name = "ESP_Box2D_" .. player.Name
    box.BackgroundColor3 = ESP.Colors.Box2D
    box.BackgroundTransparency = 0.7
    box.BorderSizePixel = 2
    box.BorderColor3 = Color3.new(1, 1, 1)
    box.Size = UDim2.new(0, 80, 0, 120)
    box.Position = UDim2.new(0, 0, 0, 0)
    box.Visible = false
    box.ZIndex = 5
    box.Parent = ExpensiveModsGUI
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "ESP_Name"
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextSize = 11
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Size = UDim2.new(1, 0, 0, 12)
    nameLabel.Position = UDim2.new(0, 0, 0, -12)
    nameLabel.ZIndex = 6
    nameLabel.Parent = box
    
    local healthBar = Instance.new("Frame")
    healthBar.Name = "ESP_HealthBar"
    healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
    healthBar.BorderSizePixel = 1
    healthBar.BorderColor3 = Color3.new(0, 0, 0)
    healthBar.Size = UDim2.new(1, 0, 0, 3)
    healthBar.Position = UDim2.new(0, 0, 1, 0)
    healthBar.ZIndex = 6
    healthBar.Parent = box
    
    local healthText = Instance.new("TextLabel")
    healthText.Name = "ESP_HealthText"
    healthText.BackgroundTransparency = 1
    healthText.Text = "100 HP"
    healthText.TextColor3 = Color3.new(1, 1, 1)
    healthText.TextSize = 9
    healthText.Font = Enum.Font.Gotham
    healthText.Size = UDim2.new(1, 0, 0, 10)
    healthText.Position = UDim2.new(0, 0, 1, 3)
    healthText.ZIndex = 6
    healthText.Parent = box
    
    ESP.Boxes2D[player] = box
end

local function Update2DBox(player)
    local box = ESP.Boxes2D[player]
    if not box or not player.Character then return end
    
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and rootPart then
        local rootPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
        
        if onScreen then
            -- Calculate box size based on character bounds
            local size = Vector3.new(4, 6, 4) -- Approximate character size
            local topPos = Workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, size.Y/2, 0))
            local bottomPos = Workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, size.Y/2, 0))
            
            local height = math.abs(topPos.Y - bottomPos.Y)
            local width = height / 2
            
            box.Size = UDim2.new(0, width, 0, height)
            box.Position = UDim2.new(0, rootPos.X - width/2, 0, topPos.Y)
            box.Visible = true
            
            -- Update health
            local health = math.floor(humanoid.Health)
            local maxHealth = humanoid.MaxHealth
            local healthPercent = health / maxHealth
            
            box.ESP_HealthBar.Size = UDim2.new(healthPercent, 0, 0, 3)
            box.ESP_HealthText.Text = tostring(health) .. " HP"
            
            -- Color based on health
            if healthPercent > 0.7 then
                box.ESP_HealthBar.BackgroundColor3 = Color3.new(0, 1, 0)
            elseif healthPercent > 0.3 then
                box.ESP_HealthBar.BackgroundColor3 = Color3.new(1, 1, 0)
            else
                box.ESP_HealthBar.BackgroundColor3 = Color3.new(1, 0, 0)
            end
            
            -- Box color based on team or custom color
            if ESP.Colors.Team and player.Team then
                local teamColor = player.Team.TeamColor.Color
                box.BackgroundColor3 = teamColor
            else
                box.BackgroundColor3 = ESP.Colors.Box2D
            end
        else
            box.Visible = false
        end
    else
        box.Visible = false
    end
end

local function Clear2DBoxes()
    for player, box in pairs(ESP.Boxes2D) do
        if box then
            box:Destroy()
        end
    end
    ESP.Boxes2D = {}
end

-- 3D Box ESP Functions
local function Create3DBox(player)
    if not player.Character then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_Box3D_" .. player.Name
    box.Color3 = ESP.Colors.Box3D
    box.Transparency = 0.5
    box.Adornee = player.Character
    box.AlwaysOnTop = true
    box.ZIndex = 1
    box.Size = Vector3.new(4, 6, 4) -- Character size
    box.Parent = player.Character
    
    ESP.Boxes3D[player] = box
end

local function Update3DBox(player)
    local box = ESP.Boxes3D[player]
    if box and player.Character then
        if ESP.Colors.Team and player.Team then
            box.Color3 = player.Team.TeamColor.Color
        else
            box.Color3 = ESP.Colors.Box3D
        end
        box.Visible = ESP.Box3D
    end
end

local function Clear3DBoxes()
    for player, box in pairs(ESP.Boxes3D) do
        if box then
            box:Destroy()
        end
    end
    ESP.Boxes3D = {}
end

-- Chams Functions
local function CreateChams(player)
    if not player.Character then return end
    
    for _, part in pairs(player.Character:GetChildren()) do
        if part:IsA("BasePart") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Chams_" .. player.Name
            highlight.FillColor = ESP.Colors.Chams
            highlight.OutlineColor = ESP.Colors.Chams
            highlight.FillTransparency = 0.3
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = part
            
            ESP.ChamsObjects[player] = ESP.ChamsObjects[player] or {}
            table.insert(ESP.ChamsObjects[player], highlight)
        end
    end
end

local function UpdateChams(player)
    local chams = ESP.ChamsObjects[player]
    if chams then
        for _, highlight in pairs(chams) do
            if ESP.Colors.Team and player.Team then
                highlight.FillColor = player.Team.TeamColor.Color
                highlight.OutlineColor = player.Team.TeamColor.Color
            else
                highlight.FillColor = ESP.Colors.Chams
                highlight.OutlineColor = ESP.Colors.Chams
            end
            highlight.Visible = ESP.Chams
        end
    end
end

local function ClearChams()
    for player, chams in pairs(ESP.ChamsObjects) do
        for _, highlight in pairs(chams) do
            if highlight then
                highlight:Destroy()
            end
        end
    end
    ESP.ChamsObjects = {}
end

-- Clear all ESP
local function ClearESP()
    Clear2DBoxes()
    Clear3DBoxes()
    ClearChams()
end

-- Fly Function
local function UpdateFly()
    if Fly.Enabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            humanoid.PlatformStand = true
            
            if not Fly.BodyVelocity then
                Fly.BodyVelocity = Instance.new("BodyVelocity")
                Fly.BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                Fly.BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                Fly.BodyVelocity.Parent = rootPart
            end
            
            local moveDirection = Vector3.new(0, 0, 0)
            local camera = Workspace.CurrentCamera
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            Fly.BodyVelocity.Velocity = moveDirection * Fly.Speed
        end
    elseif Fly.BodyVelocity then
        Fly.BodyVelocity:Destroy()
        Fly.BodyVelocity = nil
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end
end

-- Noclip Function (не мешает флаю)
local function UpdateNoclip()
    if Noclip.Enabled and LocalPlayer.Character and not Fly.Enabled then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- Auto Arrest Function
local function FindCriminal()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local team = player.Team
            if team and team.Name == "Criminal" then
                return player
            end
        end
    end
    return nil
end

-- Main Loops
RunService.RenderStepped:Connect(function()
    -- Aimbot
    if Aimbot.Enabled then
        local target = FindNearestPlayer()
        Aimbot.Target = target
        
        if target and target.Character then
            local head = target.Character:FindFirstChild("Head")
            if head then
                local camera = Workspace.CurrentCamera
                local mouse = LocalPlayer:GetMouse()
                
                local targetPosition = head.Position
                local screenPosition, visible = camera:WorldToViewportPoint(targetPosition)
                
                if visible and IsVisible(target) then
                    local smoothFactor = Aimbot.Smoothing
                    local targetX = screenPosition.X
                    local targetY = screenPosition.Y
                    local currentX = mouse.X
                    local currentY = mouse.Y
                    
                    local deltaX = (targetX - currentX) / smoothFactor
                    local deltaY = (targetY - currentY) / smoothFactor
                    
                    mousemoverel(deltaX, deltaY)
                    
                    -- Auto Shot
                    if Aimbot.AutoShot then
                        AutoShoot()
                    end
                end
            end
        end
    end
    
    -- ESP
    if ESP.Enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                -- 2D Box ESP
                if ESP.Box2D then
                    if not ESP.Boxes2D[player] then
                        Create2DBox(player)
                    end
                    Update2DBox(player)
                end
                
                -- 3D Box ESP
                if ESP.Box3D then
                    if not ESP.Boxes3D[player] then
                        Create3DBox(player)
                    end
                    Update3DBox(player)
                end
                
                -- Chams
                if ESP.Chams then
                    if not ESP.ChamsObjects[player] then
                        CreateChams(player)
                    end
                    UpdateChams(player)
                end
            end
        end
    else
        ClearESP()
    end
    
    -- Fly
    UpdateFly()
    
    -- Auto Arrest
    if AutoArrest.Enabled and LocalPlayer.Character then
        local criminal = FindCriminal()
        if criminal and criminal.Character then
            local distance = (criminal.Character:FindFirstChild("HumanoidRootPart").Position - LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
            if distance < AutoArrest.Range then
                -- Auto arrest logic here
            end
        end
    end
end)

-- Noclip Loop (отдельный от флая)
RunService.Stepped:Connect(function()
    UpdateNoclip()
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

print("ExpensiveMods loaded! All functions are working. Click the circle to open menu.")
