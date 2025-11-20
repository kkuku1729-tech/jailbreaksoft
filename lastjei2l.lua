-- KeyAuth система защиты
local KeyAuth = {
    name = "ruztsoft",
    ownerid = "Q2uvPey1OB", 
    secret = "217bed44eac9e5ac571c511296c651c786c962448b16c9ca7b49d91f86270ee6",
    version = "1.0",
    url = "https://keyauth.win/api/1.2/"
}

local KeyAuthAPI = {}
function KeyAuthAPI:initialize()
    local response = request({
        Url = KeyAuth.url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded"
        },
        Body = "type=init&name=" .. KeyAuth.name .. "&ownerid=" .. KeyAuth.ownerid .. "&ver=" .. KeyAuth.version
    })
    
    if response.Success then
        local data = game:GetService("HttpService"):JSONDecode(response.Body)
        if data.success then
            print("✅ KeyAuth initialized")
            return true
        else
            print("❌ KeyAuth error: " .. data.message)
            return false
        end
    else
        print("❌ Failed to connect to KeyAuth")
        return false
    end
end

function KeyAuthAPI:login(key)
    local response = request({
        Url = KeyAuth.url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded"
        },
        Body = "type=license&key=" .. key .. "&name=" .. KeyAuth.name .. "&ownerid=" .. KeyAuth.ownerid .. "&sessionid=" .. self.sessionid
    })
    
    if response.Success then
        local data = game:GetService("HttpService"):JSONDecode(response.Body)
        if data.success then
            print("✅ License valid")
            return true
        else
            print("❌ Invalid license: " .. data.message)
            return false
        end
    else
        print("❌ Failed to verify license")
        return false
    end
end

-- Проверка лицензии перед запуском
local function CheckLicense()
    -- Создаем GUI для ввода ключа
    local KeyGUI = Instance.new("ScreenGui")
    KeyGUI.Name = "KeyAuthGUI"
    KeyGUI.Parent = game.CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = KeyGUI
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    Title.Text = "ExpensiveMods - Активация"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
    KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
    KeyBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    KeyBox.TextColor3 = Color3.new(1, 1, 1)
    KeyBox.PlaceholderText = "Введите лицензионный ключ"
    KeyBox.Text = ""
    KeyBox.Parent = MainFrame
    
    local ActivateBtn = Instance.new("TextButton")
    ActivateBtn.Size = UDim2.new(0.6, 0, 0, 35)
    ActivateBtn.Position = UDim2.new(0.2, 0, 0.6, 0)
    ActivateBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
    ActivateBtn.TextColor3 = Color3.new(1, 1, 1)
    ActivateBtn.Text = "Активировать"
    ActivateBtn.Font = Enum.Font.GothamBold
    ActivateBtn.Parent = MainFrame
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, 0, 0, 20)
    Status.Position = UDim2.new(0, 0, 0.8, 0)
    Status.BackgroundTransparency = 1
    Status.Text = "Ожидание ключа..."
    Status.TextColor3 = Color3.new(1, 1, 1)
    Status.TextSize = 12
    Status.Parent = MainFrame
    
    ActivateBtn.MouseButton1Click:Connect(function()
        local key = KeyBox.Text
        if key == "" then
            Status.Text = "Введите ключ!"
            Status.TextColor3 = Color3.new(1, 0, 0)
            return
        end
        
        Status.Text = "Проверка ключа..."
        Status.TextColor3 = Color3.new(1, 1, 0)
        
        -- Здесь должна быть реальная проверка через KeyAuth API
        -- Для демонстрации используем временное решение
        wait(1)
        
        -- ВРЕМЕННО: любой ключ проходит проверку
        -- ЗАМЕНИТЕ НА РЕАЛЬНУЮ ПРОВЕРКУ ЧЕРЕЗ KEYAUTH API
        if string.len(key) > 5 then
            Status.Text = "✅ Ключ активирован!"
            Status.TextColor3 = Color3.new(0, 1, 0)
            wait(1)
            KeyGUI:Destroy()
            LoadCheat() -- Загружаем чит после успешной активации
        else
            Status.Text = "❌ Неверный ключ!"
            Status.TextColor3 = Color3.new(1, 0, 0)
        end
    end)
end

-- Функция загрузки чита (весь предыдущий код)
local function LoadCheat()
    -- ВСТАВЬТЕ ЗДЕСЬ ВЕСЬ ПРЕДЫДУЩИЙ КОД ЧИТА
    -- ExpensiveMods Jailbreak Cheat
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local Workspace = game:GetService("Workspace")

    -- ... (весь остальной код чита)

    print("✅ ExpensiveMods успешно загружен!")
end

-- Запускаем проверку лицензии
CheckLicense()

-- ДОБАВЬТЕ В КОНЕЦ ВАШЕГО КОДА:

-- Защита от декомпиляции
local function AntiTamper()
    -- Проверка целостности скрипта
    if not getgenv().ExpensiveModsLoaded then
        getgenv().ExpensiveModsLoaded = true
    else
        game.Players.LocalPlayer:Kick("Обнаружена попытка повторной инъекции!")
        return
    end
    
    -- Анти-дамп
    for i,v in pairs(getreg()) do
        if type(v) == "function" and is_synapse_function(v) then
            hookfunction(v, function(...)
                return ...
            end)
        end
    end
end

AntiTamper()

-- Регулярная проверка лицензии
while wait(30) do
    -- Здесь должен быть код проверки статуса лицензии
    -- Если лицензия невалидна - кик игрока
    -- game.Players.LocalPlayer:Kick("Лицензия истекла!")
end
