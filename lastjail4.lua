-- KeyAuth Configuration (ЗАМЕНИТЕ НА ВАШИ РЕАЛЬНЫЕ ДАННЫЕ)
local KeyAuthConfig = {
    name = "ExpensiveMods",          -- Имя вашего приложения в KeyAuth
    ownerid = "ВАШ_OWNER_ID",        -- Ваш Owner ID из KeyAuth
    secret = "ВАШ_SECRET_KEY",       -- Ваш Secret Key из KeyAuth  
    version = "1.0",
    url = "https://keyauth.win/api/1.2/"
}

-- Real KeyAuth System
local KeyAuthSystem = {}
KeyAuthSystem.initialized = false
KeyAuthSystem.sessionid = ""
KeyAuthSystem.authenticated = false

function KeyAuthSystem:Initialize()
    if self.initialized then return true, "Already initialized" end
    
    print("🔑 Initializing KeyAuth...")
    
    local requestBody = "type=init&name=" .. KeyAuthConfig.name .. 
                       "&ownerid=" .. KeyAuthConfig.ownerid .. 
                       "&ver=" .. KeyAuthConfig.version
    
    local success, result = pcall(function()
        local response = request({
            Url = KeyAuthConfig.url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/x-www-form-urlencoded"
            },
            Body = requestBody
        })
        
        if response and response.Success then
            local data = game:GetService("HttpService"):JSONDecode(response.Body)
            if data.success then
                self.sessionid = data.sessionid
                self.initialized = true
                print("✅ KeyAuth initialized successfully")
                return true
            else
                return false, data.message or "Initialization failed"
            end
        else
            return false, "Failed to connect to KeyAuth API"
        end
    end)
    
    if success then
        return result
    else
        return false, result or "Initialization error"
    end
end

function KeyAuthSystem:Login(key)
    if not self.initialized then
        local success, msg = self:Initialize()
        if not success then
            return false, msg
        end
    end
    
    local requestBody = "type=license&key=" .. key .. 
                       "&name=" .. KeyAuthConfig.name .. 
                       "&ownerid=" .. KeyAuthConfig.ownerid .. 
                       "&sessionid=" .. self.sessionid
    
    local success, result = pcall(function()
        local response = request({
            Url = KeyAuthConfig.url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/x-www-form-urlencoded"
            },
            Body = requestBody
        })
        
        if response and response.Success then
            local data = game:GetService("HttpService"):JSONDecode(response.Body)
            if data.success then
                self.authenticated = true
                print("✅ License activated successfully")
                return true
            else
                return false, data.message or "Invalid license"
            end
        else
            return false, "Failed to verify license"
        end
    end)
    
    if success then
        return result
    else
        return false, result or "Login error"
    end
end

function KeyAuthSystem:CheckSession()
    if not self.initialized or not self.authenticated then
        return false, "Not authenticated"
    end
    
    local requestBody = "type=check&name=" .. KeyAuthConfig.name .. 
                       "&ownerid=" .. KeyAuthConfig.ownerid .. 
                       "&sessionid=" .. self.sessionid
    
    local success, result = pcall(function()
        local response = request({
            Url = KeyAuthConfig.url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/x-www-form-urlencoded"
            },
            Body = requestBody
        })
        
        if response and response.Success then
            local data = game:GetService("HttpService"):JSONDecode(response.Body)
            return data.success, data.message
        else
            return false, "Session check failed"
        end
    end)
    
    return success and result
end

