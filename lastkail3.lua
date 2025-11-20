-- ExpensiveMods Jailbreak Cheat with KeyAuth Protection
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

-- KeyAuth Configuration
local KeyAuthConfig = {
    name = "ruztsoft",
    ownerid = "Q2uvPey1OB",  -- ЗАМЕНИТЕ НА ВАШ OWNER_ID
    secret = "217bed44eac9e5ac571c511296c651c786c962448b16c9ca7b49d91f86270ee6", -- ЗАМЕНИТЕ НА ВАШ SECRET_KEY
    version = "1.0",
    url = "https://keyauth.win/api/1.2/"
}

-- KeyAuth System
local KeyAuthSystem = {}
KeyAuthSystem.initialized = false
KeyAuthSystem.sessionid = ""
KeyAuthSystem.authenticated = false

function KeyAuthSystem:Initialize()
    if self.initialized then return true end
    
    local success, result = pcall(function()
        local response = request({
            Url = KeyAuthConfig.url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/x-www-form-urlencoded"
            },
            Body = "type=init&name=" .. KeyAuthConfig.name .. "&ownerid=" .. KeyAuthConfig.ownerid .. "&ver=" .. KeyAuthConfig.version
        })
        
        if response and response.Success then
            local data = HttpService:JSONDecode(response.Body)
            if data.success then
                self.sessionid = data.sessionid
                self.initialized = true
                return true
            else
                return false, data.message
            end
        else
            return false, "Connection failed"
        end
    end)
    
    if success then
        return result
    else
        return false, "Initialization error"
    end
end

function KeyAuthSystem:Login(key)
    if not self.initialized then
        local success, msg = self:Initialize()
        if not success then
            return false, msg
        end
    end
    
    local success, result = pcall(function()
        local response = request({
            Url = KeyAuthConfig.url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/x-www-form-urlencoded"
            },
            Body = "type=license&key=" .. key .. "&name=" .. KeyAuthConfig.name .. "&ownerid=" .. KeyAuthConfig.ownerid .. "&sessionid=" .. self.sessionid
        })
        
        if response and response.Success then
            local data = HttpService:JSONDecode(response.Body)
            if data.success then
                self.authenticated = true
                return true
            else
                return false, data.message
            end
        else
            return false, "Connection failed"
        end
    end)
    
    if success then
        return result
    else
        return false, "Login error"
    end
end

-- License Check GUI
local function CreateLicenseGUI()
    local LicenseGUI = Instance.new("ScreenGui")
    LicenseGUI.Name = "LicenseGUI"
    LicenseGUI.Parent = game.CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = LicenseGUI
    
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "ExpensiveMods - Активация"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = TopBar
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
    KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
    KeyBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    KeyBox.TextColor3 = Color3.new(1, 1, 1)
    KeyBox.PlaceholderText = "Введите лицензионный ключ..."
    KeyBox.Text = ""
    KeyBox.TextSize = 14
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.Parent = MainFrame
    
    local ActivateBtn = Instance.new("TextButton")
    ActivateBtn.Size = UDim2.new(0.6, 0, 0, 40)
    ActivateBtn.Position = UDim2.new(0.2, 0, 0.6, 0)
    ActivateBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
    ActivateBtn.TextColor3 = Color3.new(1, 1, 1)
    ActivateBtn.Text = "Активировать"
    ActivateBtn.TextSize = 14
    ActivateBtn.Font = Enum.Font.GothamBold
    ActivateBtn.Parent = MainFrame
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, 0, 0, 25)
    Status.Position = UDim2.new(0, 0, 0.8, 0)
    Status.BackgroundTransparency = 1
    Status.Text = "Ожидание ключа..."
    Status.TextColor3 = Color3.new(1, 1, 1)
    Status.TextSize = 12
    Status.Font = Enum.Font.Gotham
    Status.Parent = MainFrame
    
    ActivateBtn.MouseButton1Click:Connect(function()
        local key = string.gsub(KeyBox.Text, "%s+", "")
        if key == "" then
            Status.Text = "❌ Введите ключ!"
            Status.TextColor3 = Color3.new(1, 0, 0)
            return
        end
        
        ActivateBtn.Text = "Проверка..."
        ActivateBtn.BackgroundColor3 = Color3.new(1, 0.5, 0)
        Status.Text = "Проверка ключа..."
        Status.TextColor3 = Color3.new(1, 1, 0)
        
        local success, message = KeyAuthSystem:Login(key)
        
        if success then
            Status.Text = "✅ Ключ активирован!"
            Status.TextColor3 = Color3.new(0, 1, 0)
            ActivateBtn.Text = "Успешно!"
            ActivateBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
            
            wait(1)
            LicenseGUI:Destroy()
            LoadExpensiveMods()
        else
            Status.Text = "❌ Ошибка: " .. (message or "Неизвестная ошибка")
            Status.TextColor3 = Color3.new(1, 0, 0)
            ActivateBtn.Text = "Активировать"
            ActivateBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
        end
    end)
    
    -- Close button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.Text = "X"
    CloseBtn.TextSize = 12
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = TopBar
    
    CloseBtn.MouseButton1Click:Connect(function()
        game.Players.LocalPlayer:Kick("ExpensiveMods: Лицензия не активирована")
    end)
    
    KeyBox.Focused:Connect(function()
        KeyBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    end)
    
    KeyBox.FocusLost:Connect(function()
        KeyBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    end)
