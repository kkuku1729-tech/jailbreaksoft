-- ExpensiveMods Jailbreak Cheat (ULTRA SIMPLE)
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
main.Parent = screenGui
main.Size = UDim2.new(0, 300, 0, 400)
main.Position = UDim2.new(0.5, -150, 0.5, -200)
main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
main.Visible = false

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = main

-- Заголовок
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
title.Text = "EXPENSIVEMODS"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

-- Кнопка закрытия
local close = Instance.new("TextButton")
close.Parent = title
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0.5, -12)
close.BackgroundColor3 = Color3.new(1, 0.3, 0.3)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = close

-- Контент
local content = Instance.new("ScrollingFrame")
content.Parent = main
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 4
content.CanvasSize = UDim2.new(0, 0, 0, 600)

local layout = Instance.new("UIListLayout")
layout.Parent = content
layout.Padding = UDim.new(0, 5)

-- Настройки
local ESP = {Enabled = false, Box2D = false}
local Aimbot = {Enabled = false, FOV = 50}
local Police = {AutoArrest = false}
local Movement = {Fly = false, Noclip = false, FlySpeed = 50}

-- Функция переключателя
local function makeToggle(text, callback)
    local toggle = Instance.new("TextButton")
    toggle.Parent = content
    toggle.Size = UDim2.new(1, 0, 0, 40)
    toggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    toggle.Text = ""
    
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
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local status = Instance.new("TextLabel")
    status.Parent = toggle
    status.Size = UDim2.new(0, 40, 1, 0)
    status.Position = UDim2.new(1, -50, 0, 0)
    status.BackgroundTransparency = 1
    status.Text = "OFF"
    status.TextColor3 = Color3.new(1, 0.3, 0.3)
    status.Font = Enum.Font.GothamBold
    status.TextSize = 12
    
    local state = false
    
    local function update()
        if state then
            status.Text = "ON"
            status.TextColor3 = Color3.new(0.3, 1, 0.3)
            toggle.BackgroundColor3 = Color3.new(0.3, 0.3, 0.4)
        else
            status.Text = "OFF"
            status.TextColor3 = Color3.new(1, 0.3, 0.3)
            toggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        end
        if callback then callback(state) end
    end
    
    toggle.MouseButton1Click:Connect(function()
        state = not state
        update()
    end)
    
    return {Set = function(s) state = s update() end}
end

-- Создаем переключатели
local aimbotToggle = makeToggle("Aimbot", function(s) Aimbot.Enabled = s end)
local espToggle = makeToggle("ESP", function(s) ESP.Enabled = s end)
local flyToggle = makeToggle("Fly Hack", function(s) Movement.Fly = s end)
local noclipToggle = makeToggle("Noclip", function(s) Movement.Noclip = s end)
local arrestToggle = makeToggle("Auto Arrest", function(s) Police.AutoArrest = s end)

-- УПРАВЛЕНИЕ МЕНЮ
circle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    print("Menu:", main.Visible)
end)

close.MouseButton1Click:Connect(function()
    main.Visible = false
end)

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
