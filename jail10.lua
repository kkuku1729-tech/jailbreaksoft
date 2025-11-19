-- ExpensiveMods Jailbreak Cheat (FIXED MENU)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Удаляем старый GUI
if CoreGui:FindFirstChild("ExpensiveMods") then
    CoreGui:FindFirstChild("ExpensiveMods"):Destroy()
end

-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExpensiveMods"
screenGui.Parent = CoreGui

-- Кружок меню
local circle = Instance.new("TextButton")
circle.Name = "MenuBtn"
circle.Parent = screenGui
circle.Size = UDim2.new(0, 50, 0, 50)
circle.Position = UDim2.new(0, 20, 0, 20)
circle.BackgroundColor3 = Color3.new(0, 0, 0)
circle.Text = ""
circle.BackgroundTransparency = 0.3

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = circle

local text = Instance.new("TextLabel")
text.Parent = circle
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "EM"
text.TextColor3 = Color3.new(1, 1, 1)
text.Font = Enum.Font.GothamBold
text.TextScaled = true

-- Главное меню
local main = Instance.new("Frame")
main.Name = "MainMenu"
main.Parent = screenGui
main.Size = UDim2.new(0, 350, 0, 400)
main.Position = UDim2.new(0.5, -175, 0.5, -200)
main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
main.Visible = false

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = main

-- Верхняя панель
local top = Instance.new("Frame")
top.Parent = main
top.Size = UDim2.new(1, 0, 0, 40)
top.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = top

local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "EXPENSIVEMODS"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0.5, -12)
close.BackgroundColor3 = Color3.new(1, 0.3, 0.3)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = close

-- Контейнер вкладок
local tabs = Instance.new("Frame")
tabs.Parent = main
tabs.Size = UDim2.new(1, -20, 0, 30)
tabs.Position = UDim2.new(0, 10, 0, 45)
tabs.BackgroundTransparency = 1

-- Контент
local content = Instance.new("Frame")
content.Parent = main
content.Size = UDim2.new(1, -20, 1, -85)
content.Position = UDim2.new(0, 10, 0, 80)
content.BackgroundTransparency = 1

-- Создаем вкладки
local tabContents = {}
local currentTab = nil

local function makeTab(name)
    -- Кнопка вкладки
    local btn = Instance.new("TextButton")
    btn.Parent = tabs
    btn.Size = UDim2.new(0, 70, 0, 25)
    btn.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    btn.Text = name
    btn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn
    
    -- Контент вкладки
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Parent = content
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.ScrollBarThickness = 3
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = tabFrame
    layout.Padding = UDim.new(0, 5)
    
    tabContents[name] = tabFrame
    
    -- Клик по вкладке
    btn.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.Visible = false
        end
        
        -- Сбрасываем цвет
        for _,b in pairs(tabs:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
                b.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            end
        end
        
        -- Активируем
        tabFrame.Visible = true
        currentTab = tabFrame
        btn.BackgroundColor3 = Color3.new(0, 0.5, 1)
        btn.TextColor3 = Color3.new(1, 1, 1)
    end)
    
    return tabFrame
end

-- Создаем вкладки
local aimTab = makeTab("AIMBOT")
local espTab = makeTab("ESP")
local moveTab = makeTab("MOVE")
local policeTab = makeTab("POLICE")

-- Функция переключателя
local function makeToggle(parent, text, callback)
    local toggle = Instance.new("Frame")
    toggle.Parent = parent
    toggle.Size = UDim2.new(1, 0, 0, 35)
    toggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 5)
    toggleCorner.Parent = toggle
    
    local label = Instance.new("TextLabel")
    label.Parent = toggle
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("Frame")
    btn.Parent = toggle
    btn.Size = UDim2.new(0, 40, 0, 20)
    btn.Position = UDim2.new(1, -45, 0.5, -10)
    btn.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = btn
    
    local dot = Instance.new("Frame")
    dot.Parent = btn
    dot.Size = UDim2.new(0, 16, 0, 16)
    dot.Position = UDim2.new(0, 2, 0, 2)
    dot.BackgroundColor3 = Color3.new(1, 1, 1)
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    
    local state = false
    
    local function update()
        if state then
            dot.Position = UDim2.new(0, 22, 0, 2)
            btn.BackgroundColor3 = Color3.new(0, 0.7, 1)
        else
            dot.Position = UDim2.new(0, 2, 0, 2)
            btn.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
        end
        if callback then callback(state) end
    end
    
    toggle.MouseButton1Click:Connect(function()
        state = not state
        update()
    end)
