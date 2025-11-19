-- ExpensiveMods Jailbreak Cheat (Fixed Menu)
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

-- Кружок меню
local Circle = Instance.new("TextButton")
Circle.Parent = ScreenGui
Circle.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
Circle.Size = UDim2.new(0,60,0,60)
Circle.Position = UDim2.new(0,30,0,30)
Circle.Text = ""
Circle.ZIndex = 100
Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

local CircleText = Instance.new("TextLabel")
CircleText.Parent = Circle
CircleText.Size = UDim2.new(1,0,1,0)
CircleText.BackgroundTransparency = 1
CircleText.Text = "EM"
CircleText.TextColor3 = Color3.new(1,1,1)
CircleText.Font = Enum.Font.GothamBlack
CircleText.TextScaled = true
CircleText.ZIndex = 101

-- Главное меню
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
Main.Size = UDim2.new(0,400,0,500)
Main.Position = UDim2.new(0.5,-200,0.5,-250)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.ZIndex = 90
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

-- Верхняя панель
local Top = Instance.new("Frame")
Top.Parent = Main
Top.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
Top.Size = UDim2.new(1,0,0,50)
Top.ZIndex = 91
Instance.new("UICorner", Top).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,20,0,5)
Title.Size = UDim2.new(0,200,0,25)
Title.Text = "EXPENSIVEMODS"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 92

local Close = Instance.new("TextButton")
Close.Parent = Top
Close.BackgroundColor3 = Color3.new(1,0,0)
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-40,0.5,-15)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Close.ZIndex = 92
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

-- Контейнеры
local TabsContainer = Instance.new("Frame")
TabsContainer.Parent = Main
TabsContainer.BackgroundTransparency = 1
TabsContainer.Size = UDim2.new(1,-40,0,40)
TabsContainer.Position = UDim2.new(0,20,0,60)
TabsContainer.ZIndex = 91

local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = Main
ContentContainer.BackgroundTransparency = 1
ContentContainer.Size = UDim2.new(1,-40,1,-130)
ContentContainer.Position = UDim2.new(0,20,0,110)
ContentContainer.ZIndex = 91

-- Создаем вкладки
local Tabs = {}
local CurrentTab = nil

local function CreateTab(name)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsContainer
    TabBtn.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    TabBtn.Size = UDim2.new(0,80,0,35)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.new(0.8,0.8,0.8)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 13
    TabBtn.ZIndex = 92
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0,8)
    
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Parent = ContentContainer
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1,0,1,0)
    TabFrame.Visible = false
    TabFrame.ScrollBarThickness = 4
    TabFrame.CanvasSize = UDim2.new(0,0,0,600)
    TabFrame.ZIndex = 91
    
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = TabFrame
    Layout.Padding = UDim.new(0,8)
    
    Tabs[name] = TabFrame
    
    TabBtn.MouseButton1Click:Connect(function()
        if CurrentTab then CurrentTab.Visible = false end
        TabFrame.Visible = true
        CurrentTab = TabFrame
        
        for _,btn in pairs(TabsContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
                btn.TextColor3 = Color3.new(0.8,0.8,0.8)
            end
        end
        TabBtn.BackgroundColor3 = Color3.new(0,0.4,1)
        TabBtn.TextColor3 = Color3.new(1,1,1)
    end)
    
    return TabFrame
end

-- Создаем вкладки
local AimTab = CreateTab("AIMBOT")
local EspTab = CreateTab("ESP")
local MoveTab = CreateTab("MOVE")
local PoliceTab = CreateTab("POLICE")

-- Функции для элементов UI
local function CreateToggle(parent, text, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Parent = parent
    Toggle.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    Toggle.Size = UDim2.new(1,0,0,45)
    Toggle.ZIndex = 92
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,8)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Toggle
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0,250,1,0)
    Label.Position = UDim2.new(0,15,0,0)
    Label.Text = text
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 93
    
    local ToggleBtn = Instance.new("Frame")
    ToggleBtn.Parent = Toggle
    ToggleBtn.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
    ToggleBtn.Size = UDim2.new(0,50,0,24)
    ToggleBtn.Position = UDim2.new(1,-65,0.5,-12)
    ToggleBtn.ZIndex = 93
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)
    
    local Dot = Instance.new("Frame")
    Dot.Parent = ToggleBtn
    Dot.BackgroundColor3 = Color3.new(1,1,1)
    Dot.Size = UDim2.new(0,20,0,20)
    Dot.Position = UDim2.new(0,2,0,2)
    Dot.ZIndex = 94
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1,0)
    
    local state = false
    
    local function Update()
        if state then
            Dot.Position = UDim2.new(0,28,0,2)
            ToggleBtn.BackgroundColor3 = Color3.new(0,0.7,1)
        else
            Dot.Position = UDim2.new(0,2,0,2)
            ToggleBtn.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
        end
        if callback then callback(state) end
    end
    
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Update()
    end)
    
    return {Set = function(s) state = s Update() end}
