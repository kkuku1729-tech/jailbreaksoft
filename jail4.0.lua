-- ExpensiveMods Jailbreak Cheat (Wide Menu Fix)
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
if CoreGui:FindFirstChild("ExpensiveModsV3") then
    CoreGui:FindFirstChild("ExpensiveModsV3"):Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExpensiveModsV3"
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

-- Главное меню (ШИРОКОЕ)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
MainFrame.Size = UDim2.new(0, 500, 0, 600) -- Шире и выше
MainFrame.Visible = false
MainFrame.ZIndex = 90
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 60) -- Выше
TopBar.ZIndex = 91

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 15)
TopCorner.Parent = TopBar

-- Заголовок и кнопка закрытия
local TitleContainer = Instance.new("Frame")
TitleContainer.Name = "TitleContainer"
TitleContainer.Parent = TopBar
TitleContainer.BackgroundTransparency = 1
TitleContainer.Position = UDim2.new(0, 0, 0, 0)
TitleContainer.Size = UDim2.new(1, 0, 1, 0)
TitleContainer.ZIndex = 92

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TitleContainer
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 25, 0, 5)
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Font = Enum.Font.GothamBlack
Title.Text = "EXPENSIVEMODS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 93

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Parent = TitleContainer
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 25, 0, 30)
SubTitle.Size = UDim2.new(0, 300, 0, 25)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "Aimbot & More"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitle.TextSize = 14
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 93

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleContainer
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -45, 0.5, -15)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.ZIndex = 93

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Контейнер вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 20, 0, 70) -- Отступы
TabContainer.Size = UDim2.new(1, -40, 1, -80) -- Больше места
TabContainer.ZIndex = 91

-- Кнопки вкладок (горизонтальные)
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Parent = TopBar
TabButtons.BackgroundTransparency = 1
TabButtons.Position = UDim2.new(0, 300, 0, 15)
TabButtons.Size = UDim2.new(0, 180, 0, 30)
TabButtons.ZIndex = 92

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
        Size = UDim2.new(0, 500, 0, 600),
        Position = UDim2.new(0.5, -250, 0.5, -300)
    }, 0.5, Enum.EasingStyle.Back)
    
    wait(0.3)
    -- Появление элементов с задержкой
    local children = MainFrame:GetDescendants()
    for i, child in pairs(children) do
        if child:IsA("Frame") and child ~= MainFrame then
            child.BackgroundTransparency = 1
        elseif child:IsA("TextLabel") or child:IsA("TextButton") then
            child.TextTransparency = 1
        end
    end
    
    for i, child in pairs(children) do
        if child:IsA("Frame") and child ~= MainFrame then
            wait(0.02)
            SmoothTween(child, {BackgroundTransparency = 0}, 0.3)
        elseif child:IsA("TextLabel") or child:IsA("TextButton") then
            wait(0.02)
            SmoothTween(child, {TextTransparency = 0}, 0.3)
        end
    end
end

-- Анимация закрытия меню
local function CloseMenu()
    local children = MainFrame:GetDescendants()
    for i, child in pairs(children) do
        if child:IsA("Frame") and child ~= MainFrame then
            SmoothTween(child, {BackgroundTransparency = 1}, 0.2)
        elseif child:IsA("TextLabel") or child:IsA("TextButton") then
            SmoothTween(child, {TextTransparency = 1}, 0.2)
        end
    end
    
    wait(0.3)
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
    
    SmoothTween(CircleText, {
        TextColor3 = Color3.fromRGB(0, 170, 255)
    }, 0.2)
end)

