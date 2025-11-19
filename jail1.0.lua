-- ExpensiveMods Jailbreak Cheat
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Переменные для функций
local Aimbot = {
    Enabled = false,
    Target = nil,
    FOV = 50,
    Smoothing = 0.1
}

local ESP = {
    Enabled = false,
    Boxes = {},
    Names = {},
    Distances = {}
}

local Fly = {
    Enabled = false,
    Speed = 50
}

local Noclip = {
    Enabled = false
}

local AutoArrest = {
    Enabled = false,
    Range = 50
}

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExpensiveMods"
ScreenGui.Parent = game.CoreGui

-- Кружок для открытия меню
local CircleButton = Instance.new("Frame")
CircleButton.Name = "CircleButton"
CircleButton.Parent = ScreenGui
CircleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CircleButton.BackgroundTransparency = 0.3
CircleButton.BorderSizePixel = 0
CircleButton.Position = UDim2.new(0, 20, 0, 20)
CircleButton.Size = UDim2.new(0, 50, 0, 50)
CircleButton.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = CircleButton

local CircleText = Instance.new("TextLabel")
CircleText.Name = "CircleText"
CircleText.Parent = CircleButton
CircleText.BackgroundTransparency = 1
CircleText.Position = UDim2.new(0, 0, 0, 0)
CircleText.Size = UDim2.new(1, 0, 1, 0)
CircleText.Font = Enum.Font.GothamBold
CircleText.Text = "EM"
CircleText.TextColor3 = Color3.fromRGB(255, 255, 255)
CircleText.TextScaled = true

-- Главное меню
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "ExpensiveMods"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.Size = UDim2.new(1, 0, 1, -40)

-- Функции анимации
local function TweenObject(obj, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Перетаскивание меню
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Анимация кнопки кружка
CircleButton.MouseEnter:Connect(function()
    TweenObject(CircleButton, {Size = UDim2.new(0, 55, 0, 55)}, 0.2)
end)

CircleButton.MouseLeave:Connect(function()
    TweenObject(CircleButton, {Size = UDim2.new(0, 50, 0, 50)}, 0.2)
end)

-- Открытие/закрытие меню
CircleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        TweenObject(MainFrame, {Position = UDim2.new(0.5, -150, 0.5, -200)}, 0.3)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    TweenObject(MainFrame, {Position = UDim2.new(0.5, -150, 1, 50)}, 0.3)
    wait(0.3)
    MainFrame.Visible = false
end)

-- Создание вкладок
local Tabs = {}
local CurrentTab = nil