end

local function CreateSlider(parent, text, min, max, def, callback)
    local Slider = Instance.new("Frame")
    Slider.Parent = parent
    Slider.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    Slider.Size = UDim2.new(1,0,0,60)
    Slider.ZIndex = 92
    Instance.new("UICorner", Slider).CornerRadius = UDim.new(0,8)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Slider
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1,-30,0,20)
    Label.Position = UDim2.new(0,15,0,5)
    Label.Text = text..": "..def
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 93
    
    local Track = Instance.new("Frame")
    Track.Parent = Slider
    Track.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
    Track.Size = UDim2.new(1,-30,0,5)
    Track.Position = UDim2.new(0,15,0,35)
    Track.ZIndex = 93
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1,0)
    
    local Fill = Instance.new("Frame")
    Fill.Parent = Track
    Fill.BackgroundColor3 = Color3.new(0,0.7,1)
    Fill.Size = UDim2.new((def-min)/(max-min),0,1,0)
    Fill.ZIndex = 94
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)
    
    local Btn = Instance.new("TextButton")
    Btn.Parent = Track
    Btn.BackgroundColor3 = Color3.new(1,1,1)
    Btn.Size = UDim2.new(0,10,0,15)
    Btn.Position = UDim2.new((def-min)/(max-min),-5,0,-5)
    Btn.Text = ""
    Btn.ZIndex = 95
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1,0)
    
    local dragging = false
    
    local function Update(value)
        local percent = math.clamp((value-min)/(max-min),0,1)
        Fill.Size = UDim2.new(percent,0,1,0)
        Btn.Position = UDim2.new(percent,-5,0,-5)
        Label.Text = text..": "..math.floor(value)
        callback(value)
    end
    
    Btn.MouseButton1Down:Connect(function() dragging = true end)
    game:GetService("UserInputService").InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    
    Track.MouseButton1Down:Connect(function(x)
        local percent = (x - Track.AbsolutePosition.X)/Track.AbsoluteSize.X
        Update(min + (max-min) * percent)
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local percent = (i.Position.X - Track.AbsolutePosition.X)/Track.AbsoluteSize.X
            Update(min + (max-min) * math.clamp(percent,0,1))
        end
    end)
    
    return {Set = Update}
end

-- Настройки
local ESP = {
    Enabled = false, Box2D = false, Box3D = false,
    HealthBar = true, HealthText = false, Names = true,
    Skeleton = false, Box2DColor = Color3.new(0,1,0),
    Box3DColor = Color3.new(1,0,0), TextColor = Color3.new(1,1,1)
}

local Aimbot = {
    Enabled = false, FOV = 50, MaxDistance = 500,
    VisibilityCheck = true, Smoothing = 0.1,
    FOVColor = Color3.new(1,1,1), TeamCheck = true
}

local Police = {AutoArrest = false, ArrestRange = 50}
local Movement = {Fly = false, Noclip = false, FlySpeed = 50}

-- Добавляем элементы в вкладки

-- AIMBOT
CreateToggle(AimTab, "Aimbot", function(s) Aimbot.Enabled = s end)
CreateSlider(AimTab, "FOV", 10, 200, 50, function(v) Aimbot.FOV = v end)
CreateSlider(AimTab, "Distance", 10, 1000, 500, function(v) Aimbot.MaxDistance = v end)
CreateToggle(AimTab, "Visibility Check", function(s) Aimbot.VisibilityCheck = s end)
CreateSlider(AimTab, "Smooth", 0, 1, 0.1, function(v) Aimbot.Smoothing = v end)
CreateToggle(AimTab, "Team Check", function(s) Aimbot.TeamCheck = s end)

