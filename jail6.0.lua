-- ExpensiveMods Jailbreak Cheat (Full ESP & Aimbot)
if not game:IsLoaded() then
    game.Loaded:Wait()
end

wait(1)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Очистка
if CoreGui:FindFirstChild("ExpensiveModsFull") then
    CoreGui:FindFirstChild("ExpensiveModsFull"):Destroy()
end

-- Настройки ESP
local ESP = {
    Enabled = false,
    Box2D = false,
    Box3D = false,
    HealthBar = true,
    HealthText = false,
    HealthBarSize = UDim2.new(0, 4, 0, 50),
    Names = true,
    Skeleton = false,
    Box2DColor = Color3.fromRGB(0, 255, 0),
    Box3DColor = Color3.fromRGB(255, 0, 0),
    TextColor = Color3.fromRGB(255, 255, 255),
    SkeletonColor = Color3.fromRGB(255, 255, 0)
}

-- Настройки Aimbot
local Aimbot = {
    Enabled = false,
    FOV = 50,
    MaxDistance = 500,
    VisibilityCheck = true,
    Smoothing = 0.1,
    FOVColor = Color3.fromRGB(255, 255, 255),
    TeamCheck = true
}

-- Настройки Police
local Police = {
    AutoArrest = false,
    ArrestRange = 50
}

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExpensiveModsFull"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- Кружок меню
local CircleButton = Instance.new("TextButton")
CircleButton.Name = "MenuToggle"
CircleButton.Parent = ScreenGui
CircleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
CircleButton.BackgroundTransparency = 0.1
CircleButton.BorderSizePixel = 0
CircleButton.Position = UDim2.new(0, 30, 0, 30)
CircleButton.Size = UDim2.new(0, 60, 0, 60)
CircleButton.Text = ""
CircleButton.ZIndex = 100

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = CircleButton

local CircleText = Instance.new("TextLabel")
CircleText.Name = "CircleText"
CircleText.Parent = CircleButton
CircleText.BackgroundTransparency = 1
CircleText.Position = UDim2.new(0, 0, 0, 0)
CircleText.Size = UDim2.new(1, 0, 1, 0)
CircleText.Font = Enum.Font.GothamBlack
CircleText.Text = "EM"
CircleText.TextColor3 = Color3.fromRGB(255, 255, 255)
CircleText.TextScaled = true
CircleText.ZIndex = 101

-- Главное меню
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Visible = false
MainFrame.ZIndex = 90
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.ZIndex = 91

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 5)
Title.Size = UDim2.new(0, 200, 0, 25)
Title.Font = Enum.Font.GothamBlack
Title.Text = "EXPENSIVEMODS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 92

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Parent = TopBar
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 20, 0, 28)
SubTitle.Size = UDim2.new(0, 200, 0, 20)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "Full ESP & Aimbot"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitle.TextSize = 12
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 92

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.ZIndex = 92

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Контейнер для кнопок вкладок
local TabButtonsContainer = Instance.new("Frame")
TabButtonsContainer.Name = "TabButtonsContainer"
TabButtonsContainer.Parent = MainFrame
TabButtonsContainer.BackgroundTransparency = 1
TabButtonsContainer.Position = UDim2.new(0, 20, 0, 60)
TabButtonsContainer.Size = UDim2.new(1, -40, 0, 40)
TabButtonsContainer.ZIndex = 91

-- Создаем layout для кнопок вкладок
local TabButtonsLayout = Instance.new("UIListLayout")
TabButtonsLayout.Parent = TabButtonsContainer
TabButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
TabButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabButtonsLayout.Padding = UDim.new(0, 10)

-- Контейнер для содержимого вкладок
local TabContentContainer = Instance.new("Frame")
TabContentContainer.Name = "TabContentContainer"
TabContentContainer.Parent = MainFrame
TabContentContainer.BackgroundTransparency = 1
TabContentContainer.Position = UDim2.new(0, 20, 0, 110)
TabContentContainer.Size = UDim2.new(1, -40, 1, -130)
TabContentContainer.ZIndex = 91

-- Анимации
local function SmoothTween(obj, properties, duration, easing)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        easing or Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Анимация появления меню
local function OpenMenu()
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    SmoothTween(MainFrame, {
        Size = UDim2.new(0, 400, 0, 500),
        Position = UDim2.new(0.5, -200, 0.5, -250)
    }, 0.5, Enum.EasingStyle.Back)
end

-- Анимация закрытия меню
local function CloseMenu()
    SmoothTween(MainFrame, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, 0.4, Enum.EasingStyle.Back)
    
    wait(0.4)
    MainFrame.Visible = false
end

-- Анимация кнопки кружка
CircleButton.MouseEnter:Connect(function()
    SmoothTween(CircleButton, {
        Size = UDim2.new(0, 65, 0, 65),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    }, 0.2)
end)

