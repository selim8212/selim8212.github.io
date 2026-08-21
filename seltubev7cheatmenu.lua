-- ================================================
-- SelTube Ultra v7 Pro (Audio System & Toggle Button)
-- ================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- 0. SES SİSTEMİ (AUDIO SYSTEM)
local function playSound(soundId, volume)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(soundId)
    sound.Volume = volume or 0.5
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

-- Ses ID'leri
local SOUND_CLICK = 6895079853 -- Buton tıklama
local SOUND_OPEN = 9114223179   -- Menü açılış
local SOUND_POWER = 9113881268  -- Güç/Fly açma

ScreenGui.Name = "SelTubeV7"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Ana Çerçeve
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Açılış Animasyonu ve Sesi
playSound(SOUND_OPEN, 0.6)
MainFrame:TweenSize(UDim2.new(0, 330, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)

-- Başlık
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Font = Enum.Font.GothamBold
Title.Text = "🔥 SelTube Ultra v7 Pro 🔥"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- BÜYÜT / KÜÇÜLT (MINIMIZE) BUTONU
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = Title
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MinimizeBtn.Position = UDim2.new(0.73, 0, 0.15, 0)
MinimizeBtn.Size = UDim2.new(0, 32, 0, 32)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_CLICK, 0.4)
    isMinimized = not isMinimized
    if isMinimized then
        MinimizeBtn.Text = "+"
        MainFrame:TweenSize(UDim2.new(0, 330, 0, 45), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    else
        MinimizeBtn.Text = "—"
        MainFrame:TweenSize(UDim2.new(0, 330, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.3, true)
    end
end)

-- Kapatma Butonu
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Title
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Position = UDim2.new(0.85, 0, 0.15, 0)
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- 1. MENÜYÜ YENİDEN AÇMA BUTONU (OPEN TOGGLE BUTTON)
local OpenGui = Instance.new("ScreenGui")
local OpenBtn = Instance.new("TextButton")
OpenGui.Name = "SelTubeOpenGui"
OpenGui.Parent = game.CoreGui

OpenBtn.Name = "OpenButton"
OpenBtn.Parent = OpenGui
OpenBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
OpenBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
OpenBtn.Size = UDim2.new(0, 110, 0, 40)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Text = "⚡ SelTube AÇ"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 13
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Parent = OpenBtn

-- Kapatma ve Açma Mantığı
CloseBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_CLICK, 0.5)
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.3, true)
    task.wait(0.3)
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_OPEN, 0.5)
    OpenBtn.Visible = false
    MainFrame.Visible = true
    MainFrame:TweenSize(UDim2.new(0, 330, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)
end)

-- Scrolling İç Menü
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 0, 0, 50)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 480)
ScrollingFrame.ScrollBarThickness = 5

UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createButton(text)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollingFrame
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    btn.Size = UDim2.new(0.9, 0, 0, 42)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.TextSize = 13
    btn.AutoButtonColor = false

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Title.BackgroundColor3}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(28, 28, 38)}):Play()
    end)

    return btn
end

-- ÖZELLİK BUTONLARI
local FlyToggleBtn = createButton("Yönlü Uçma (WASD Fly) AÇ / KAPAT")
local SpeedBtn = createButton("Hızlandırıcı (Speed Boost): KAPALI")
local JumpBtn = createButton("Süper Zıplama: KAPALI")
local NoclipBtn = createButton("Noclip (Duvar Geçme): KAPALI")
local EspBtn = createButton("Player ESP (Wallhack): KAPALI")
local AnimDrop = createButton("Ultra Animasyon: [Tıkla]")
local ColorBtn = createButton("Neon Temayı Değiştir 🎨")

-- 2. YÖNE GÖRE UÇMA MOTORU
local FlyGui = Instance.new("ScreenGui")
local FloatingFlyBtn = Instance.new("TextButton")
FlyGui.Name = "SelTubeFlyGui"
FlyGui.Parent = game.CoreGui

FloatingFlyBtn.Name = "FlyButton"
FloatingFlyBtn.Parent = FlyGui
FloatingFlyBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
FloatingFlyBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
FloatingFlyBtn.Size = UDim2.new(0, 60, 0, 60)
FloatingFlyBtn.Font = Enum.Font.GothamBold
FloatingFlyBtn.Text = "FLY"
FloatingFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingFlyBtn.TextSize = 16
FloatingFlyBtn.Visible = false
FloatingFlyBtn.Active = true
FloatingFlyBtn.Draggable = true

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(1, 0)
FlyCorner.Parent = FloatingFlyBtn

local flying = false
local flySpeed = 50
local bodyVel, bodyGyro
local renderConnection