-- ESP
CreateToggle(EspTab, "ESP", function(s) ESP.Enabled = s end)
CreateToggle(EspTab, "2D Box", function(s) ESP.Box2D = s end)
CreateToggle(EspTab, "3D Box", function(s) ESP.Box3D = s end)
CreateToggle(EspTab, "Health Bar", function(s) ESP.HealthBar = s end)
CreateToggle(EspTab, "Health Text", function(s) ESP.HealthText = s end)
CreateToggle(EspTab, "Names", function(s) ESP.Names = s end)
CreateToggle(EspTab, "Skeleton", function(s) ESP.Skeleton = s end)

-- MOVEMENT
CreateToggle(MoveTab, "Fly Hack", function(s) Movement.Fly = s end)
CreateToggle(MoveTab, "Noclip", function(s) Movement.Noclip = s end)
CreateSlider(MoveTab, "Fly Speed", 10, 100, 50, function(v) Movement.FlySpeed = v end)

-- POLICE
CreateToggle(PoliceTab, "Auto Arrest", function(s) Police.AutoArrest = s end)
CreateSlider(PoliceTab, "Arrest Range", 10, 100, 50, function(v) Police.ArrestRange = v end)

-- Управление меню
Circle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- Активируем первую вкладку
for _,btn in pairs(TabsContainer:GetChildren()) do
    if btn:IsA("TextButton") then
        btn:MouseButton1Click()
        break
    end
end

-- Функции чита
local ESPItems = {}

-- ESP функция
local function UpdateESP()
    for player, items in pairs(ESPItems) do
        if not player.Character then
            for _, item in pairs(items) do
                if item then item:Destroy() end
            end
            ESPItems[player] = nil
        end
    end
    
    if not ESP.Enabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            
            if root and hum and hum.Health > 0 then
                if not ESPItems[player] then
                    ESPItems[player] = {}
                end
                
                if ESP.Box2D and not ESPItems[player].Box2D then
                    local box = Instance.new("Frame")
                    box.Parent = ScreenGui
                    box.BackgroundTransparency = 1
                    box.BorderSizePixel = 2
                    box.BorderColor3 = ESP.Box2DColor
                    box.Size = UDim2.new(0,100,0,150)
                    ESPItems[player].Box2D = box
                end
                
                local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
                if onScreen then
                    if ESPItems[player].Box2D then
                        ESPItems[player].Box2D.Visible = ESP.Box2D
                        ESPItems[player].Box2D.Position = UDim2.new(0,pos.X-50,0,pos.Y-75)
                    end
                else
                    if ESPItems[player].Box2D then
                        ESPItems[player].Box2D.Visible = false
                    end
                end
            end
        end
    end
end

-- Fly Hack
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
            
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                move = move + cam.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                move = move - cam.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                move = move - cam.CFrame.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                move = move + cam.CFrame.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                move = move + Vector3.new(0,1,0)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                move = move - Vector3.new(0,1,0)
            end
            
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

-- Noclip
local function NoclipUpdate()
    if Movement.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- Auto Arrest
local function AutoArrestUpdate()
    if Police.AutoArrest and LocalPlayer.Team and LocalPlayer.Team.Name == "Police" then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Team.Name == "Criminal" then
                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                if targetRoot and localRoot then
                    local dist = (targetRoot.Position - localRoot.Position).Magnitude
                    if dist <= Police.ArrestRange then
                        pcall(function()
                            game:GetService("ReplicatedStorage").Arrest:InvokeServer(player)
                        end)
                    end
                end
            end
        end
    end
end

-- Запускаем циклы
RunService.Heartbeat:Connect(FlyUpdate)
RunService.Stepped:Connect(NoclipUpdate)
RunService.Heartbeat:Connect(AutoArrestUpdate)
RunService.Heartbeat:Connect(UpdateESP)

print("ExpensiveMods loaded! Click EM circle to open menu.")