-- License Check GUI
local function CreateLicenseGUI()
    local LicenseGUI = Instance.new("ScreenGui")
    LicenseGUI.Name = "LicenseGUI"
    LicenseGUI.Parent = game.CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 280)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = LicenseGUI
    
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "ExpensiveMods - License Activation"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = TopBar
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(0.8, 0, 0, 40)
    InfoLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "Enter your license key to activate ExpensiveMods"
    InfoLabel.TextColor3 = Color3.new(1, 1, 1)
    InfoLabel.TextSize = 12
    InfoLabel.TextWrapped = true
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.Parent = MainFrame
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
    KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
    KeyBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    KeyBox.TextColor3 = Color3.new(1, 1, 1)
    KeyBox.PlaceholderText = "Enter license key..."
    KeyBox.Text = ""
    KeyBox.TextSize = 14
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.Parent = MainFrame
    
    local ActivateBtn = Instance.new("TextButton")
    ActivateBtn.Size = UDim2.new(0.6, 0, 0, 40)
    ActivateBtn.Position = UDim2.new(0.2, 0, 0.6, 0)
    ActivateBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
    ActivateBtn.TextColor3 = Color3.new(1, 1, 1)
    ActivateBtn.Text = "Activate License"
    ActivateBtn.TextSize = 14
    ActivateBtn.Font = Enum.Font.GothamBold
    ActivateBtn.Parent = MainFrame
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, 0, 0, 30)
    Status.Position = UDim2.new(0, 0, 0.85, 0)
    Status.BackgroundTransparency = 1
    Status.Text = "Waiting for license key..."
    Status.TextColor3 = Color3.new(1, 1, 1)
    Status.TextSize = 12
    Status.Font = Enum.Font.Gotham
    Status.Parent = MainFrame
    
    -- Close button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0, 7)
    CloseBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.Text = "X"
    CloseBtn.TextSize = 12
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = TopBar
    
    ActivateBtn.MouseButton1Click:Connect(function()
        local key = string.gsub(KeyBox.Text, "%s+", "")
        if key == "" then
            Status.Text = "❌ Please enter a license key"
            Status.TextColor3 = Color3.new(1, 0, 0)
            return
        end
        
        ActivateBtn.Text = "Checking..."
        ActivateBtn.BackgroundColor3 = Color3.new(1, 0.5, 0)
        Status.Text = "Verifying license key..."
        Status.TextColor3 = Color3.new(1, 1, 0)
        
        -- Real KeyAuth verification
        local success, message = KeyAuthSystem:Login(key)
        
        if success then
            Status.Text = "✅ License activated successfully!"
            Status.TextColor3 = Color3.new(0, 1, 0)
            ActivateBtn.Text = "Success!"
            ActivateBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
            
            wait(2)
            LicenseGUI:Destroy()
            LoadExpensiveMods() -- Load the actual cheat
        else
            Status.Text = "❌ " .. (message or "Invalid license key")
            Status.TextColor3 = Color3.new(1, 0, 0)
            ActivateBtn.Text = "Activate License"
            ActivateBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
        end
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        game.Players.LocalPlayer:Kick("ExpensiveMods: License not activated")
    end)
    
    KeyBox.Focused:Connect(function()
        KeyBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    end)
    
    KeyBox.FocusLost:Connect(function()
        KeyBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    end)
    
    -- Enter key support
    KeyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            ActivateBtn:MouseButton1Click()
        end
    end)
end

-- Anti-Tamper Protection
local function AntiTamper()
    if getgenv().ExpensiveModsInjected then
        game.Players.LocalPlayer:Kick("ExpensiveMods: Multiple injection detected")
        return false
    end
    getgenv().ExpensiveModsInjected = true
    
    -- Basic integrity checks
    if not pcall(function() 
        return game:GetService("Players").LocalPlayer.UserId > 0 
    end) then
        game.Players.LocalPlayer:Kick("ExpensiveMods: Integrity check failed")
        return false
    end
    
    return true
end

-- Session monitoring
local function StartSessionMonitor()
    while wait(60) do -- Check every minute
        if KeyAuthSystem.authenticated then
            local success, message = KeyAuthSystem:CheckSession()
            if not success then
                game.Players.LocalPlayer:Kick("ExpensiveMods: Session expired - " .. (message or "Unknown error"))
                break
            end
        end
    end
end

-- Modified initialization to include KeyAuth
local originalInitialize = InitializePlayers
InitializePlayers = function()
    if not AntiTamper() then return end
    
    -- Start session monitoring
    coroutine.wrap(StartSessionMonitor)()
    
    -- Call original function
    originalInitialize()
end

-- Replace the original print with protected version
print("ExpensiveMods: Loading KeyAuth protection...")

-- Start KeyAuth system
CreateLicenseGUI()

-- YOUR ORIGINAL CODE CONTINUES HERE (все что было после этого комментария остается без изменений)