function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Parent = TopBar
    TabButton.BackgroundTransparency = 1
    TabButton.Size = UDim2.new(0, 60, 1, 0)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabButton.TextSize = 12
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = name .. "Frame"
    TabFrame.Parent = TabContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = false
    TabFrame.ScrollBarThickness = 0
    
    TabButton.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Visible = false
        end
        TabFrame.Visible = true
        CurrentTab = TabFrame
        
        -- Анимация кнопок вкладок
        for _, btn in pairs(TopBar:GetChildren()) do
            if btn:IsA("TextButton") and btn.Name ~= "CloseButton" then
                TweenObject(btn, {TextColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
            end
        end
        TweenObject(TabButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
    end)
    
    Tabs[name] = TabFrame
    return TabFrame
end

-- Создание элементов управления
function CreateToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = text .. "Toggle"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
    ToggleLabel.Size = UDim2.new(0, 200, 1, 0)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Name = "Toggle"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -55, 0.5, -10)
    ToggleButton.Size = UDim2.new(0, 50, 0, 20)
    
    local ToggleBtnCorner = Instance.new("UICorner")
    ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
    ToggleBtnCorner.Parent = ToggleButton
    
    local ToggleDot = Instance.new("Frame")
    ToggleDot.Name = "Dot"
    ToggleDot.Parent = ToggleButton
    ToggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleDot.BorderSizePixel = 0
    ToggleDot.Position = UDim2.new(0, 2, 0, 2)
    ToggleDot.Size = UDim2.new(0, 16, 0, 16)
    
    local ToggleDotCorner = Instance.new("UICorner")
    ToggleDotCorner.CornerRadius = UDim.new(1, 0)
    ToggleDotCorner.Parent = ToggleDot
    
    local enabled = false
    
    local function updateToggle()
        if enabled then
            TweenObject(ToggleDot, {Position = UDim2.new(0, 32, 0, 2)}, 0.2)
            TweenObject(ToggleButton, {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}, 0.2)
        else
            TweenObject(ToggleDot, {Position = UDim2.new(0, 2, 0, 2)}, 0.2)
            TweenObject(ToggleButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
        end
    end
    
    ToggleFrame.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateToggle()
        callback(enabled)
    end)
    
    return {
        Set = function(state)
            enabled = state
            updateToggle()
            callback(enabled)
        end
    }
end

function CreateSlider(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = text .. "Slider"
    SliderFrame.Parent = parent
    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Size = UDim2.new(1, -20, 0, 60)
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 6)
    SliderCorner.Parent = SliderFrame
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "Label"
    SliderLabel.Parent = SliderFrame
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Position = UDim2.new(0, 15, 0, 5)
    SliderLabel.Size = UDim2.new(1, -30, 0, 20)
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.Text = text .. ": " .. default
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 14
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Name = "Track"
    SliderTrack.Parent = SliderFrame
    SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Position = UDim2.new(0, 15, 0, 35)
    SliderTrack.Size = UDim2.new(1, -30, 0, 5)
    
    local SliderTrackCorner = Instance.new("UICorner")
    SliderTrackCorner.CornerRadius = UDim.new(1, 0)
    SliderTrackCorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    SliderFill.Parent = SliderTrack
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "Button"
    SliderButton.Parent = SliderTrack
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.BorderSizePixel = 0
    SliderButton.Position = UDim2.new((default - min) / (max - min), -5, 0, -5)
    SliderButton.Size = UDim2.new(0, 10, 0, 15)
    SliderButton.Text = ""
    
    local SliderBtnCorner = Instance.new("UICorner")
    SliderBtnCorner.CornerRadius = UDim.new(1, 0)
    SliderBtnCorner.Parent = SliderButton
    
    local dragging = false
    
    local function updateSlider(value)
        local percent = math.clamp((value - min) / (max - min), 0, 1)
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        SliderButton.Position = UDim2.new(percent, -5, 0, -5)
        SliderLabel.Text = text .. ": " .. math.floor(value)
        callback(value)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    SliderTrack.MouseButton1Down:Connect(function(x)
        local percent = (x - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
        local value = min + (max - min) * percent
        updateSlider(value)
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local percent = (input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
            local value = min + (max - min) * math.clamp(percent, 0, 1)
            updateSlider(value)
        end
    end)
    
    return {
        Set = function(value)
            updateSlider(value)
        end
    }
end

-- Создание вкладок и элементов
local CombatTab = CreateTab("Combat")
local VisualsTab = CreateTab("Visuals")
local MovementTab = CreateTab("Movement")
local PoliceTab = CreateTab("Police")

-- Aimbot
local AimbotToggle = CreateToggle(CombatTab, "Aimbot", function(state)
    Aimbot.Enabled = state
end)

local FOVSlider = CreateSlider(CombatTab, "Aimbot FOV", 10, 200, 50, function(value)
    Aimbot.FOV = value
end)

-- ESP
local ESPToggle = CreateToggle(VisualsTab, "ESP", function(state)
    ESP.Enabled = state
end)

-- Fly Hack
local FlyToggle = CreateToggle(MovementTab, "Fly Hack", function(state)
    Fly.Enabled = state
    if state then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local fly = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlyVelocity")
            if fly then
                fly:Destroy()
            end
        end
    end
end)

local FlySpeedSlider = CreateSlider(MovementTab, "Fly Speed", 10, 100, 50, function(value)
    Fly.Speed = value
end)

-- Noclip
local NoclipToggle = CreateToggle(MovementTab, "Noclip", function(state)
    Noclip.Enabled = state
end)

-- Auto Arrest
local AutoArrestToggle = CreateToggle(PoliceTab, "Auto Arrest", function(state)
    AutoArrest.Enabled = state
end)

local ArrestRangeSlider = CreateSlider(PoliceTab, "Arrest Range", 10, 100, 50, function(value)
    AutoArrest.Range = value
end)

-- Функции чита
-- Aimbot
RunService.RenderStepped:Connect(function()
    if Aimbot.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local closestPlayer = nil
        local closestDistance = Aimbot.FOV
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestPlayer = player
                    closestDistance = distance
                end
            end
        end
        
        if closestPlayer then
            Aimbot.Target = closestPlayer
        end
    end
end)

-- ESP
local function updateESP()
    for _, obj in pairs(ESP.Boxes) do
        if obj then obj:Destroy() end
    end
    for _, obj in pairs(ESP.Names) do
        if obj then obj:Destroy() end
    end
    for _, obj in pairs(ESP.Distances) do
        if obj then obj:Destroy() end
    end
    
    ESP.Boxes = {}
    ESP.Names = {}
    ESP.Distances = {}
    
    if not ESP.Enabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = player.Name .. "ESP"
            box.Adornee = player.Character.HumanoidRootPart
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Size = Vector3.new(4, 6, 4)
            box.Color3 = Color3.fromRGB(0, 255, 0)
            box.Transparency = 0.5
            box.Parent = player.Character.HumanoidRootPart
            
            table.insert(ESP.Boxes, box)
        end
    end
end

Players.PlayerAdded:Connect(updateESP)
Players.PlayerRemoving:Connect(updateESP)

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
RunService.Heartbeat:Connect(function()
    if AutoArrest.Enabled and LocalPlayer.Team and LocalPlayer.Team.Name == "Police" then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance <= AutoArrest.Range then
                    -- Код для ареста игрока
                    game:GetService("ReplicatedStorage").Arrest:InvokeServer(player)
                end
            end
        end
    end
end)

-- Fly Hack
RunService.Heartbeat:Connect(function()
    if Fly.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local flyPart = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlyVelocity")
        if flyPart then
            local moveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            flyPart.Velocity = moveDirection * Fly.Speed
        end
    end
end)

-- Активация первой вкладки
if TopBar:FindFirstChild("CombatTab") then
    TopBar.CombatTab:MouseButton1Click()
end

print("ExpensiveMods loaded successfully!")