CircleButton.MouseLeave:Connect(function()
    SmoothTween(CircleButton, {
        Size = UDim2.new(0, 60, 0, 60),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    }, 0.2)
end)

-- Анимация кнопки закрытия
CloseButton.MouseEnter:Connect(function()
    SmoothTween(CloseButton, {
        BackgroundColor3 = Color3.fromRGB(255, 80, 80),
        Size = UDim2.new(0, 35, 0, 35)
    }, 0.2)
end)

CloseButton.MouseLeave:Connect(function()
    SmoothTween(CloseButton, {
        BackgroundColor3 = Color3.fromRGB(255, 50, 50),
        Size = UDim2.new(0, 30, 0, 30)
    }, 0.2)
end)

-- Открытие/закрытие меню
local menuOpen = false

CircleButton.MouseButton1Click:Connect(function()
    if not menuOpen then
        menuOpen = true
        OpenMenu()
    else
        menuOpen = false
        CloseMenu()
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    menuOpen = false
    CloseMenu()
end)

-- Создание вкладок
local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Parent = TabButtonsContainer
    TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(0, 80, 0, 35)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 13
    TabButton.ZIndex = 92
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton

    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = name .. "Frame"
    TabFrame.Parent = TabContentContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = false
    TabFrame.ScrollBarThickness = 4
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
    TabFrame.ZIndex = 91

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabFrame
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 8)

    TabButton.MouseEnter:Connect(function()
        if TabButton.TextColor3 ~= Color3.fromRGB(0, 170, 255) then
            SmoothTween(TabButton, {
                BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }, 0.2)
        end
    end)
    
    TabButton.MouseLeave:Connect(function()
        if TabButton.TextColor3 ~= Color3.fromRGB(0, 170, 255) then
            SmoothTween(TabButton, {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                TextColor3 = Color3.fromRGB(200, 200, 200)
            }, 0.2)
        end
    end)
    
    return TabButton, TabFrame
end

-- Создаем вкладки
local CombatTab, CombatFrame = CreateTab("AIMBOT")
local VisualTab, VisualFrame = CreateTab("ESP") 
local MoveTab, MoveFrame = CreateTab("MOVE")
local PoliceTab, PoliceFrame = CreateTab("POLICE")

-- Система переключения вкладок
local currentTab = CombatFrame
CombatFrame.Visible = true

local function SwitchTab(newTab, tabButton)
    if currentTab then
        currentTab.Visible = false
    end
    newTab.Visible = true
    currentTab = newTab
    
    for _, btn in pairs(TabButtonsContainer:GetChildren()) do
        if btn:IsA("TextButton") then
            SmoothTween(btn, {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                TextColor3 = Color3.fromRGB(200, 200, 200)
            }, 0.2)
        end
    end
    
    SmoothTween(tabButton, {
        BackgroundColor3 = Color3.fromRGB(0, 100, 255),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }, 0.2)
end

CombatTab.MouseButton1Click:Connect(function() SwitchTab(CombatFrame, CombatTab) end)
VisualTab.MouseButton1Click:Connect(function() SwitchTab(VisualFrame, VisualTab) end)
MoveTab.MouseButton1Click:Connect(function() SwitchTab(MoveFrame, MoveTab) end)
PoliceTab.MouseButton1Click:Connect(function() SwitchTab(PoliceFrame, PoliceTab) end)

-- Создание элементов управления
local function CreateToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.ZIndex = 92
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
    ToggleLabel.Size = UDim2.new(0, 250, 1, 0)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.ZIndex = 93
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -65, 0.5, -12)
    ToggleButton.Size = UDim2.new(0, 50, 0, 24)
    ToggleButton.ZIndex = 93
    
    local ToggleBtnCorner = Instance.new("UICorner")
    ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
    ToggleBtnCorner.Parent = ToggleButton
    
    local ToggleDot = Instance.new("Frame")
    ToggleDot.Parent = ToggleButton
    ToggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleDot.BorderSizePixel = 0
    ToggleDot.Position = UDim2.new(0, 2, 0, 2)
    ToggleDot.Size = UDim2.new(0, 20, 0, 20)
    ToggleDot.ZIndex = 94
    
    local ToggleDotCorner = Instance.new("UICorner")
    ToggleDotCorner.CornerRadius = UDim.new(1, 0)
    ToggleDotCorner.Parent = ToggleDot
    
    local enabled = false
    
    local function updateToggle()
        if enabled then
            SmoothTween(ToggleDot, {Position = UDim2.new(0, 28, 0, 2)}, 0.2)
            SmoothTween(ToggleButton, {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}, 0.2)
        else
            SmoothTween(ToggleDot, {Position = UDim2.new(0, 2, 0, 2)}, 0.2)
            SmoothTween(ToggleButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
        end
        if callback then callback(enabled) end
    end
    
    ToggleFrame.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateToggle()
    end)
    
    ToggleFrame.MouseEnter:Connect(function()
        SmoothTween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
    end)
    
    ToggleFrame.MouseLeave:Connect(function()
        SmoothTween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}, 0.2)
    end)
    
    return {
        Set = function(state)
            enabled = state
            updateToggle()
        end,
        Get = function() return enabled end
    }
