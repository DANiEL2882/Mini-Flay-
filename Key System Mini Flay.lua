local service = 1364
local secret = "Mini Flay"
local useNonce = true
local onMessage = function(message)
    print(message)
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", { Text = message; })
end

repeat task.wait(1) until game:IsLoaded() or game.Players.LocalPlayer

local requestSending = false
local fRequest, fToString, fOsTime, fGetHwid = request or http_request, tostring, os.time, gethwid or function()
    return game:GetService("Players").LocalPlayer.UserId
end
local HttpService = game:GetService("HttpService")

local function lEncode(data)
    return HttpService:JSONEncode(data)
end

local function lDecode(data)
    return HttpService:JSONDecode(data)
end

local function lDigest(input)
    local inputStr = tostring(input)
    local hash = {}
    for i = 1, #inputStr do
        table.insert(hash, string.byte(inputStr, i))
    end

    local hashHex = ""
    for _, byte in ipairs(hash) do
        hashHex = hashHex .. string.format("%02x", byte)
    end
    
    return hashHex
end

local host = "https://api.platoboost.com"

local function verifyKey(key)
    if requestSending then
        onMessage("Um pedido já está sendo enviado, aguarde.")
        return false
    end
    requestSending = true

    local nonce = fToString(math.random(100000, 999999)) -- Simples nonce aleatório
    local endpoint = host .. "/public/whitelist/" .. fToString(service) ..
                     "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key .. "&nonce=" .. nonce
    print("Requesting URL: " .. endpoint)

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    })

    requestSending = false
    print("Response Status Code: " .. response.StatusCode)

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        if decoded.success and decoded.data.valid then
            return true
        else
            onMessage("Key inválida.")
            return false
        end
    else
        onMessage("Erro na verificação da key. Código: " .. response.StatusCode)
        return false
    end
end

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = Frame

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 40, 0, 40)
Close.Position = UDim2.new(1, -40, 0, 0)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextScaled = true
Close.TextColor3 = Color3.fromRGB(150, 150, 150)
Close.Parent = Frame
Close.MouseButton1Click:Connect(function()
   ScreenGui:Destroy()
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0.05, 0)
Title.Text = "Mini Flay"
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0, 0, 255)
Title.BackgroundTransparency = 1
Title.Parent = Frame

local Instructions = Instance.new("TextLabel")
Instructions.Size = UDim2.new(1, 0, 0, 30)
Instructions.Position = UDim2.new(0, 0, 0.2, 0)
Instructions.Text = "Insira Sua Key Para Ter Acesso Ao Mini Flay"
Instructions.TextSize = 13
Instructions.TextColor3 = Color3.fromRGB(150, 150, 150)
Instructions.BackgroundTransparency = 1
Instructions.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.8, 0, 0.2, 0)
TextBox.Position = UDim2.new(0.1, 0, 0.4, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextBox.PlaceholderText = "Insira Sua Key"
TextBox.Text = ""
TextBox.TextSize = 18
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)  -- Text color set to black
TextBox.Parent = Frame

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0, 5)
TextBoxCorner.Parent = TextBox

local CheckKey = Instance.new("TextButton")
CheckKey.Size = UDim2.new(0.5, 0, 0.15, 0)
CheckKey.Position = UDim2.new(0.25, 0, 0.7, 0)
CheckKey.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CheckKey.Text = "Verificar Key"
CheckKey.TextSize = 18
CheckKey.TextColor3 = Color3.fromRGB(150, 150, 150)
CheckKey.Parent = Frame

local CheckKeyCorner = Instance.new("UICorner")
CheckKeyCorner.CornerRadius = UDim.new(0, 5)
CheckKeyCorner.Parent = CheckKey

CheckKey.MouseEnter:Connect(function()
    CheckKey.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

CheckKey.MouseLeave:Connect(function()
    CheckKey.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
end)

CheckKey.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text
    if enteredKey ~= "" and enteredKey ~= "Insira Sua Key" then
        local isValid = verifyKey(enteredKey)
        if isValid then
            TextBox.PlaceholderText = "Key Correta"
            TextBox.Text = ""
            wait(1)
            ScreenGui:Destroy()
            
            -- Load external script after key verification
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DANiEL2882/Mini-Flay-/refs/heads/main/Mini%20Flay.lua"))()
        else
            TextBox.PlaceholderText = "Key Inválida Tente Novamente"
            TextBox.Text = ""
            wait(1)
            TextBox.PlaceholderText = "Insira Sua Key"
        end
    else
        onMessage("Por favor, insira uma chave válida.")
    end
end)