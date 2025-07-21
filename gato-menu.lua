-- GATO MENU - Arsenal Script
-- Compatível com Swift Executor

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Key do script
local SCRIPT_KEY = "GATOMENU2025"
local keyEntered = false

-- Variáveis do menu
local GatoMenu = {}
local menuVisible = false
local minimized = false

-- Cores do tema roxo
local Colors = {
    Primary = Color3.fromRGB(138, 43, 226),
    Secondary = Color3.fromRGB(75, 0, 130),
    Background = Color3.fromRGB(25, 25, 35),
    Surface = Color3.fromRGB(35, 35, 50),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(200, 200, 200),
    Accent = Color3.fromRGB(186, 85, 211)
}

-- Funções de hack
local Hacks = {
    Aimbot = false,
    ESP = false,
    Wallhack = false,
    SpeedHack = false,
    JumpBoost = false,
    InfiniteAmmo = false,
    NoRecoil = false,
    NoSpread = false,
    AutoShoot = false,
    Fly = false,
    TriggerBot = false,
    RainbowGun = false,
    GodMode = false,
    WallPenetration = false
}

-- Variáveis do aimbot
local aimbotEnabled = false
local aimbotConnection = nil

-- Função para criar intro animada
function createIntro()
    local introGui = Instance.new("ScreenGui")
    introGui.Name = "GatoIntro"
    introGui.Parent = CoreGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BackgroundTransparency = 0
    frame.Parent = introGui
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 400, 0, 100)
    titleLabel.Position = UDim2.new(0.5, -200, 0.5, -50)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "GATO MENU"
    titleLabel.TextColor3 = Colors.Primary
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextTransparency = 1
    titleLabel.Parent = frame
    
    local catEmoji = Instance.new("TextLabel")
    catEmoji.Size = UDim2.new(0, 80, 0, 80)
    catEmoji.Position = UDim2.new(0.5, -40, 0.5, 60)
    catEmoji.BackgroundTransparency = 1
    catEmoji.Text = "🐱"
    catEmoji.TextScaled = true
    catEmoji.TextTransparency = 1
    catEmoji.Parent = frame
    
    -- Animação da intro
    local fadeInTitle = TweenService:Create(titleLabel, TweenInfo.new(1, Enum.EasingStyle.Quad), {TextTransparency = 0})
    local fadeInCat = TweenService:Create(catEmoji, TweenInfo.new(1, Enum.EasingStyle.Quad), {TextTransparency = 0})
    local fadeOut = TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
    
    fadeInTitle:Play()
    wait(0.5)
    fadeInCat:Play()
    
    wait(2)
    fadeOut:Play()
    
    fadeOut.Completed:Connect(function()
        introGui:Destroy()
        showKeySystem()
    end)
end

