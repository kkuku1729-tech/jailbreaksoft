-- ExpensiveMods Jailbreak Cheat (Fixed Menu Layout)
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
if CoreGui:FindFirstChild("ExpensiveModsFinal") then
    CoreGui:FindFirstChild("ExpensiveModsFinal"):Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExpensiveModsFinal"
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
SubTitle.Text = "Premium Cheats"
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
    -- Кнопка вкладки
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

    -- Контент вкладки
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = name .. "Frame"
    TabFrame.Parent = TabContentContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = false
    TabFrame.ScrollBarThickness = 4
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    TabFrame.ZIndex = 91

    -- Layout для элементов вкладки
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabFrame
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 8)

    -- Анимация кнопки вкладки
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

-- Создаем вкладки с правильными названиями
local CombatTab, CombatFrame = CreateTab("COMBAT")
local VisualTab, VisualFrame = CreateTab("VISUAL") 
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
    
    -- Сброс цвета всех кнопок
    for _, btn in pairs(TabButtonsContainer:GetChildren()) do
        if btn:IsA("TextButton") then
            SmoothTween(btn, {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                TextColor3 = Color3.fromRGB(200, 200, 200)
            }, 0.2)
        end
    end
    
    -- Подсветка активной вкладки
    SmoothTween(tabButton, {
        BackgroundColor3 = Color3.fromRGB(0, 100, 255),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }, 0.2)
end

-- Подключаем клики по вкладкам
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
        end
    }
end

-- Добавляем функции в соответствующие вкладки
-- COMBAT вкладка
CreateToggle(CombatFrame, "Aimbot", function(state) print("Aimbot:", state) end)
CreateToggle(CombatFrame, "Silent Aim", function(state) print("Silent Aim:", state) end)
CreateToggle(CombatFrame, "Trigger Bot", function(state) print("Trigger Bot:", state) end)
CreateToggle(CombatFrame, "Wallhack", function(state) print("Wallhack:", state) end)

-- VISUAL вкладка
CreateToggle(VisualFrame, "ESP", function(state) print("ESP:", state) end)
CreateToggle(VisualFrame, "Box ESP", function(state) print("Box ESP:", state) end)
CreateToggle(VisualFrame, "Name Tags", function(state) print("Name Tags:", state) end)
CreateToggle(VisualFrame, "Tracers", function(state) print("Tracers:", state) end)

-- MOVE вкладка
CreateToggle(MoveFrame, "Fly Hack", function(state) print("Fly:", state) end)
CreateToggle(MoveFrame, "Noclip", function(state) print("Noclip:", state) end)
CreateToggle(MoveFrame, "Speed Hack", function(state) print("Speed:", state) end)
CreateToggle(MoveFrame, "Jump Hack", function(state) print("Jump:", state) end)

-- POLICE вкладка
CreateToggle(PoliceFrame, "Auto Arrest", function(state) print("Auto Arrest:", state) end)
CreateToggle(PoliceFrame, "Long Arm", function(state) print("Long Arm:", state) end)
CreateToggle(PoliceFrame, "Rapid Fire", function(state) print("Rapid Fire:", state) end)
CreateToggle(PoliceFrame, "Infinite Ammo", function(state) print("Infinite Ammo:", state) end)

-- Активируем первую вкладку
SwitchTab(CombatFrame, CombatTab)

print("ExpensiveMods Fixed Menu loaded! Click the EM circle to open menu.")