end

-- Создание слайдера
local function CreateSlider(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Parent = parent
    SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.ZIndex = 92
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 8)
    SliderCorner.Parent = SliderFrame
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Parent = SliderFrame
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Position = UDim2.new(0, 15, 0, 5)
    SliderLabel.Size = UDim2.new(1, -30, 0, 20)
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.Text = text .. ": " .. default
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 14
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.ZIndex = 93
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Parent = SliderFrame
    SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Position = UDim2.new(0, 15, 0, 35)
    SliderTrack.Size = UDim2.new(1, -30, 0, 5)
    SliderTrack.ZIndex = 93
    
    local SliderTrackCorner = Instance.new("UICorner")
    SliderTrackCorner.CornerRadius = UDim.new(1, 0)
    SliderTrackCorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Parent = SliderTrack
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.ZIndex = 94
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Parent = SliderTrack
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.BorderSizePixel = 0
    SliderButton.Position = UDim2.new((default - min) / (max - min), -5, 0, -5)
    SliderButton.Size = UDim2.new(0, 10, 0, 15)
    SliderButton.Text = ""
    SliderButton.ZIndex = 95
    
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

-- Функции ESP
local ESPObjects = {}

local function CreateESP(player)
    if not player.Character then return end
    
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    ESPObjects[player] = {
        Box2D = nil,
        Box3D = nil,
        HealthBar = nil,
        HealthText = nil,
        NameTag = nil,
        Skeleton = {}
    }
    
    -- 2D Box
    local box2d = Instance.new("Frame")
    box2d.Name = player.Name .. "Box2D"
    box2d.Parent = ScreenGui
    box2d.BackgroundTransparency = 1
    box2d.BorderSizePixel = 2
    box2d.BorderColor3 = ESP.Box2DColor
    box2d.Visible = false
    box2d.ZIndex = 10
    
    -- 3D Box
    local box3d = Instance.new("BoxHandleAdornment")
    box3d.Name = player.Name .. "Box3D"
    box3d.Adornee = rootPart
    box3d.AlwaysOnTop = true
    box3d.ZIndex = 0
    box3d.Size = Vector3.new(4, 6, 4)
    box3d.Color3 = ESP.Box3DColor
    box3d.Transparency = 0.5
    box3d.Visible = false
    box3d.Parent = rootPart
    
    -- Health Bar
    local healthBar = Instance.new("Frame")
    healthBar.Name = player.Name .. "HealthBar"
    healthBar.Parent = ScreenGui
    healthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Visible = false
    healthBar.ZIndex = 11
    
    local healthFill = Instance.new("Frame")
    healthFill.Name = "HealthFill"
    healthFill.Parent = healthBar
    healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthFill.BorderSizePixel = 0
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    
    -- Health Text
    local healthText = Instance.new("TextLabel")
    healthText.Name = player.Name .. "HealthText"
    healthText.Parent = ScreenGui
    healthText.BackgroundTransparency = 1
    healthText.Text = "HP: 100"
    healthText.TextColor3 = ESP.TextColor
    healthText.TextSize = 14
    healthText.Font = Enum.Font.GothamBold
    healthText.Visible = false
    healthText.ZIndex = 12
    
    -- Name Tag
    local nameTag = Instance.new("TextLabel")
    nameTag.Name = player.Name .. "NameTag"
    nameTag.Parent = ScreenGui
    nameTag.BackgroundTransparency = 1
    nameTag.Text = player.Name
    nameTag.TextColor3 = ESP.TextColor
    nameTag.TextSize = 14
    nameTag.Font = Enum.Font.GothamBold
    nameTag.Visible = false
    nameTag.ZIndex = 12
    
    ESPObjects[player] = {
        Box2D = box2d,
        Box3D = box3d,
        HealthBar = healthBar,
        HealthFill = healthFill,
        HealthText = healthText,
        NameTag = nameTag,
        Character = character
    }
end

