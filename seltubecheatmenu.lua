-- ==============================================================================
-- 👑 SELTUBE PREMIUM V2 (ULTRA RGB & ADVANCED EXPLOIT SUITE) 👑
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- ------------------------------------------------------------------------------
-- 1. SES SİSTEMİ
-- ------------------------------------------------------------------------------
local function playSound(id, vol)
    task.spawn(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. tostring(id)
        sound.Volume = vol or 0.5
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end)
end

local SOUND_OPEN = 9114223179
local SOUND_CLICK = 6895079853
local SOUND_POWER = 9113881268

-- ------------------------------------------------------------------------------
-- 2. ANA GUI & CANLI RGB RENK DÖNGÜSÜ
-- ------------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SelTubeV2Premium"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 620, 0, 480)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainRGB = Instance.new("UIStroke")
MainRGB.Thickness = 3
MainRGB.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainRGB.Parent = MainFrame

-- GLOBAL RGB LOOP (Tüm Nesneler Kullanır)
local currentRGB = Color3.fromRGB(255, 0, 0)
task.spawn(function()
    while true do
        for i = 0, 1, 0.004 do
            currentRGB = Color3.fromHSV(i, 0.85, 1)
            MainRGB.Color = currentRGB
            task.wait(0.015)
        end
    end
end)

-- SOL PANEL (PROFİL & BİLGİ)
local LeftPanel = Instance.new("Frame")
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
LeftPanel.Size = UDim2.new(0, 180, 1, 0)

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 16)
LeftCorner.Parent = LeftPanel

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = LeftPanel
AvatarImage.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
AvatarImage.Position = UDim2.new(0.25, 0, 0.05, 0)
AvatarImage.Size = UDim2.new(0, 90, 0, 90)
AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImage

local AvatarRGB = Instance.new("UIStroke")
AvatarRGB.Thickness = 2
AvatarRGB.Parent = AvatarImage

task.spawn(function()
    while true do
        AvatarRGB.Color = currentRGB
        task.wait(0.03)
    end
end)

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Parent = LeftPanel
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Position = UDim2.new(0.05, 0, 0.26, 0)
WelcomeLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.Text = "👑 SELTUBE V2\n" .. LocalPlayer.DisplayName
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.TextSize = 12

-- SAĞ İÇERİK SCROLL AREA
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0.31, 0, 0.1, 0)
ContentFrame.Size = UDim2.new(0.67, 0, 0.88, 0)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1100)
ContentFrame.ScrollBarThickness = 5

local UIList = Instance.new("UIListLayout")
UIList.Parent = ContentFrame
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)

-- ÜST BAŞLIK VE KAPAT BUTONU
local TitleText = Instance.new("TextLabel")
TitleText.Parent = MainFrame
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0.31, 0, 0.02, 0)
TitleText.Size = UDim2.new(0.5, 0, 0.06, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "⚡ SELTUBE V2 PREMIUM ULTRA"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 13
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 30, 60)
CloseBtn.Position = UDim2.new(0.92, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- MİNİMİZE AÇ BUTONU
local OpenGui = Instance.new("ScreenGui")
OpenGui.Name = "SelTubeV2OpenGui"
OpenGui.Parent = game.CoreGui

local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = OpenGui
OpenBtn.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
OpenBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
OpenBtn.Size = UDim2.new(0, 120, 0, 40)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Text = "👑 SelTube V2"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 12
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenBtn

local OpenRGB = Instance.new("UIStroke")
OpenRGB.Thickness = 2
OpenRGB.Parent = OpenBtn

task.spawn(function()
    while true do
        OpenRGB.Color = currentRGB
        task.wait(0.03)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_CLICK, 0.4)
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.3, true)
    task.wait(0.3)
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_OPEN, 0.4)
    OpenBtn.Visible = false
    MainFrame.Visible = true
    MainFrame:TweenSize(UDim2.new(0, 620, 0, 480), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.3, true)
end)

-- ------------------------------------------------------------------------------
-- 3. KUSURSUZ FLY ENGINE (CFrame Tabanlı Akıcı Uçuş)
-- ------------------------------------------------------------------------------
local flying = false
local flySpeed = 60
local flyConnection

local function toggleFly(state)
    flying = state
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")

    if flying then
        playSound(SOUND_POWER, 0.5)
        if humanoid then humanoid.PlatformStand = true end

        flyConnection = RunService.RenderStepped:Connect(function(delta)
            if not flying or not hrp then return end
            local camera = workspace.CurrentCamera
            local moveVector = Vector3.zero

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVector = moveVector - Vector3.new(0, 1, 0) end

            if moveVector.Magnitude > 0 then
                moveVector = moveVector.Unit
                hrp.CFrame = hrp.CFrame + (moveVector * flySpeed * delta)
            end
            hrp.Velocity = Vector3.zero
        end)
    else
        playSound(SOUND_POWER, 0.4)
        if flyConnection then flyConnection:Disconnect() end
        if humanoid then humanoid.PlatformStand = false end
        hrp.Velocity = Vector3.zero
    end