-- Sistema de Key
function showKeySystem()
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "GatoKeySystem"
    keyGui.Parent = CoreGui
    
    local keyFrame = Instance.new("Frame")
    keyFrame.Size = UDim2.new(0, 400, 0, 250)
    keyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    keyFrame.BackgroundColor3 = Colors.Background
    keyFrame.BorderSizePixel = 0
    keyFrame.Parent = keyGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = keyFrame
    
    local titleKey = Instance.new("TextLabel")
    titleKey.Size = UDim2.new(1, 0, 0, 50)
    titleKey.Position = UDim2.new(0, 0, 0, 0)
    titleKey.BackgroundTransparency = 1
    titleKey.Text = "🐱 GATO MENU - KEY SYSTEM"
    titleKey.TextColor3 = Colors.Primary
    titleKey.TextScaled = true
    titleKey.Font = Enum.Font.GothamBold
    titleKey.Parent = keyFrame
    
    local keyInput = Instance.new("TextBox")
    keyInput.Size = UDim2.new(0, 300, 0, 40)
    keyInput.Position = UDim2.new(0.5, -150, 0, 80)
    keyInput.BackgroundColor3 = Colors.Surface
    keyInput.TextColor3 = Colors.Text
    keyInput.PlaceholderText = "Digite a key aqui..."
    keyInput.PlaceholderColor3 = Colors.TextSecondary
    keyInput.Font = Enum.Font.Gotham
    keyInput.TextSize = 16
    keyInput.BorderSizePixel = 0
    keyInput.Parent = keyFrame
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyInput
    
    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0, 150, 0, 40)
    submitBtn.Position = UDim2.new(0.5, -75, 0, 140)
    submitBtn.BackgroundColor3 = Colors.Primary
    submitBtn.TextColor3 = Colors.Text
    submitBtn.Text = "ENTRAR"
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 16
    submitBtn.BorderSizePixel = 0
    submitBtn.Parent = keyFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = submitBtn
    
    local keyInfo = Instance.new("TextLabel")
    keyInfo.Size = UDim2.new(1, 0, 0, 30)
    keyInfo.Position = UDim2.new(0, 0, 0, 200)
    keyInfo.BackgroundTransparency = 1
    keyInfo.Text = "Entre em contato para obter a key"
    keyInfo.TextColor3 = Colors.TextSecondary
    keyInfo.Font = Enum.Font.Gotham
    keyInfo.TextSize = 14
    keyInfo.Parent = keyFrame
    
    submitBtn.MouseButton1Click:Connect(function()
        if keyInput.Text == SCRIPT_KEY then
            keyEntered = true
            keyGui:Destroy()
            createMainMenu()
        else
            keyInput.Text = ""
            keyInput.PlaceholderText = "Key incorreta! Tente novamente..."
            keyInput.PlaceholderColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

-- Menu principal
function createMainMenu()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "GatoMenu"
    mainGui.Parent = CoreGui
    GatoMenu.Gui = mainGui
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Colors.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = mainGui
    GatoMenu.MainFrame = mainFrame
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 15)
    mainCorner.Parent = mainFrame
    
    -- Barra de título
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Colors.Primary
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 15)
    titleCorner.Parent = titleBar
    
    local titleFix = Instance.new("Frame")
    titleFix.Size = UDim2.new(1, 0, 0, 25)
    titleFix.Position = UDim2.new(0, 0, 1, -25)
    titleFix.BackgroundColor3 = Colors.Primary
    titleFix.BorderSizePixel = 0
    titleFix.Parent = titleBar
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 200, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🐱 GATO MENU"
    title.TextColor3 = Colors.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    -- Botões da barra de título
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -70, 0, 10)
    minimizeBtn.BackgroundColor3 = Colors.Accent
    minimizeBtn.Text = "-"
    minimizeBtn.TextColor3 = Colors.Text
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 20
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = titleBar
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minimizeBtn
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 10)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Colors.Text
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn
    
    -- Painel lateral (categorias)
    local sidePanel = Instance.new("Frame")
    sidePanel.Size = UDim2.new(0, 150, 1, -50)
    sidePanel.Position = UDim2.new(0, 0, 0, 50)
    sidePanel.BackgroundColor3 = Colors.Surface
    sidePanel.BorderSizePixel = 0
    sidePanel.Parent = mainFrame
    
    -- Painel principal (conteúdo)
    local contentPanel = Instance.new("ScrollingFrame")
    contentPanel.Size = UDim2.new(1, -150, 1, -50)
    contentPanel.Position = UDim2.new(0, 150, 0, 50)
    contentPanel.BackgroundColor3 = Colors.Background
    contentPanel.BorderSizePixel = 0
    contentPanel.ScrollBarThickness = 6
    contentPanel.ScrollBarImageColor3 = Colors.Primary
    contentPanel.Parent = mainFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = contentPanel
    
    -- Categorias
    local categories = {
        {name = "🎯 MIRA", functions = {"Aimbot", "TriggerBot", "AutoShoot", "NoRecoil", "NoSpread", "WallPenetration"}},
        {name = "👤 PLAYER", functions = {"SpeedHack", "JumpBoost", "Fly", "InfiniteAmmo", "GodMode"}},
        {name = "👁️ VISUAL", functions = {"ESP", "Wallhack", "RainbowGun"}},
        {name = "ℹ️ INFO", functions = {}}
    }
    
    local currentCategory = "🎯 MIRA"
    
    -- Criar botões de categoria
    for i, category in ipairs(categories) do
        local categoryBtn = Instance.new("TextButton")
        categoryBtn.Size = UDim2.new(1, -10, 0, 40)
        categoryBtn.Position = UDim2.new(0, 5, 0, (i-1) * 45 + 10)
        categoryBtn.BackgroundColor3 = category.name == currentCategory and Colors.Primary or Colors.Background
        categoryBtn.Text = category.name
        categoryBtn.TextColor3 = Colors.Text
        categoryBtn.Font = Enum.Font.Gotham
        categoryBtn.TextSize = 14
        categoryBtn.BorderSizePixel = 0
        categoryBtn.Parent = sidePanel
        
        local catCorner = Instance.new("UICorner")
        catCorner.CornerRadius = UDim.new(0, 8)
        catCorner.Parent = categoryBtn
        
        categoryBtn.MouseButton1Click:Connect(function()
            -- Atualizar categoria selecionada
            for _, child in pairs(sidePanel:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = Colors.Background
                end
            end
            categoryBtn.BackgroundColor3 = Colors.Primary
            currentCategory = category.name
            updateContent(category, contentPanel)
        end)
    end
    
    -- Bolinha minimizada
    local minimizedBall = Instance.new("Frame")
    minimizedBall.Name = "MinimizedBall"
    minimizedBall.Size = UDim2.new(0, 60, 0, 60)
    minimizedBall.Position = UDim2.new(0, 20, 0, 20)
    minimizedBall.BackgroundColor3 = Colors.Primary
    minimizedBall.BorderSizePixel = 0
    minimizedBall.Visible = false
    minimizedBall.Parent = mainGui
    GatoMenu.MinimizedBall = minimizedBall
    
    local ballCorner = Instance.new("UICorner")
    ballCorner.CornerRadius = UDim.new(0.5, 0)
    ballCorner.Parent = minimizedBall
    
    local catIcon = Instance.new("TextLabel")
    catIcon.Size = UDim2.new(1, 0, 1, 0)
    catIcon.BackgroundTransparency = 1
    catIcon.Text = "🐱"
    catIcon.TextScaled = true
    catIcon.Parent = minimizedBall
    
    -- Eventos dos botões
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        mainFrame.Visible = not minimized
        minimizedBall.Visible = minimized
    end)
    
    minimizedBall.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            minimized = false
            mainFrame.Visible = true
            minimizedBall.Visible = false
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        mainGui:Destroy()
        menuVisible = false
    end)
    
    -- Tornar o menu arrastável
    makeDraggable(titleBar, mainFrame)
    makeDraggable(minimizedBall, minimizedBall)
    
    -- Carregar categoria inicial
    updateContent(categories[1], contentPanel)
    menuVisible = true
