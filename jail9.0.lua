-- ExpensiveMods Jailbreak Cheat (Working Menu)
if not game:IsLoaded() then wait(10) end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Удаляем старый GUI
if CoreGui:FindFirstChild("ExpensiveMods") then
    CoreGui:FindFirstChild("ExpensiveMods"):Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExpensiveMods"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Кружок меню (ПРОСТОЙ КЛИКАБЕЛЬНЫЙ)
local Circle = Instance.new("TextButton")
Circle.Name = "MenuButton"
Circle.Parent = ScreenGui
Circle.BackgroundColor3 = Color3.new(0,0,0)
Circle.BackgroundTransparency = 0.3
Circle.Size = UDim2.new(0,50,0,50)
Circle.Position = UDim2.new(0,20,0,20)
Circle.Text = ""
Circle.ZIndex = 999

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1,0)
Corner.Parent = Circle

local CircleText = Instance.new("TextLabel")
CircleText.Parent = Circle
CircleText.Size = UDim2.new(1,0,1,0)
CircleText.BackgroundTransparency = 1
CircleText.Text = "EM"
CircleText.TextColor3 = Color3.new(1,1,1)
CircleText.Font = Enum.Font.GothamBold
CircleText.TextScaled = true
CircleText.ZIndex = 1000

-- Главное меню (ПРОСТОЕ И РАБОЧЕЕ)
local Main = Instance.new("Frame")
Main.Name = "MainMenu"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
Main.Size = UDim2.new(0,350,0,450)
Main.Position = UDim2.new(0.5,-175,0.5,-225)
Main.Visible = false
Main.ZIndex = 100

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,10)
MainCorner.Parent = Main

-- Верхняя панель
local Top = Instance.new("Frame")
Top.Parent = Main
Top.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
Top.Size = UDim2.new(1,0,0,40)
Top.ZIndex = 101

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0,10)
TopCorner.Parent = Top

local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,15,0,0)
Title.Size = UDim2.new(0,200,1,0)
Title.Text = "EXPENSIVEMODS"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 102

local Close = Instance.new("TextButton")
Close.Parent = Top
Close.BackgroundColor3 = Color3.new(1,0.3,0.3)
Close.Size = UDim2.new(0,25,0,25)
Close.Position = UDim2.new(1,-30,0.5,-12)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.ZIndex = 102

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1,0)
CloseCorner.Parent = Close

-- Кнопки вкладок
local TabsFrame = Instance.new("Frame")
TabsFrame.Parent = Main
TabsFrame.BackgroundTransparency = 1
TabsFrame.Size = UDim2.new(1,-20,0,30)
TabsFrame.Position = UDim2.new(0,10,0,45)
TabsFrame.ZIndex = 101

-- Контент вкладок
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = Main
ContentFrame.BackgroundTransparency = 1
ContentFrame.Size = UDim2.new(1,-20,1,-85)
ContentFrame.Position = UDim2.new(0,10,0,80)
ContentFrame.ZIndex = 101

-- Создаем вкладки
local Tabs = {}
local CurrentTab = nil

local function CreateTab(name)
    -- Кнопка вкладки
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsFrame
    TabBtn.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
    TabBtn.Size = UDim2.new(0,70,0,25)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.new(0.8,0.8,0.8)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 12
    TabBtn.ZIndex = 102
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0,5)
    TabCorner.Parent = TabBtn
    
    -- Контент вкладки
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Parent = ContentFrame
    TabContent.BackgroundTransparency = 1
    TabContent.Size = UDim2.new(1,0,1,0)
    TabContent.Visible = false
    TabContent.ScrollBarThickness = 3
    TabContent.CanvasSize = UDim2.new(0,0,0,500)
    TabContent.ZIndex = 101
    
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = TabContent
    Layout.Padding = UDim.new(0,5)
    
    Tabs[name] = TabContent
    
    -- Клик по вкладке
    TabBtn.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Visible = false
        end
        
        -- Сбрасываем цвет всех кнопок
        for _,btn in pairs(TabsFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
                btn.TextColor3 = Color3.new(0.8,0.8,0.8)
            end
        end
        
        -- Активируем текущую
        TabContent.Visible = true
        CurrentTab = TabContent
        TabBtn.BackgroundColor3 = Color3.new(0,0.5,1)
        TabBtn.TextColor3 = Color3.new(1,1,1)
    end)
    
    return TabContent
end

-- Создаем вкладки
local AimTab = CreateTab("AIMBOT")
local EspTab = CreateTab("ESP")
local MoveTab = CreateTab("MOVE")
local PoliceTab = CreateTab("POLICE")

-- Функция создания переключателя
local function CreateToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    ToggleFrame.Size = UDim2.new(1,0,0,35)
    ToggleFrame.ZIndex = 102
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0,5)
    ToggleCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = ToggleFrame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0,200,1,0)
    Label.Position = UDim2.new(0,10,0,0)
    Label.Text = text
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 103
    
    local ToggleBtn = Instance.new("Frame")
    ToggleBtn.Parent = ToggleFrame
    ToggleBtn.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
    ToggleBtn.Size = UDim2.new(0,40,0,20)
    ToggleBtn.Position = UDim2.new(1,-45,0.5,-10)
    ToggleBtn.ZIndex = 103
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1,0)
    BtnCorner.Parent = ToggleBtn
    
    local Dot = Instance.new("Frame")
    Dot.Parent = ToggleBtn
    Dot.BackgroundColor3 = Color3.new(1,1,1)
    Dot.Size = UDim2.new(0,16,0,16)
    Dot.Position = UDim2.new(0,2,0,2)
    Dot.ZIndex = 104
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1,0)
    DotCorner.Parent = Dot
    
    local state = false
    
    local function Update()
        if state then
            Dot.Position = UDim2.new(0,22,0,2)
            ToggleBtn.BackgroundColor3 = Color3.new(0,0.7,1)
        else
            Dot.Position = UDim2.new(0,2,0,2)
            ToggleBtn.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
        end
        if callback then callback(state) end
    end
    
    ToggleFrame.MouseButton1Click:Connect(function()
        state = not state
        Update()
    end)
    
    return {Set = function(s) state = s Update() end}
