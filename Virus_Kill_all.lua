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
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Parent = Frame

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0, 5)
TextBoxCorner.Parent = TextBox

local CheckKey = Instance.new("TextButton")
CheckKey.Size = UDim2.new(0.5, 0, 0.15, 0) -- Aumentei um pouco o tamanho para preencher melhor o espaço
CheckKey.Position = UDim2.new(0.25, 0, 0.7, 0) -- Centralizado
CheckKey.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CheckKey.Text = "Verificar Key"
CheckKey.TextSize = 18
CheckKey.TextColor3 = Color3.fromRGB(150, 150, 150)
CheckKey.Parent = Frame

local CheckKeyCorner = Instance.new("UICorner")
CheckKeyCorner.CornerRadius = UDim.new(0, 5)
CheckKeyCorner.Parent = CheckKey

local function validateKey(key)
    return key == "Key" -- Substitua pela sua key real
end

CheckKey.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text
    if validateKey(enteredKey) then
        TextBox.PlaceholderText = "Key Correta"
        TextBox.Text = ""
        wait(1)
        ScreenGui:Destroy()

        -- Seu script aqui
        loadstring(game:HttpGet('https://pastebin.com/raw/YSL3xKYU'))()

    else
        TextBox.PlaceholderText = "Key Inválida Tente Novamente"
        TextBox.Text = ""
        wait(1)
        TextBox.PlaceholderText = "Insira Sua Key"
    end
end)