CircleButton.MouseLeave:Connect(function()
    SmoothTween(CircleButton, {
        Size = UDim2.new(0, 60, 0, 60),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    }, 0.2)
    
    SmoothTween(CircleText, {
        TextColor3 = Color3.fromRGB(255, 255, 255)
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

-- Создание вкладок с улучшенным расположением
local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Parent = TabButtons
    TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(0, 85, 0, 30) -- Шире кнопки
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 13
    TabButton.ZIndex = 93
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = name .. "Frame"
    TabFrame.Parent = TabContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = false
    TabFrame.ScrollBarThickness = 3
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
    TabFrame.ZIndex = 91
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabFrame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10) -- Больше расстояния между элементами
    
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

-- Создаем вкладки
local CombatTab, CombatFrame = CreateTab("COMBAT")
local VisualTab, VisualFrame = CreateTab("VISUAL")
local MoveTab, MoveFrame = CreateTab("MOVEMENT")
local PoliceTab, PoliceFrame = CreateTab("POLICE")

-- Располагаем кнопки вкладок с пробелами
CombatTab.Position = UDim2.new(0, 0, 0, 0)
VisualTab.Position = UDim2.new(0, 90, 0, 0)
MoveTab.Position = UDim2.new(0, 180, 0, 0)

-- Активация вкладок
local currentTab = CombatFrame
CombatFrame.Visible = true

local function SwitchTab(newTab, tabButton)
    currentTab.Visible = false
    newTab.Visible = true
    currentTab = newTab
    
    -- Сброс цвета всех кнопок
    for _, btn in pairs(TabButtons:GetChildren()) do
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

CombatTab.MouseButton1Click:Connect(function() SwitchTab(CombatFrame, CombatTab) end)
VisualTab.MouseButton1Click:Connect(function() SwitchTab(VisualFrame, VisualTab) end)
MoveTab.MouseButton1Click:Connect(function() SwitchTab(MoveFrame, MoveTab) end)
PoliceTab.MouseButton1Click:Connect(function() SwitchTab(PoliceFrame, PoliceTab) end)

-- Создание переключателей с улучшенным дизайном
local function CreateAnimatedToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(1, -40, 0, 50) -- Уже с отступами
    ToggleFrame.ZIndex = 92
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 20, 0, 0)
    ToggleLabel.Size = UDim2.new(0, 300, 1, 0)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 16 -- Крупнее текст
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.ZIndex = 93
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -70, 0.5, -15)
    ToggleButton.Size = UDim2.new(0, 60, 0, 30) -- Больше переключатель
    ToggleButton.ZIndex = 93
    
    local ToggleBtnCorner = Instance.new("UICorner")
    ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
    ToggleBtnCorner.Parent = ToggleButton
    
    local ToggleDot = Instance.new("Frame")
    ToggleDot.Parent = ToggleButton
    ToggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleDot.BorderSizePixel = 0
    ToggleDot.Position = UDim2.new(0, 3, 0, 3)
    ToggleDot.Size = UDim2.new(0, 24, 0, 24) -- Больше точка
    ToggleDot.ZIndex = 94
    
    local ToggleDotCorner = Instance.new("UICorner")
    ToggleDotCorner.CornerRadius = UDim.new(1, 0)
    ToggleDotCorner.Parent = ToggleDot
    
    local enabled = false
    
    local function updateToggle()
        if enabled then
            SmoothTween(ToggleDot, {Position = UDim2.new(0, 33, 0, 3)}, 0.3)
            SmoothTween(ToggleButton, {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}, 0.3)
            SmoothTween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(30, 40, 35)}, 0.3)
        else
            SmoothTween(ToggleDot, {Position = UDim2.new(0, 3, 0, 3)}, 0.3)
            SmoothTween(ToggleButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.3)
            SmoothTween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}, 0.3)
        end
        if callback then callback(enabled) end
    end
    
    -- Анимация при наведении
    ToggleFrame.MouseEnter:Connect(function()
        if not enabled then
            SmoothTween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
        end
    end)
    
    ToggleFrame.MouseLeave:Connect(function()
        if not enabled then
            SmoothTween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}, 0.2)
        end
    end)
    
    ToggleFrame.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateToggle()
    end)
    
    return {
        Set = function(state)
            enabled = state
            updateToggle()
        end
    }
end

-- Добавляем функции с правильными отступами
CreateAnimatedToggle(CombatFrame, "Aimbot", function(state) print("Aimbot:", state) end)
CreateAnimatedToggle(CombatFrame, "Silent Aim", function(state) print("Silent Aim:", state) end)
CreateAnimatedToggle(CombatFrame, "Trigger Bot", function(state) print("Trigger Bot:", state) end)
CreateAnimatedToggle(CombatFrame, "Wallhack", function(state) print("Wallhack:", state) end)

CreateAnimatedToggle(VisualFrame, "ESP", function(state) print("ESP:", state) end)
CreateAnimatedToggle(VisualFrame, "Box ESP", function(state) print("Box ESP:", state) end)
CreateAnimatedToggle(VisualFrame, "Name ESP", function(state) print("Name ESP:", state) end)
CreateAnimatedToggle(VisualFrame, "Tracers", function(state) print("Tracers:", state) end)

CreateAnimatedToggle(MoveFrame, "Fly Hack", function(state) print("Fly:", state) end)
CreateAnimatedToggle(MoveFrame, "Noclip", function(state) print("Noclip:", state) end)
CreateAnimatedToggle(MoveFrame, "Speed Hack", function(state) print("Speed:", state) end)
CreateAnimatedToggle(MoveFrame, "Jump Hack", function(state) print("Jump:", state) end)

CreateAnimatedToggle(PoliceFrame, "Auto Arrest", function(state) print("Auto Arrest:", state) end)
CreateAnimatedToggle(PoliceFrame, "Long Arm", function(state) print("Long Arm:", state) end)
CreateAnimatedToggle(PoliceFrame, "Rapid Fire", function(state) print("Rapid Fire:", state) end)

-- Активируем первую вкладку
SwitchTab(CombatFrame, CombatTab)

print("ExpensiveMods Wide Menu loaded! Click the EM circle to open menu.")