end

-- Функция слайдера
local function makeSlider(parent, text, min, max, def, callback)
    local slider = Instance.new("Frame")
    slider.Parent = parent
    slider.Size = UDim2.new(1, 0, 0, 50)
    slider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 5)
    sliderCorner.Parent = slider
    
    local label = Instance.new("TextLabel")
    label.Parent = slider
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text..": "..def
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local track = Instance.new("Frame")
    track.Parent = slider
    track.Size = UDim2.new(1, -20, 0, 4)
    track.Position = UDim2.new(0, 10, 0, 30)
    track.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Parent = track
    fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.new(0, 0.7, 1)
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local button = Instance.new("TextButton")
    button.Parent = track
    button.Size = UDim2.new(0, 8, 0, 12)
    button.Position = UDim2.new((def-min)/(max-min), -4, 0, -4)
    button.BackgroundColor3 = Color3.new(1, 1, 1)
    button.Text = ""
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = button
    
    local dragging = false
    
    local function update(value)
        local percent = math.clamp((value-min)/(max-min), 0, 1)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        button.Position = UDim2.new(percent, -4, 0, -4)
        label.Text = text..": "..math.floor(value)
        callback(value)
    end
    
    button.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    track.MouseButton1Down:Connect(function(x)
        local percent = (x - track.AbsolutePosition.X) / track.AbsoluteSize.X
        update(min + (max-min) * percent)
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local percent = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            update(min + (max-min) * math.clamp(percent, 0, 1))
        end
    end)
end

-- Настройки
local ESP = {Enabled = false, Box2D = false}
local Aimbot = {Enabled = false, FOV = 50}
local Police = {AutoArrest = false}
local Movement = {Fly = false, Noclip = false, FlySpeed = 50}

-- Добавляем элементы
makeToggle(aimTab, "Aimbot", function(s) Aimbot.Enabled = s end)
makeSlider(aimTab, "FOV", 10, 200, 50, function(v) Aimbot.FOV = v end)
makeToggle(aimTab, "Team Check", function(s) end)

makeToggle(espTab, "ESP", function(s) ESP.Enabled = s end)
makeToggle(espTab, "2D Box", function(s) ESP.Box2D = s end)
makeToggle(espTab, "Names", function(s) end)

makeToggle(moveTab, "Fly Hack", function(s) Movement.Fly = s end)
makeToggle(moveTab, "Noclip", function(s) Movement.Noclip = s end)
makeSlider(moveTab, "Fly Speed", 10, 100, 50, function(v) Movement.FlySpeed = v end)

makeToggle(policeTab, "Auto Arrest", function(s) Police.AutoArrest = s end)
makeSlider(policeTab, "Arrest Range", 10, 100, 50, function(v) end)

-- УПРАВЛЕНИЕ МЕНЮ
circle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

close.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Активируем первую вкладку
wait(0.1)
for _,btn in pairs(tabs:GetChildren()) do
    if btn:IsA("TextButton") then
        btn:MouseButton1Click()
        break
    end
end

-- Функции чита
local function flyUpdate()
    if Movement.Fly and player.Character then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
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
        if player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root and root:FindFirstChild("FlyVelocity") then
                root.FlyVelocity:Destroy()
            end
        end
    end
end

local function noclipUpdate()
    if Movement.Noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- Запускаем
RunService.Heartbeat:Connect(flyUpdate)
RunService.Stepped:Connect(noclipUpdate)

print("ExpensiveMods LOADED! Click the black circle to open menu.")