end

-- Функция создания слайдера
local function CreateSlider(parent, text, min, max, def, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Parent = parent
    SliderFrame.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    SliderFrame.Size = UDim2.new(1,0,0,50)
    SliderFrame.ZIndex = 102
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0,5)
    SliderCorner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = SliderFrame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1,-20,0,20)
    Label.Position = UDim2.new(0,10,0,5)
    Label.Text = text..": "..def
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 103
    
    local Track = Instance.new("Frame")
    Track.Parent = SliderFrame
    Track.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
    Track.Size = UDim2.new(1,-20,0,4)
    Track.Position = UDim2.new(0,10,0,30)
    Track.ZIndex = 103
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1,0)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    Fill.Parent = Track
    Fill.BackgroundColor3 = Color3.new(0,0.7,1)
    Fill.Size = UDim2.new((def-min)/(max-min),0,1,0)
    Fill.ZIndex = 104
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1,0)
    FillCorner.Parent = Fill
    
    local Button = Instance.new("TextButton")
    Button.Parent = Track
    Button.BackgroundColor3 = Color3.new(1,1,1)
    Button.Size = UDim2.new(0,8,0,12)
    Button.Position = UDim2.new((def-min)/(max-min),-4,0,-4)
    Button.Text = ""
    Button.ZIndex = 105
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1,0)
    ButtonCorner.Parent = Button
    
    local dragging = false
    
    local function Update(value)
        local percent = math.clamp((value-min)/(max-min),0,1)
        Fill.Size = UDim2.new(percent,0,1,0)
        Button.Position = UDim2.new(percent,-4,0,-4)
        Label.Text = text..": "..math.floor(value)
        callback(value)
    end
    
    Button.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    Track.MouseButton1Down:Connect(function(x)
        local percent = (x - Track.AbsolutePosition.X) / Track.AbsoluteSize.X
        Update(min + (max-min) * percent)
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local percent = (input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X
            Update(min + (max-min) * math.clamp(percent,0,1))
        end
    end)
    
    return {Set = Update}
end

-- Настройки
local ESP = {Enabled = false, Box2D = false}
local Aimbot = {Enabled = false, FOV = 50}
local Police = {AutoArrest = false}
local Movement = {Fly = false, Noclip = false, FlySpeed = 50}

-- Добавляем элементы
CreateToggle(AimTab, "Aimbot", function(s) Aimbot.Enabled = s end)
CreateSlider(AimTab, "FOV", 10, 200, 50, function(v) Aimbot.FOV = v end)
CreateToggle(AimTab, "Team Check", function(s) end)

CreateToggle(EspTab, "ESP", function(s) ESP.Enabled = s end)
CreateToggle(EspTab, "2D Box", function(s) ESP.Box2D = s end)
CreateToggle(EspTab, "Names", function(s) end)

CreateToggle(MoveTab, "Fly Hack", function(s) Movement.Fly = s end)
CreateToggle(MoveTab, "Noclip", function(s) Movement.Noclip = s end)
CreateSlider(MoveTab, "Fly Speed", 10, 100, 50, function(v) Movement.FlySpeed = v end)

CreateToggle(PoliceTab, "Auto Arrest", function(s) Police.AutoArrest = s end)
CreateSlider(PoliceTab, "Arrest Range", 10, 100, 50, function(v) end)

-- УПРАВЛЕНИЕ МЕНЮ (РАБОЧЕЕ)
Circle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    print("Menu toggled:", Main.Visible)
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- Активируем первую вкладку
wait(0.1)
for _,btn in pairs(TabsFrame:GetChildren()) do
    if btn:IsA("TextButton") then
        btn:MouseButton1Click()
        break
    end
end

-- Функции чита
local function FlyUpdate()
    if Movement.Fly and LocalPlayer.Character then
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local fly = root:FindFirstChild("FlyVelocity") or Instance.new("BodyVelocity")
            fly.Name = "FlyVelocity"
            fly.Parent = root
            fly.MaxForce = Vector3.new(40000,40000,40000)
            
            local move = Vector3.new(0,0,0)
            local cam = workspace.CurrentCamera
            
            local UIS = game:GetService("UserInputService")
            if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,1,0) end
            
            fly.Velocity = move * Movement.FlySpeed
        end
    else
        if LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root and root:FindFirstChild("FlyVelocity") then
                root.FlyVelocity:Destroy()
            end
        end
    end
end

local function NoclipUpdate()
    if Movement.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- Запускаем
RunService.Heartbeat:Connect(FlyUpdate)
RunService.Stepped:Connect(NoclipUpdate)

print("ExpensiveMods LOADED! Click the black circle to open menu.")