end

-- ------------------------------------------------------------------------------
-- 4. ARAYÜZ ELEMAN OLUŞTURUCULARI
-- ------------------------------------------------------------------------------
local function addToggle(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ContentFrame
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    btn.Size = UDim2.new(0.96, 0, 0, 38)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text .. " [ KAPALI ]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 230)
    btn.TextSize = 11

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Thickness = 1.5
    toggleStroke.Parent = btn

    task.spawn(function()
        while true do
            toggleStroke.Color = currentRGB
            task.wait(0.03)
        end
    end)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and " [ AÇIK ]" or " [ KAPALI ]")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(20, 20, 30)
        callback(state)
    end)
    return btn
end

local function addSlider(text, minVal, maxVal, defaultVal, callback)
    local container = Instance.new("Frame")
    container.Parent = ContentFrame
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    container.Size = UDim2.new(0.96, 0, 0, 48)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container

    local title = Instance.new("TextLabel")
    title.Parent = container
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0.05, 0, 0.1, 0)
    title.Size = UDim2.new(0.9, 0, 0.35, 0)
    title.Font = Enum.Font.GothamSemibold
    title.Text = text .. ": " .. tostring(defaultVal)
    title.TextColor3 = Color3.fromRGB(220, 220, 230)
    title.TextSize = 11
    title.TextXAlignment = Enum.TextXAlignment.Left

    local barBg = Instance.new("Frame")
    barBg.Parent = container
    barBg.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    barBg.Position = UDim2.new(0.05, 0, 0.6, 0)
    barBg.Size = UDim2.new(0.9, 0, 0, 8)

    local barFill = Instance.new("Frame")
    barFill.Parent = barBg
    barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
    barFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)

    local isDragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
        barFill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(minVal + (maxVal - minVal) * pos)
        title.Text = text .. ": " .. tostring(val)
        callback(val)
    end

    barBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
end

local function addActionButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ContentFrame
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 48)
    btn.Size = UDim2.new(0.96, 0, 0, 36)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        playSound(SOUND_CLICK, 0.4)
        callback()
    end)
end

-- ------------------------------------------------------------------------------
-- 5. DEV HİLE PAKETİ (SELTUBE V2 MODÜLLERİ)
-- ------------------------------------------------------------------------------

-- [ HAREKET & FLY ]
addToggle("🚀 Kamera Odaklı CFrame Fly", function(state) toggleFly(state) end)
addSlider("⚡ Uçuş Hızı (Fly Speed)", 10, 400, 60, function(val) flySpeed = val end)
addSlider("🏃 Yürüme Hızı (WalkSpeed)", 16, 300, 16, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
    end
end)
addSlider("🦘 Zıplama Gücü (JumpPower)", 50, 400, 50, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = val
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").UseJumpPower = true
    end
end)
addToggle("👻 Noclip (Duvar Geçme)", function(state) _G.Noclip = state end)
RunService.Stepped:Connect(function()
    if _G.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)
addToggle("🦘 Infinite Jump (Sonsuz Zıplama)", function(state) _G.InfJump = state end)
UserInputService.JumpRequest:Connect(function()
    if _G.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- [ GÖRSEL & ESP SİSTEMİ ]
addToggle("👁️ Player Highlight ESP", function(state)
    _G.ESP = state
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("SelTubeESP")
            if state then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "SelTubeESP"
                    hl.FillColor = Color3.fromRGB(255, 0, 80)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = p.Character
                end
            else
                if hl then hl:Destroy() end
            end
        end
    end
end)

addToggle("☀️ Fullbright (Aydınlatma)", function(state)
    if state then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
    else
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Lighting.Brightness = 1
    end
end)

addToggle("👤 Ghost Mode (Görünmezlik / Şeffaflık)", function(state)
    if LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = state and 0.7 or 0
            end
        end
    end
end)

-- [ COMBAT & OYUNCU ARAÇLARI ]
addToggle("🎯 Camera Lock Aimbot", function(state) _G.Aimbot = state end)
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local camera = workspace.CurrentCamera
        local closest = nil
        local dist = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (p.Character.HumanoidRootPart.Position - camera.CFrame.Position).Magnitude
                if d < dist then dist = d closest = p end
            end
        end
        if closest and closest.Character:FindFirstChild("HumanoidRootPart") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Character.HumanoidRootPart.Position)
        end
    end
end)

addActionButton("🌀 En Yakın Oyuncuya Işınlan (TP Nearest)", function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local target = nil
    local dist = math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (p.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
            if d < dist then dist = d target = p end
        end
    end
    if target and target.Character:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)

addActionButton("🎈 SpinBot / Fırıldak Modu", function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for i = 1, 50 do
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(30), 0)
            task.wait(0.01)
        end
    end
end)

addActionButton("🔄 Sunucuya Tekrar Katıl (Rejoin)", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

playSound(SOUND_OPEN, 0.6)