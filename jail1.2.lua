-- ExpensiveMods Jailbreak Cheat (FULL WORKING)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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
main.Size = UDim2.new(0, 350, 0, 450)
main.Position = UDim2.new(0.5, -175, 0.5, -225)
main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
main.Visible = false
main.Active = true
main.Draggable = true

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

-- Вкладки
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

local function createTab(name)
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
    tabFrame.ScrollBarThickness = 4
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = tabFrame
    layout.Padding = UDim.new(0, 8)
    
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
local combatTab = createTab("COMBAT")
local visualTab = createTab("VISUAL")
local miscTab = createTab("MISC")

-- Функция переключателя
local function createToggle(parent, text, callback)
    local toggle = Instance.new("Frame")
    toggle.Parent = parent
    toggle.Size = UDim2.new(1, 0, 0, 40)
    toggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    local label = Instance.new("TextLabel")
    label.Parent = toggle
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
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
    
    return {Set = function(s) state = s update() end, Get = function() return state end}
end

-- Функция слайдера
local function createSlider(parent, text, min, max, def, callback)
    local slider = Instance.new("Frame")
    slider.Parent = parent
    slider.Size = UDim2.new(1, 0, 0, 60)
    slider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = slider
    
    local label = Instance.new("TextLabel")
    label.Parent = slider
    label.Size = UDim2.new(1, -30, 0, 20)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text..": "..def
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local track = Instance.new("Frame")
    track.Parent = slider
    track.Size = UDim2.new(1, -30, 0, 6)
    track.Position = UDim2.new(0, 15, 0, 35)
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
    button.Size = UDim2.new(0, 12, 0, 16)
    button.Position = UDim2.new((def-min)/(max-min), -6, 0, -5)
    button.BackgroundColor3 = Color3.new(1, 1, 1)
    button.Text = ""
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = button
    
    local dragging = false
    
    local function update(value)
        local percent = math.clamp((value-min)/(max-min), 0, 1)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        button.Position = UDim2.new(percent, -6, 0, -5)
        label.Text = text..": "..math.floor(value)
        callback(value)
    end
    
    button.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    track.MouseButton1Down:Connect(function(x)
        local percent = (x - track.AbsolutePosition.X) / track.AbsoluteSize.X
        update(min + (max-min) * percent)
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local percent = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            update(min + (max-min) * math.clamp(percent, 0, 1))
        end
    end)
    
    return {Set = update}
end

-- Настройки
local Settings = {
    Aimbot = {Enabled = false, FOV = 80, Smoothing = 0.1},
    ESP = {Enabled = false, Box2D = false, Box3D = false, Names = true},
    Misc = {Fly = false, Noclip = false, FlySpeed = 50}
}

-- COMBAT вкладка
local aimbotToggle = createToggle(combatTab, "Aimbot", function(s) Settings.Aimbot.Enabled = s end)
local fovSlider = createSlider(combatTab, "Aimbot FOV", 10, 200, 80, function(v) Settings.Aimbot.FOV = v end)
local smoothSlider = createSlider(combatTab, "Smoothing", 0, 1, 0.1, function(v) Settings.Aimbot.Smoothing = v end)

-- VISUAL вкладка
local espToggle = createToggle(visualTab, "ESP", function(s) Settings.ESP.Enabled = s end)
local box2dToggle = createToggle(visualTab, "2D Boxes", function(s) Settings.ESP.Box2D = s end)
local box3dToggle = createToggle(visualTab, "3D Boxes", function(s) Settings.ESP.Box3D = s end)
local namesToggle = createToggle(visualTab, "Player Names", function(s) Settings.ESP.Names = s end)

-- MISC вкладка
local flyToggle = createToggle(miscTab, "Fly Hack", function(s) Settings.Misc.Fly = s end)
local noclipToggle = createToggle(miscTab, "Noclip", function(s) Settings.Misc.Noclip = s end)
local speedSlider = createSlider(miscTab, "Fly Speed", 10, 100, 50, function(v) Settings.Misc.FlySpeed = v end)

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

-- ESP СИСТЕМА
local ESPObjects = {}