end

-- Anti-Tamper Protection
local function AntiTamper()
    if getgenv().ExpensiveModsInjected then
        game.Players.LocalPlayer:Kick("ExpensiveMods: Обнаружена повторная инъекция")
        return false
    end
    getgenv().ExpensiveModsInjected = true
    
    -- Basic integrity check
    if not pcall(function() Workspace.CurrentCamera:GetChildren() end) then
        game.Players.LocalPlayer:Kick("ExpensiveMods: Ошибка целостности")
        return false
    end
    
    return true
end

-- Main Load Function
local function LoadExpensiveMods()
    if not AntiTamper() then return end
    
    -- GUI Creation
    local ExpensiveModsGUI = Instance.new("ScreenGui")
    local DragCircle = Instance.new("TextButton")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local TabContainer = Instance.new("Frame")
    local ButtonContainer = Instance.new("ScrollingFrame")

    ExpensiveModsGUI.Name = "ExpensiveModsGUI"
    ExpensiveModsGUI.Parent = game.CoreGui
    ExpensiveModsGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Drag Circle
    DragCircle.Name = "DragCircle"
    DragCircle.Parent = ExpensiveModsGUI
    DragCircle.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    DragCircle.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    DragCircle.Position = UDim2.new(0, 50, 0, 50)
    DragCircle.Size = UDim2.new(0, 40, 0, 40)
    DragCircle.Font = Enum.Font.GothamBold
    DragCircle.Text = "EM"
    DragCircle.TextColor3 = Color3.new(1, 1, 1)
    DragCircle.TextSize = 14
    DragCircle.ZIndex = 2
    DragCircle.AutoButtonColor = false

    -- Main Frame
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ExpensiveModsGUI
    MainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    MainFrame.BorderColor3 = Color3.new(0.2, 0.2, 0.2)
    MainFrame.Position = UDim2.new(0, 100, 0, 100)
    MainFrame.Size = UDim2.new(0, 350, 0, 450)
    MainFrame.Visible = false
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- Top Bar
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 35)

    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "ExpensiveMods"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.TextSize = 14
    CloseButton.AutoButtonColor = false

    -- Tab Container
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 35)
    TabContainer.Size = UDim2.new(0, 100, 1, -35)

    -- Button Container
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Parent = MainFrame
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Position = UDim2.new(0, 100, 0, 35)
    ButtonContainer.Size = UDim2.new(1, -100, 1, -35)
    ButtonContainer.CanvasSize = UDim2.new(0, 0, 2, 0)
    ButtonContainer.ScrollBarThickness = 4
    ButtonContainer.ScrollingDirection = Enum.ScrollingDirection.Y

    -- FOV Circle
    local FOVCircle = Instance.new("Frame")
    FOVCircle.Name = "FOVCircle"
    FOVCircle.Parent = ExpensiveModsGUI
    FOVCircle.BackgroundColor3 = Color3.new(1, 1, 1)
    FOVCircle.BackgroundTransparency = 0.7
    FOVCircle.BorderSizePixel = 0
    FOVCircle.Size = UDim2.new(0, 100, 0, 100)
    FOVCircle.Position = UDim2.new(0.5, -50, 0.5, -50)
    FOVCircle.Visible = false

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = FOVCircle

    -- Variables
    local Tabs = {}
    local CurrentTab = nil
    local Aimbot = {
        Enabled = false,
        FOV = 50,
        Target = nil,
        Smoothing = 5,
        VisibilityCheck = true,
        AutoShot = false,
        HitPart = "Head"
    }
    local ESP = {
        Enabled = false,
        Box2D = false,
        Box3D = false,
        Chams = false,
        Boxes2D = {},
        Boxes3D = {},
        ChamsObjects = {},
        Colors = {
            Box2D = Color3.new(1, 0, 0),
            Box3D = Color3.new(0, 1, 0),
            Chams = Color3.new(0, 0, 1),
            Team = true
        }
    }
    local Fly = {
        Enabled = false,
        Speed = 50,
        BodyVelocity = nil,
        BodyGyro = nil
    }
    local Noclip = {
        Enabled = false
    }
    local AutoArrest = {
        Enabled = false,
        Range = 50
    }
    local LongArrest = {
        Enabled = false
    }
    local AutoGun = {
        Enabled = false
    }

    -- Player Tracking
    local PlayerConnections = {}

    -- Animation Functions
    local function TweenButton(button)
        local originalSize = button.Size
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local tween1 = TweenService:Create(button, tweenInfo, {Size = originalSize - UDim2.new(0, 4, 0, 4)})
        local tween2 = TweenService:Create(button, tweenInfo, {Size = originalSize})
        
        tween1:Play()
        tween1.Completed:Connect(function()
            tween2:Play()
        end)
    end

    local function TweenToggle(toggle, enabled)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if enabled then
            TweenService:Create(toggle, tweenInfo, {BackgroundColor3 = Color3.new(0, 0.5, 0)}):Play()
            TweenService:Create(toggle.ToggleDot, tweenInfo, {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        else
            TweenService:Create(toggle, tweenInfo, {BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)}):Play()
            TweenService:Create(toggle.ToggleDot, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
    end

    -- GUI Functions
    local function CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 45)
        TabButton.Position = UDim2.new(0, 0, 0, (#TabContainer:GetChildren() - 1) * 45)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.TextColor3 = Color3.new(1, 1, 1)
        TabButton.TextSize = 12
        TabButton.AutoButtonColor = false
        
        local TabFrame = Instance.new("Frame")
        TabFrame.Name = name
        TabFrame.Parent = ButtonContainer
        TabFrame.BackgroundTransparency = 1
        TabFrame.Size = UDim2.new(1, 0, 0, 0)
        TabFrame.Visible = false
        
        Tabs[name] = TabFrame
        
        TabButton.MouseButton1Click:Connect(function()
            TweenButton(TabButton)
            for tabName, tabFrame in pairs(Tabs) do
                tabFrame.Visible = false
            end
            TabFrame.Visible = true
            CurrentTab = name
        end)
        
        return TabFrame
    end

    local function CreateToggle(parent, text, callback)
        local ToggleFrame = Instance.new("Frame")
        local ToggleLabel = Instance.new("TextLabel")
        local ToggleButton = Instance.new("TextButton")
        local ToggleDot = Instance.new("Frame")
        
        ToggleFrame.Name = "ToggleFrame"
        ToggleFrame.Parent = parent
        ToggleFrame.BackgroundTransparency = 1
        ToggleFrame.Size = UDim2.new(1, -20, 0, 35)
        ToggleFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 40)
        
        ToggleLabel.Name = "ToggleLabel"
        ToggleLabel.Parent = ToggleFrame
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
        ToggleLabel.Size = UDim2.new(0, 150, 1, 0)
        ToggleLabel.Font = Enum.Font.Gotham
        ToggleLabel.Text = text
        ToggleLabel.TextColor3 = Color3.new(1, 1, 1)
        ToggleLabel.TextSize = 14
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        ToggleButton.Name = "ToggleButton"
        ToggleButton.Parent = ToggleFrame
        ToggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        ToggleButton.BorderSizePixel = 0
        ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
        ToggleButton.Size = UDim2.new(0, 40, 0, 20)
        ToggleButton.Font = Enum.Font.SourceSans
        ToggleButton.Text = ""
        ToggleButton.TextColor3 = Color3.new(0, 0, 0)
        ToggleButton.TextSize = 14
        ToggleButton.AutoButtonColor = false
        
        ToggleDot.Name = "ToggleDot"
        ToggleDot.Parent = ToggleButton
        ToggleDot.BackgroundColor3 = Color3.new(1, 1, 1)
        ToggleDot.BorderSizePixel = 0
        ToggleDot.Position = UDim2.new(0, 2, 0.5, -8)
        ToggleDot.Size = UDim2.new(0, 16, 0, 16)
        
        local enabled = false
        
        ToggleButton.MouseButton1Click:Connect(function()
            enabled = not enabled
            TweenToggle(ToggleButton, enabled)
            callback(enabled)
        end)
        
        return ToggleButton
    end

    -- ... (ПРОДОЛЖЕНИЕ ВАШЕГО КОДА С ESP, AIMBOT И ДРУГИМИ ФУНКЦИЯМИ)

    -- Запускаем чит
    print("✅ ExpensiveMods успешно загружен с KeyAuth защитой!")
end

-- Start KeyAuth System
CreateLicenseGUI()