end

-- Atualizar conteúdo da categoria
function updateContent(category, contentPanel)
    -- Limpar conteúdo anterior
    for _, child in pairs(contentPanel:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
    
    if category.name == "ℹ️ INFO" then
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -20, 0, 200)
        infoText.Position = UDim2.new(0, 10, 0, 0)
        infoText.BackgroundTransparency = 1
        infoText.Text = "🐱 GATO MENU v1.0\n\nCriado para Arsenal\nCompatível com Swift Executor\n\nKey: GATOMENU2025\n\nDesenvolvido com ❤️"
        infoText.TextColor3 = Colors.Text
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 16
        infoText.TextYAlignment = Enum.TextYAlignment.Top
        infoText.TextWrapped = true
        infoText.Parent = contentPanel
        return
    end
    
    -- Criar toggles para as funções
    for i, funcName in ipairs(category.functions) do
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, -20, 0, 50)
        toggleFrame.BackgroundColor3 = Colors.Surface
        toggleFrame.BorderSizePixel = 0
        toggleFrame.Parent = contentPanel
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 8)
        toggleCorner.Parent = toggleFrame
        
        local funcLabel = Instance.new("TextLabel")
        funcLabel.Size = UDim2.new(1, -100, 1, 0)
        funcLabel.Position = UDim2.new(0, 15, 0, 0)
        funcLabel.BackgroundTransparency = 1
        funcLabel.Text = funcName
        funcLabel.TextColor3 = Colors.Text
        funcLabel.Font = Enum.Font.Gotham
        funcLabel.TextSize = 16
        funcLabel.TextXAlignment = Enum.TextXAlignment.Left
        funcLabel.Parent = toggleFrame
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 60, 0, 30)
        toggleBtn.Position = UDim2.new(1, -75, 0.5, -15)
        toggleBtn.BackgroundColor3 = Hacks[funcName] and Colors.Primary or Color3.fromRGB(100, 100, 100)
        toggleBtn.Text = Hacks[funcName] and "ON" or "OFF"
        toggleBtn.TextColor3 = Colors.Text
        toggleBtn.Font = Enum.Font.GothamBold
        toggleBtn.TextSize = 12
        toggleBtn.BorderSizePixel = 0
        toggleBtn.Parent = toggleFrame
        
        local toggleBtnCorner = Instance.new("UICorner")
        toggleBtnCorner.CornerRadius = UDim.new(0, 6)
        toggleBtnCorner.Parent = toggleBtn
        
        toggleBtn.MouseButton1Click:Connect(function()
            Hacks[funcName] = not Hacks[funcName]
            toggleBtn.BackgroundColor3 = Hacks[funcName] and Colors.Primary or Color3.fromRGB(100, 100, 100)
            toggleBtn.Text = Hacks[funcName] and "ON" or "OFF"
            
            -- Ativar/desativar hack
            toggleHack(funcName, Hacks[funcName])
        end)
    end
    
    contentPanel.CanvasSize = UDim2.new(0, 0, 0, #category.functions * 60)
end

-- Tornar elementos arrastáveis
function makeDraggable(handle, frame)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Sistema de hacks
function toggleHack(hackName, enabled)
    if hackName == "Aimbot" and enabled then
        -- Aimbot ativado apenas quando botão direito do mouse pressionado
        aimbotEnabled = true
        aimbotConnection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                spawn(function()
                    while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and Hacks.Aimbot do
                        local target = getClosestEnemyPlayer()
                        if target and target.Character and target.Character:FindFirstChild("Head") then
                            local camera = Workspace.CurrentCamera
                            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, target.Character.Head.Position)
                        end
                        wait(0.02)
                    end
                end)
            end
        end)
    elseif hackName == "Aimbot" and not enabled then
        aimbotEnabled = false
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
    elseif hackName == "TriggerBot" then
        toggleTriggerBot(enabled)
    elseif hackName == "RainbowGun" then
        toggleRainbowGun(enabled)
    elseif hackName == "GodMode" and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        if enabled then
            Player.Character.Humanoid.MaxHealth = math.huge
            Player.Character.Humanoid.Health = math.huge
        else
            Player.Character.Humanoid.MaxHealth = 100
            Player.Character.Humanoid.Health = 100
        end
    elseif hackName == "WallPenetration" then
        toggleWallPenetration(enabled)
    elseif hackName == "ESP" then
        toggleESP(enabled)
    elseif hackName == "SpeedHack" and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = enabled and 50 or 16
    elseif hackName == "JumpBoost" and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.JumpPower = enabled and 100 or 50
    elseif hackName == "Fly" then
        toggleFly(enabled)
    end