local function UpdateESP()
    for player, objects in pairs(ESPObjects) do
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            for _, obj in pairs(objects) do
                if obj then
                    obj:Destroy()
                end
            end
            ESPObjects[player] = nil
        else
            local rootPart = player.Character.HumanoidRootPart
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local head = player.Character:FindFirstChild("Head")
            
            if rootPart and head then
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
                
                if onScreen then
                    -- 2D Box
                    if objects.Box2D then
                        objects.Box2D.Visible = ESP.Enabled and ESP.Box2D
                        objects.Box2D.Size = UDim2.new(0, 100, 0, 150)
                        objects.Box2D.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 75)
                        objects.Box2D.BorderColor3 = ESP.Box2DColor
                    end
                    
                    -- 3D Box
                    if objects.Box3D then
                        objects.Box3D.Visible = ESP.Enabled and ESP.Box3D
                        objects.Box3D.Color3 = ESP.Box3DColor
                    end
                    
                    -- Health Bar
                    if objects.HealthBar and humanoid then
                        objects.HealthBar.Visible = ESP.Enabled and ESP.HealthBar
                        objects.HealthBar.Size = ESP.HealthBarSize
                        objects.HealthBar.Position = UDim2.new(0, screenPos.X + 60, 0, screenPos.Y - 25)
                        
                        local healthPercent = humanoid.Health / humanoid.MaxHealth
                        objects.HealthFill.Size = UDim2.new(healthPercent, 0, 1, 0)
                        
                        if healthPercent > 0.5 then
                            objects.HealthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        elseif healthPercent > 0.2 then
                            objects.HealthFill.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                        else
                            objects.HealthFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                    
                    -- Health Text
                    if objects.HealthText and humanoid then
                        objects.HealthText.Visible = ESP.Enabled and ESP.HealthText
                        objects.HealthText.Text = "HP: " .. math.floor(humanoid.Health)
                        objects.HealthText.Position = UDim2.new(0, screenPos.X + 60, 0, screenPos.Y - 40)
                        objects.HealthText.TextColor3 = ESP.TextColor
                    end
                    
                    -- Name Tag
                    if objects.NameTag then
                        objects.NameTag.Visible = ESP.Enabled and ESP.Names
                        objects.NameTag.Text = player.Name
                        objects.NameTag.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 90)
                        objects.NameTag.TextColor3 = ESP.TextColor
                    end
                else
                    for _, obj in pairs(objects) do
                        if obj and obj:IsA("GuiObject") then
                            obj.Visible = false
                        end
                    end
                end
            end
        end
    end
end

-- Функция FOV Circle
local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOVCircle"
FOVCircle.Parent = ScreenGui
FOVCircle.BackgroundColor3 = Aimbot.FOVColor
FOVCircle.BackgroundTransparency = 0.7
FOVCircle.BorderSizePixel = 0
FOVCircle.Size = UDim2.new(0, Aimbot.FOV * 2, 0, Aimbot.FOV * 2)
FOVCircle.Position = UDim2.new(0.5, -Aimbot.FOV, 0.5, -Aimbot.FOV)
FOVCircle.Visible = Aimbot.Enabled
FOVCircle.ZIndex = 5

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(1, 0)
FOVCorner.Parent = FOVCircle

-- Aimbot функция
local function AimbotFunction()
    if not Aimbot.Enabled or not LocalPlayer.Character then return end
    
    local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
    local closestPlayer = nil
    local closestDistance = Aimbot.FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and rootPart and head then
                -- Team check
                if Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end
                
                -- Distance check
                local distance = (rootPart.Position - localRoot.Position).Magnitude
                if distance > Aimbot.MaxDistance then
                    continue
                end
                
                -- FOV check
                local screenPos = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                local center = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
                local fovDistance = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                
                if fovDistance < closestDistance then
                    -- Visibility check
                    if Aimbot.VisibilityCheck then
                        local ray = Ray.new(workspace.CurrentCamera.CFrame.Position, (head.Position - workspace.CurrentCamera.CFrame.Position).Unit * Aimbot.MaxDistance)
                        local hit, position = workspace:FindPartOnRay(ray, LocalPlayer.Character)
                        
                        if hit and hit:IsDescendantOf(character) then
                            closestPlayer = player
                            closestDistance = fovDistance
                        end
                    else
                        closestPlayer = player
                        closestDistance = fovDistance
                    end
                end
            end
        end
    end
    
    if closestPlayer then
        local targetHead = closestPlayer.Character:FindFirstChild("Head")
        if targetHead then
            local camera = workspace.CurrentCamera
            local smoothed = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, targetHead.Position), Aimbot.Smoothing)
            camera.CFrame = smoothed
        end
    end
end

-- Auto Arrest функция
local function AutoArrestFunction()
    if not Police.AutoArrest or not LocalPlayer.Character or LocalPlayer.Team.Name ~= "Police" then return end
    
    local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Team.Name == "Criminal" then
            local character = player.Character
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            if rootPart then
                local distance = (rootPart.Position - localRoot.Position).Magnitude
                if distance <= Police.ArrestRange then
                    -- Арест игрока
                    local args = {
                        [1] = player.Character.Humanoid,
                        [2] = player.Character.HumanoidRootPart.CFrame
                    }
                    
                    local success, result = pcall(function()
                        game:GetService("ReplicatedStorage").Events.Ar
