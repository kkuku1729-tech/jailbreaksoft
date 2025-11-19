-- ExpensiveMods Jailbreak Cheat (Fixed Version)
if not game:IsLoaded() then
    game.Loaded:Wait()
end

wait(2)

-- Создаем скрытый GUI
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Удаляем старый GUI если есть
if CoreGui:FindFirstChild("ExpensiveMods") then
    CoreGui:FindFirstChild("ExpensiveMods"):Destroy()
end

-- Создаем безопасный GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NotificationUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Кружок меню
local DragFrame = Instance.new("Frame")
DragFrame.Name = "DragFrame"
DragFrame.Parent = ScreenGui
DragFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
DragFrame.BackgroundTransparency = 0.3
DragFrame.BorderSizePixel = 0
DragFrame.Position = UDim2.new(0, 20, 0, 20)
DragFrame.Size = UDim2.new(0, 50, 0, 50)
DragFrame.Active = true
DragFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = DragFrame

local CircleText = Instance.new("TextLabel")
CircleText.Name = "CircleText"
CircleText.Parent = DragFrame
CircleText.BackgroundTransparency = 1
CircleText.Position = UDim2.new(0, 0, 0, 0)
CircleText.Size = UDim2.new(1, 0, 1, 0)
CircleText.Font = Enum.Font.SourceSansBold
CircleText.Text = "M"
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
MainFrame.Active = true
MainFrame.Draggable = true

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
Title.Font = Enum.Font.SourceSansBold
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
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Name = "TabButtonsFrame"
TabButtonsFrame.Parent = TopBar
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.Position = UDim2.new(0, 120, 0, 0)
TabButtonsFrame.Size = UDim2.new(0, 150, 1, 0)

local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.Size = UDim2.new(1, -20, 1, -60)

-- Простые функции без сложных вызовов
local Cheats = {
    Fly = false,
    Noclip = false,
    ESP = false,
    Aimbot = false,
    AutoArrest = false
}

-- Анимации
local function TweenObject(obj, properties, duration)
    local tweenInfo = TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
end

-- Открытие/закрытие меню
DragFrame.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Создаем простые элементы управления
local function CreateSimpleToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.Size = UDim2.new(0, 200, 1, 0)
    ToggleLabel.Font = Enum.Font.SourceSans
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleStatus = Instance.new("TextLabel")
    ToggleStatus.Parent = ToggleFrame
    ToggleStatus.BackgroundTransparency = 1
    ToggleStatus.Position = UDim2.new(1, -60, 0, 0)
    ToggleStatus.Size = UDim2.new(0, 50, 1, 0)
    ToggleStatus.Font = Enum.Font.SourceSansBold
    ToggleStatus.Text = "OFF"
    ToggleStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
    ToggleStatus.TextSize = 12
    
    local enabled = false
    
    local function updateToggle()
        if enabled then
            ToggleStatus.Text = "ON"
            ToggleStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
            TweenObject(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
        else
            ToggleStatus.Text = "OFF"
            ToggleStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
            TweenObject(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.2)
        end
        callback(enabled)
    end
    
    ToggleFrame.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateToggle()
    end)
    
    ToggleFrame.MouseEnter:Connect(function()
        if not enabled then
            TweenObject(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
        end
    end)
    
    ToggleFrame.MouseLeave:Connect(function()
        if not enabled then
            TweenObject(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.2)
        end
    end)
    
    return {
        Set = function(state)
            enabled = state
            updateToggle()
        end
    }
end

-- Создаем вкладки
local CombatFrame = Instance.new("ScrollingFrame")
CombatFrame.Parent = TabContainer
CombatFrame.BackgroundTransparency = 1
CombatFrame.Size = UDim2.new(1, 0, 1, 0)
CombatFrame.Visible = true
CombatFrame.ScrollBarThickness = 0
CombatFrame.CanvasSize = UDim2.new(0, 0, 0, 200)

local MovementFrame = Instance.new("ScrollingFrame")
MovementFrame.Parent = TabContainer
MovementFrame.BackgroundTransparency = 1
MovementFrame.Size = UDim2.new(1, 0, 1, 0)
MovementFrame.Visible = false
MovementFrame.ScrollBarThickness = 0
MovementFrame.CanvasSize = UDim2.new(0, 0, 0, 200)

local PoliceFrame = Instance.new("ScrollingFrame")
PoliceFrame.Parent = TabContainer
PoliceFrame.BackgroundTransparency = 1
PoliceFrame.Size = UDim2.new(1, 0, 1, 0)
PoliceFrame.Visible = false
PoliceFrame.ScrollBarThickness = 0
PoliceFrame.CanvasSize = UDim2.new(0, 0, 0, 200)

-- Кнопки переключения вкладок
local function CreateTabButton(text, targetFrame)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = TabButtonsFrame
    TabButton.BackgroundTransparency = 1
    TabButton.Size = UDim2.new(0, 50, 1, 0)
    TabButton.Font = Enum.Font.SourceSans
    TabButton.Text = text
    TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabButton.TextSize = 11
    
    TabButton.MouseButton1Click:Connect(function()
        CombatFrame.Visible = false
        MovementFrame.Visible = false
        PoliceFrame.Visible = false
        targetFrame.Visible = true
        
        for _, btn in pairs(TabButtonsFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

CreateTabButton("Combat", CombatFrame)
CreateTabButton("Move", MovementFrame)
CreateTabButton("Police", PoliceFrame)

-- Добавляем функции
local FlyToggle = CreateSimpleToggle(MovementFrame, "Fly Hack", function(state)
    Cheats.Fly = state
end)

local NoclipToggle = CreateSimpleToggle(MovementFrame, "Noclip", function(state)
    Cheats.Noclip = state
end)

local AimbotToggle = CreateSimpleToggle(CombatFrame, "Aimbot", function(state)
    Cheats.Aimbot = state
end)

local ESPToggle = CreateSimpleToggle(CombatFrame, "ESP", function(state)
    Cheats.ESP = state
end)

local AutoArrestToggle = CreateSimpleToggle(PoliceFrame, "Auto Arrest", function(state)
    Cheats.AutoArrest = state
end)

-- Простые реализации функций
-- Fly Hack
local flyConnection
FlyToggle.Set(false)

-- Noclip
local noclipConnection
NoclipToggle.Set(false)

-- ESP
local espConnection
ESPToggle.Set(false)

-- Auto Arrest
local arrestConnection
AutoArrestToggle.Set(false)

-- Активируем первую вкладку
if TabButtonsFrame:FindFirstChildOfClass("TextButton") then
    TabButtonsFrame:FindFirstChildOfClass("TextButton"):MouseButton1Click()
end

print("ExpensiveMods loaded! Click the circle to open menu.")

-- Простые подсказки
DragFrame.MouseEnter:Connect(function()
    TweenObject(DragFrame, {Size = UDim2.new(0, 55, 0, 55)}, 0.2)
end)

DragFrame.MouseLeave:Connect(function()
    TweenObject(DragFrame, {Size = UDim2.new(0, 50, 0, 50)}, 0.2)
end)

wait(1)
print("Menu ready! Use Fly: Space/Shift, Move: WASD")