end

-- Função para encontrar o jogador mais próximo
function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (Player.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end
    
    return closestPlayer
end

-- Sistema ESP
function toggleESP(enabled)
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Player then
                createESP(player)
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            removeESP(player)
        end
    end
end

function createESP(player)
    if not player.Character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "GatoESP"
    highlight.FillColor = Colors.Primary
    highlight.OutlineColor = Colors.Accent
    highlight.Parent = player.Character
end

function removeESP(player)
    if player.Character and player.Character:FindFirstChild("GatoESP") then
        player.Character.GatoESP:Destroy()
    end
end

-- Sistema Fly
local flying = false
local flyConnection = nil

function toggleFly(enabled)
    flying = enabled
    
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = Player.Character.HumanoidRootPart
    
    if flying then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = humanoidRootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flying then return end
            
            local moveVector = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveVector = moveVector + Workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveVector = moveVector - Workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveVector = moveVector - Workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveVector = moveVector + Workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveVector = moveVector + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveVector = moveVector - Vector3.new(0, 1, 0)
            end
            
            bodyVelocity.Velocity = moveVector * 50
        end)
    else
        if humanoidRootPart:FindFirstChild("BodyVelocity") then
            humanoidRootPart.BodyVelocity:Destroy()
        end
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
    end
end

-- Tecla para abrir/fechar menu (INSERT)
UserInputService.InputBegan:Connect(function(key, gameProcessed)
    if gameProcessed then return end
    
    if key.KeyCode == Enum.KeyCode.Insert then
        if not keyEntered then return end
        
        if menuVisible then
            if GatoMenu.Gui then
                GatoMenu.Gui:Destroy()
            end
            menuVisible = false
        else
            createMainMenu()
        end
    end
end)

-- Inicializar script
print("🐱 GATO MENU - Carregando...")
createIntro()