local function updateESP()
    -- Очистка старых объектов
    for player, objects in pairs(ESPObjects) do
        if not player.Character then
            for _, obj in pairs(objects) do
                if obj then obj:Destroy() end
            end
            ESPObjects[player] = nil
        end
    end
    
    if not Settings.ESP.Enabled then return end
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local char = targetPlayer.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            local humanoid = char:FindFirstChild("Humanoid")
            
            if root and humanoid and humanoid.Health > 0 then
                if not ESPObjects[targetPlayer] then
                    ESPObjects[targetPlayer] = {}
                end
                
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
                
                if onScreen then
                    -- 2D Box
                    if Settings.ESP.Box2D then
                        if not ESPObjects[targetPlayer].Box2D then
                            local box = Instance.new("Frame")
                            box.Parent = screenGui
                            box.BackgroundTransparency = 1
                            box.BorderSizePixel = 2
                            box.BorderColor3 = Color3.new(0, 1, 0)
                            box.Size = UDim2.new(0, 100, 0, 150)
                            ESPObjects[targetPlayer].Box2D = box
                        end
                        ESPObjects[targetPlayer].Box2D.Visible = true
                        ESPObjects[targetPlayer].Box2D.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 75)
                    elseif ESPObjects[targetPlayer].Box2D then
                        ESPObjects[targetPlayer].Box2D.Visible = false
                    end
                    
                    -- 3D Box
                    if Settings.ESP.Box3D then
                        if not ESPObjects[targetPlayer].Box3D then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Adornee = root
                            box.AlwaysOnTop = true
                            box.ZIndex = 0
                            box.Size = Vector3.new(4, 6, 4)
                            box.Color3 = Color3.new(1, 0, 0)
                            box.Transparency = 0.5
                            box.Parent = root
                            ESPObjects[targetPlayer].Box3D = box
                        end
                        ESPObjects[targetPlayer].Box3D.Visible = true
                    elseif ESPObjects[targetPlayer].Box3D then
                        ESPObjects[targetPlayer].Box3D.Visible = false
                    end
                    
                    -- Names
                    if Settings.ESP.Names then
                        if not ESPObjects[targetPlayer].Name then
                            local nameTag = Instance.new("TextLabel")
                            nameTag.Parent = screenGui
                            nameTag.BackgroundTransparency = 1
                            nameTag.Text = targetPlayer.Name
                            nameTag.TextColor3 = Color3.new(1, 1, 1)
                            nameTag.TextSize = 14
                            nameTag.Font = Enum.Font.GothamBold
                            local distance = (root.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
                            local distanceTag = Instance.new("TextLabel")
                            distanceTag.Parent = screenGui
                            distanceTag.BackgroundTransparency = 1
                            distanceTag.Text = math.floor(distance) .. " studs"
                            distanceTag.TextColor3 = Color3.new(1, 1, 1)
                            distanceTag.TextSize = 12
                            distanceTag.Font = Enum.Font.Gotham
                            
                            ESPObjects[targetPlayer].Name = nameTag
                            ESPObjects[targetPlayer].Distance = distanceTag
                        end
                        
                        ESPObjects[targetPlayer].Name.Visible = true
                        ESPObjects[targetPlayer].Name.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 90)
                        
                        ESPObjects[targetPlayer].Distance.Visible = true
                        ESPObjects[targetPlayer].Distance.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 105)
                    elseif ESPObjects[targetPlayer].Name then
                        ESPObjects[targetPlayer].Name.Visible = false
                        if ESPObjects[targetPlayer].Distance then
                            ESPObjects[targetPlayer].Distance.Visible = false
                        end
                    end
                else
                    -- Скрываем если не на экране
                    for _, obj in pairs(ESPObjects[targetPlayer]) do
                        if obj and obj:IsA("GuiObject") then
                            obj.Visible = false
                        end
                    end
                end
            end
        end
    end
end

-- AIMBOT СИСТЕМА
local function aimbotUpdate()
    if not Settings.Aimbot.Enabled or not player.Character then return end
    
    local localRoot = player.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
    local closestPlayer = nil
    local closestDistance = Settings.Aimbot.FOV
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local char = targetPlayer.Character
            local humanoid = char:FindFirstChild("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and root and head then
                -- Проверка FOV
                local screenPos = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                local center = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
                local fovDistance = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                
                if fovDistance < closestDistance then
                    closestPlayer = targetPlayer
                    closestDistance = fovDistance
                end
            end
        end
    end
    
    if closestPlayer then
        local targetHead = closestPlayer.Character:FindFirstChild("Head")
        if targetHead then
            local camera = workspace.CurrentCamera
            local targetPosition = targetHead.Position
            local currentPosition = camera.CFrame.Position
            local direction = (targetPosition - currentPosition).Unit
            
            local currentCFrame = camera.CFrame
            local targetCFrame = CFrame.new(currentPosition, currentPosition + direction)
            local smoothedCFrame = currentCFrame:Lerp(targetCFrame, Settings.Aimbot.Smoothing)
            
            camera.CFrame = smoothedCFrame
        end
    end
end

-- FOV Circle
local fovCircle = Instance.new("Frame")
fovCircle.Parent = screenGui
fovCircle.BackgroundColor3 = Color3.new(1, 1, 1)
fovCircle.BackgroundTransparency = 0.7
fovCircle.BorderSizePixel = 0
fovCircle.Size = UDim2.new(0, Settings.Aimbot.FOV * 2, 0, Settings.Aimbot.FOV * 2)
fovCircle.Position = UDim2.new(0.5, -Settings.Aimbot.FOV, 0.5, -Settings.Aimbot.FOV)
fovCircle.Visible = Settings.Aimbot.Enabled

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

-- Fly Hack
local function flyUpdate()
    if Settings.Misc.Fly and player.Character then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local fly = root:FindFirstChild("FlyVelocity") or Instance.new("BodyVelocity")
            fly.Name = "FlyVelocity"
            fly.Parent = root
            fly.MaxForce = Vector3.new(40000, 40000, 40000)
            
            local move = Vector3.new(0, 0, 0)
            local cam = workspace.CurrentCamera
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
            
            fly.Velocity = move * Settings.Misc.FlySpeed
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

-- Noclip
local function noclipUpdate()
    if Settings.Misc.Noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- Запускаем все системы
RunService.Heartbeat:Connect(function()
    updateESP()
    aimbotUpdate()
    flyUpdate()
    
    -- Обновляем FOV circle
    fovCircle.Visible = Settings.Aimbot.Enabled
    fovCircle.Size = UDim2.new(0, Settings.Aimbot.FOV * 2, 0, Settings.Aimbot.FOV * 2)
    fovCircle.Position = UDim2.new(0.5, -Settings.Aimbot.FOV, 0.5, -Settings.Aimbot.FOV)
end)

RunService.Stepped:Connect(noclipUpdate)

print("ExpensiveMods FULLY LOADED! Features: ESP, Aimbot, Fly, Noclip")
