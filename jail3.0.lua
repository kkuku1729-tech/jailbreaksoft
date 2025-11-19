-- ExpensiveMods Jailbreak Cheat (Fixed Animations)
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
if CoreGui:FindFirstChild("ExpensiveModsV2") then
    CoreGui:FindFirstChild("ExpensiveModsV2"):Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExpensiveModsV2"
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

local CircleShadow = Instance.new("ImageLabel")
CircleShadow.Name = "CircleShadow"
CircleShadow.Parent = CircleButton
CircleShadow.BackgroundTransparency = 1
CircleShadow.Position = UDim2.new(0, 0, 0, 0)
CircleShadow.Size = UDim2.new(1, 0, 1, 0)
CircleShadow.Image = "rbxassetid://5554236805"
CircleShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
CircleShadow.ScaleType = Enum.ScaleType.Slice
CircleShadow.SliceCenter = Rect.new(23,23,277,277)
CircleShadow.ZIndex = 99

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
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Visible = false
MainFrame.ZIndex = 90

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainShadow = Instance.new("ImageLabel")
MainShadow.Name = "MainShadow"
MainShadow.Parent = MainFrame
MainShadow.BackgroundTransparency = 1
MainShadow.Position = UDim2.new(0, 0, 0, 0)
MainShadow.Size = UDim2.new(1, 0, 1, 0)
MainShadow.Image = "rbxassetid://5554236805"
MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(23,23,277,277)
MainShadow.ZIndex = 89

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

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBlack
Title.Text = "EXPENSIVEMODS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 92

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

-- Контейнер вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 15, 0, 60)
TabContainer.Size = UDim2.new(1, -30, 1, -75)
TabContainer.ZIndex = 91

-- Кнопки вкладок
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Parent = TopBar
TabButtons.BackgroundTransparency = 1
TabButtons.Position = UDim2.new(0, 180, 0, 0)
TabButtons.Size = UDim2.new(0, 160, 1, 0)
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
        Size = UDim2.new(0, 350, 0, 500),
        Position = UDim2.new(0.5, -175, 0.5, -250)
    }, 0.5, Enum.EasingStyle.Back)
    
    -- Анимация элементов
    wait(0.2)
    for _, child in pairs(MainFrame:GetDescendants()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
            if child ~= MainFrame and child ~= TopBar and child ~= TabContainer then
                child.BackgroundTransparency = 1
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    child.TextTransparency = 1
                end
            end
        end
    end
    
    wait(0.1)
    for _, child in pairs(MainFrame:GetDescendants()) do
        if child:IsA("Frame") and child ~= MainFrame then
            SmoothTween(child, {BackgroundTransparency = 0}, 0.3)
        elseif child:IsA("TextLabel") or child:IsA("TextButton") then
            SmoothTween(child, {TextTransparency = 0}, 0.3)
        end
    end
end

-- Анимация закрытия меню
local function CloseMenu()
    -- Исчезновение элементов
    for _, child in pairs(MainFrame:GetDescendants()) do
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
        Size = UDim2.new(0, 32, 0, 32)
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
    TabButton.Parent = TabButtons
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(0, 50, 0, 30)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 12
    TabButton.ZIndex = 93
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabButton
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = name .. "Frame"
    TabFrame.Parent = TabContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = false
    TabFrame.ScrollBarThickness = 0
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    TabFrame.ZIndex = 91
    
    -- Анимация кнопки вкладки
    TabButton.MouseEnter:Connect(function()
        if TabButton.TextColor3 ~= Color3.fromRGB(0, 170, 255) then
            SmoothTween(TabButton, {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }, 0.2)
        end
    end)
    
    TabButton.MouseLeave:Connect(function()
        if TabButton.TextColor3 ~= Color3.fromRGB(0, 170, 255) then
            SmoothTween(TabButton, {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                TextColor3 = Color3.fromRGB(200, 200, 200)
            }, 0.2)
        end
    end)
    
    return TabButton, TabFrame
end

-- Создаем вкладки
local CombatTab, CombatFrame = CreateTab("Combat")
local VisualTab, VisualFrame = CreateTab("Visual")
local MoveTab, MoveFrame = CreateTab("Move")
local PoliceTab, PoliceFrame = CreateTab("Police")

-- Активация вкладок
local currentTab = CombatFrame
CombatFrame.Visible = true

CombatTab.MouseButton1Click:Connect(function()
    currentTab.Visible = false
    CombatFrame.Visible = true
    currentTab = CombatFrame
    
    -- Сброс цвета всех кнопок
    for _, btn in pairs(TabButtons:GetChildren()) do
        if btn:IsA("TextButton") then
            SmoothTween(btn, {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                TextColor3 = Color3.fromRGB(200, 200, 200)
            }, 0.2)
        end
    end
    
    -- Подсветка активной вкладки
    SmoothTween(CombatTab, {
        BackgroundColor3 = Color3.fromRGB(0, 100, 255),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }, 0.2)
end)

-- Аналогично для других вкладок...
VisualTab.MouseButton1Click:Connect(function()
    currentTab.Visible = false
    VisualFrame.Visible = true
    currentTab = VisualFrame
    
    for _, btn in pairs(TabButtons:GetChildren()) do
        if btn:IsA("TextButton") then
            SmoothTween(btn, {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                TextColor3 = Color3.fromRGB(200, 200, 200)
            }, 0.2)
        end
    end
    
    SmoothTween(VisualTab, {
        BackgroundColor3 = Color3.fromRGB(0, 100, 255),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }, 0.2)
end)

-- Создание переключателей с анимациями
local function CreateAnimatedToggle(parent, text, callback)
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
    ToggleLabel.Size = UDim2.new(0, 200, 1, 0)
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
            SmoothTween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(30, 35, 40)}, 0.2)
        else
            SmoothTween(ToggleDot, {Position = UDim2.new(0, 2, 0, 2)}, 0.2)
            SmoothTween(ToggleButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
            SmoothTween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}, 0.2)
        end
        callback(enabled)
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

-- Добавляем функции
CreateAnimatedToggle(CombatFrame, "Aimbot", function(state) end)
CreateAnimatedToggle(CombatFrame, "ESP", function(state) end)
CreateAnimatedToggle(MoveFrame, "Fly Hack", function(state) end)
CreateAnimatedToggle(MoveFrame, "Noclip", function(state) end)
CreateAnimatedToggle(PoliceFrame, "Auto Arrest", function(state) end)

-- Располагаем кнопки вкладок
CombatTab.Position = UDim2.new(0, 0, 0.5, -15)
VisualTab.Position = UDim2.new(0, 55, 0.5, -15)
MoveTab.Position = UDim2.new(0, 110, 0.5, -15)

-- Активируем первую вкладку
CombatTab:MouseButton1Click()

print("ExpensiveMods loaded! Click the EM circle to open menu.")