local function toggleFly()
    playSound(SOUND_POWER, 0.5)
    flying = not flying
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
    local hrp = char.HumanoidRootPart
    local humanoid = char.Humanoid

    if flying then
        TweenService:Create(FloatingFlyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 230, 120)}):Play()
        
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(4e5, 4e5, 4e5)
        bodyVel.Velocity = Vector3.zero
        bodyVel.Parent = hrp

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(4e5, 4e5, 4e5)
        bodyGyro.CFrame = hrp.CFrame
        bodyGyro.Parent = hrp

        humanoid.PlatformStand = true

        renderConnection = RunService.RenderStepped:Connect(function()
            if not flying or not hrp then return end
            local camera = workspace.CurrentCamera
            local moveDir = humanoid.MoveDirection
            
            local flyVector = Vector3.zero
            if moveDir.Magnitude > 0 then
                local camCFrame = camera.CFrame
                local forward = Vector3.new(camCFrame.LookVector.X, 0, camCFrame.LookVector.Z).Unit
                local right = Vector3.new(camCFrame.RightVector.X, 0, camCFrame.RightVector.Z).Unit
                flyVector = (forward * -moveDir.Z + right * moveDir.X).Unit * flySpeed
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                flyVector = flyVector + Vector3.new(0, flySpeed, 0)
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                flyVector = flyVector + Vector3.new(0, -flySpeed, 0)
            end

            bodyVel.Velocity = flyVector
            bodyGyro.CFrame = camera.CFrame
        end)
    else
        TweenService:Create(FloatingFlyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Title.BackgroundColor3}):Play()
        if renderConnection then renderConnection:Disconnect() end
        if bodyVel then bodyVel:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        humanoid.PlatformStand = false
    end
end

FlyToggleBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_CLICK, 0.4)
    FloatingFlyBtn.Visible = not FloatingFlyBtn.Visible
end)
FloatingFlyBtn.MouseButton1Click:Connect(toggleFly)

-- 3. HIZ & ZIPLAMA
local speedOn = false
SpeedBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_POWER, 0.4)
    speedOn = not speedOn
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speedOn and 60 or 16
        SpeedBtn.Text = speedOn and "Hızlandırıcı: AÇIK (60)" or "Hızlandırıcı: KAPALI"
    end
end)

local jumpOn = false
JumpBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_POWER, 0.4)
    jumpOn = not jumpOn
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = jumpOn and 120 or 50
        char.Humanoid.UseJumpPower = true
        JumpBtn.Text = jumpOn and "Süper Zıplama: AÇIK" or "Süper Zıplama: KAPALI"
    end
end)

-- 4. NOCLIP
local noclipOn = false
NoclipBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_CLICK, 0.4)
    noclipOn = not noclipOn
    NoclipBtn.Text = noclipOn and "Noclip: AÇIK" or "Noclip: KAPALI"
end)

RunService.Stepped:Connect(function()
    if noclipOn and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 5. ESP (WALLHACK)
local espOn = false
EspBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_CLICK, 0.4)
    espOn = not espOn
    EspBtn.Text = espOn and "Player ESP: AÇIK" or "Player ESP: KAPALI"
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("SelESP")
            if espOn then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "SelESP"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = p.Character
                end
            else
                if hl then hl:Destroy() end
            end
        end
    end
end)

-- 6. NEON TEMALAR
local themes = {
    {name = "Neon Kırmızı", color = Color3.fromRGB(220, 20, 60)},
    {name = "Neon Mor", color = Color3.fromRGB(140, 20, 250)},
    {name = "Cyan Mavi", color = Color3.fromRGB(0, 200, 255)},
    {name = "Matrix Yeşil", color = Color3.fromRGB(0, 255, 120)}
}
local themeIndex = 1
ColorBtn.MouseButton1Click:Connect(function()
    playSound(SOUND_CLICK, 0.4)
    themeIndex = themeIndex + 1
    if themeIndex > #themes then themeIndex = 1 end
    local theme = themes[themeIndex]
    TweenService:Create(Title, TweenInfo.new(0.3), {BackgroundColor3 = theme.color}):Play()
    TweenService:Create(OpenBtn, TweenInfo.new(0.3), {BackgroundColor3 = theme.color}):Play()
    ColorBtn.Text = "Tema: " .. theme.name .. " 🎨"
end)

-- 7. ANİMASYONLAR
local animations = {
    ["Zombie Fast Walk"] = "rbxassetid://616154732",
    ["Ninja Fast Dash"] = "rbxassetid://658872564",
    ["Float Fly (Süpermen)"] = "rbxassetid://616008087",
    ["Vampire Idle"] = "rbxassetid://1083445855",
    ["Crazy Breakdance"] = "rbxassetid://507777623"
}
local animList = {"Zombie Fast Walk", "Ninja Fast Dash", "Float Fly (Süpermen)", "Vampire Idle", "Crazy Breakdance"}
local animIndex = 1
local currentTrack = nil

AnimDrop.MouseButton1Click:Connect(function()
    playSound(SOUND_CLICK, 0.4)
    animIndex = animIndex + 1
    if animIndex > #animList then animIndex = 1 end
    local name = animList[animIndex]
    AnimDrop.Text = "Anim: " .. name
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local humanoid = char.Humanoid
        local animator = humanoid:FindFirstChildWhichIsA("Animator") or humanoid
        if currentTrack then currentTrack:Stop() end
        local animObj = Instance.new("Animation")
        animObj.AnimationId = animations[name]
        currentTrack = animator:LoadAnimation(animObj)
        currentTrack.Priority = Enum.AnimationPriority.Action4
        currentTrack:Play()
    end
end)