-- ExpensiveMods Jailbreak Cheat
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- GUI
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
DragCircle.AutoButtonColor = false

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
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -25, 0, 5)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 12
CloseButton.AutoButtonColor = false

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

-- Settings
local Aimbot = {
    Enabled = false,
    FOV = 50,
    Smoothing = 3,
    VisibilityCheck = true,
    AutoShot = false,
    TargetTeam = "Criminals" -- "Criminals", "Police", "All"
}

local ESP = {
    Enabled = false,
    Box2D = false,
    Boxes2D = {}
}

local Fly = {
    Enabled = false,
    Speed = 50,
    BodyVelocity = nil
}

local Noclip = {
    Enabled = false
}

-- Create Tabs
local Tabs = {}
local CurrentTab = nil

local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.Position = UDim2.new(0, 0, 0, (#TabContainer:GetChildren() - 1) * 40)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.new(1, 1, 1)
    TabButton.TextSize = 11
    TabButton.AutoButtonColor = false
    
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = name
    TabFrame.Parent = ButtonContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 0, 0)
    TabFrame.Visible = false
    
    Tabs[name] = TabFrame
    
    TabButton.MouseButton1Click:Connect(function()
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
    
    ToggleFrame.Name = "ToggleFrame"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, -10, 0, 25)
    ToggleFrame.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 30)
    
    ToggleLabel.Name = "ToggleLabel"
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    ToggleLabel.Size = UDim2.new(0, 150, 1, 0)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.new(1, 1, 1)
    ToggleLabel.TextSize = 12
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -30, 0.5, -8)
    ToggleButton.Size = UDim2.new(0, 30, 0, 16)
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.Text = ""
    ToggleButton.AutoButtonColor = false
    
    local enabled = false
    
    local function UpdateToggle()
        if enabled then
            ToggleButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
        else
            ToggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        end
    end
    
    ToggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        UpdateToggle()
        callback(enabled)
    end)
    
    UpdateToggle()
    return ToggleButton
end

local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text
    Button.Parent = parent
    Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, -10, 0, 25)
    Button.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 30)
    Button.Font = Enum.Font.Gotham
    Button.Text = text
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 12
    Button.AutoButtonColor = false
    
    Button.MouseButton1Click:Connect(function()
        callback()
    end)
    
    return Button
end

-- Create Tabs
local CombatTab = CreateTab("Combat")
local VisualsTab = CreateTab("Visuals")
local MovementTab = CreateTab("Movement")

-- Combat Tab
CreateToggle(CombatTab, "Aimbot", function(enabled)
    Aimbot.Enabled = enabled
    FOVCircle.Visible = enabled
end)

CreateToggle(CombatTab, "Visibility Check", function(enabled)
    Aimbot.VisibilityCheck = enabled
end)

CreateToggle(CombatTab, "Auto Shot", function(enabled)
    Aimbot.AutoShot = enabled
end)

local targetTeamButton = CreateButton(CombatTab, "Target: " .. Aimbot.TargetTeam, function()
    if Aimbot.TargetTeam == "Criminals" then
        Aimbot.TargetTeam = "Police"
    elseif Aimbot.TargetTeam == "Police" then
        Aimbot.TargetTeam = "All"
    else
        Aimbot.TargetTeam = "Criminals"
    end
    targetTeamButton.Text = "Target: " .. Aimbot.TargetTeam
end)

-- Visuals Tab
CreateToggle(VisualsTab, "ESP", function(enabled)
    ESP.Enabled = enabled
    if not enabled then
        for _, box in pairs(ESP.Boxes2D) do
            if box then box:Destroy() end
        end
        ESP.Boxes2D = {}
    end
end)

CreateToggle(VisualsTab, "2D Box ESP", function(enabled)
    ESP.Box2D = enabled
end)

-- Movement Tab
CreateToggle(MovementTab, "Fly Hack", function(enabled)
    Fly.Enabled = enabled
    if not enabled and Fly.BodyVelocity then
        Fly.BodyVelocity:Destroy()
        Fly.BodyVelocity = nil
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end
end)

CreateToggle(MovementTab, "Noclip", function(enabled)
    Noclip.Enabled = enabled
end)

-- Aimbot Functions
local function IsValidTarget(player)
    if not player.Character then return false end
    if not player.Character:FindFirstChild("Humanoid") then return false end
    if player.Character.Humanoid.Health <= 0 then return false end
    
    if Aimbot.TargetTeam == "Criminals" then
        return player.Team and player.Team.Name == "Criminal"
    elseif Aimbot.TargetTeam == "Police" then
        return player.Team and player.Team.Name == "Police"
    else
        return true
    end
end

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

local function FindNearestTarget()
    local nearestPlayer = nil
    local nearestDistance = Aimbot.FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsValidTarget(player) then
            local head = player.Character:FindFirstChild("Head")
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

-- ESP Functions
local function Create2DBox(player)
    if not player.Character then return end
    
    local box = Instance.new("Frame")
    box.Name = "ESP_Box2D_" .. player.Name
    box.BackgroundColor3 = Color3.new(1, 0, 0)
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
    
    ESP.Boxes2D[player] = box
    return box
end

local function Update2DBox(player)
    local box = ESP.Boxes2D[player]
    if not box or not player.Character then
        if box then box.Visible = false end
        return
    end
    
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        local rootPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
        if onScreen then
            box.Position = UDim2.new(0, rootPos.X - 40, 0, rootPos.Y - 60)
            box.Visible = true
            
            if player.Team then
                box.BackgroundColor3 = player.Team.TeamColor.Color
            else
                box.BackgroundColor3 = Color3.new(1, 0, 0)
            end
        else
            box.Visible = false
        end
    else
        box.Visible = false
    end
end

-- Fly Functions
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
    end
end

-- Main Loops
RunService.RenderStepped:Connect(function()
    -- Aimbot
    if Aimbot.Enabled then
        local target = FindNearestTarget()
        if target and target.Character then
            local head = target.Character:FindFirstChild("Head")
            if head then
                local screenPosition = Workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                local targetX = screenPosition.X
                local targetY = screenPosition.Y
                local currentX = Mouse.X
                local currentY = Mouse.Y
                
                local deltaX = (targetX - currentX) / Aimbot.Smoothing
                local deltaY = (targetY - currentY) / Aimbot.Smoothing
                
                mousemoverel(deltaX, deltaY)
                
                if Aimbot.AutoShot then
                    mouse1click()
                end
            end
        end
    end
    
    -- ESP
    if ESP.Enabled and ESP.Box2D then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if not ESP.Boxes2D[player] then
                    Create2DBox(player)
                end
                Update2DBox(player)
            end
        end
    end
    
    -- Fly
    UpdateFly()
end)

-- Noclip
RunService.Stepped:Connect(function()
    if Noclip.Enabled and LocalPlayer.Character and not Fly.Enabled then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- GUI Controls
DragCircle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Initialize first tab
Tabs["Combat"].Visible = true
CurrentTab = "Combat"

-- Player tracking
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        if ESP.Enabled and ESP.Box2D then
            Create2DBox(player)
        end
    end)
end)

print("ExpensiveMods injected! Click the circle to open menu.")
