-- ================================================
-- SelTube Premium v4 Ultra (Animated & Neon GUI)
-- ================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyToggleBtn = Instance.new("TextButton")
local AnimDrop = Instance.new("TextButton")
local ColorBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "SelTubeV4"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Ana Çerçeve Tasarımı
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Açılış animasyonu için 0 yapıldı
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- MENÜ AÇILMA ANİMASYONU (Smooth Pop-up)
MainFrame:TweenSize(UDim2.new(0, 320, 0, 380), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)

-- Başlık
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "🔥 SelTube Ultra v4 🔥"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Buton Oluşturucu & Hover Animasyonu
local function createAnimatedBtn(text, pos)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Position = pos
    btn.Size = UDim2.new(0.86, 0, 0, 45)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.TextSize = 14
    btn.AutoButtonColor = false

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    -- Hover (Üzerine Gelme) Animasyonları
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(220, 20, 60),
            Size = UDim2.new(0.9, 0, 0, 47)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 40),
            Size = UDim2.new(0.86, 0, 0, 45)
        }):Play()
    end)

    return btn
end

FlyToggleBtn = createAnimatedBtn("Uçma Modunu Aç / Kapat", UDim2.new(0.07, 0, 0.18, 0))
AnimDrop = createAnimatedBtn("Ultra Animasyon: [Tıkla]", UDim2.new(0.07, 0, 0.35, 0))
ColorBtn = createAnimatedBtn("Neon Temayı Değiştir 🎨", UDim2.new(0.07, 0, 0.52, 0))
CloseBtn = createAnimatedBtn("Menüyü Kapat", UDim2.new(0.07, 0, 0.8, 0))

-- 1. RENK TEMALARI
local themes = {
    {name = "Neon Kırmızı", color = Color3.fromRGB(220, 20, 60)},
    {name = "Neon Mor", color = Color3.fromRGB(140, 20, 250)},
    {name = "Cyan Mavi", color = Color3.fromRGB(0, 200, 255)},
    {name = "Matrix Yeşil", color = Color3.fromRGB(0, 255, 120)}
}
local themeIndex = 1

ColorBtn.MouseButton1Click:Connect(function()
    themeIndex = themeIndex + 1
    if themeIndex > #themes then themeIndex = 1 end
    
    local theme = themes[themeIndex]
    TweenService:Create(Title, TweenInfo.new(0.3), {BackgroundColor3 = theme.color}):Play()
    ColorBtn.Text = "Tema: " .. theme.name .. " 🎨"
end)

-- 2. ANIMASYONLU FLY BUTONU
local FlyGui = Instance.new("ScreenGui")
local FloatingFlyBtn = Instance.new("TextButton")

FlyGui.Name = "SelTubeFlyGui"
FlyGui.Parent = game.CoreGui

FloatingFlyBtn.Name = "FlyButton"
FloatingFlyBtn.Parent = FlyGui
FloatingFlyBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
FloatingFlyBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
FloatingFlyBtn.Size = UDim2.new(0, 65, 0, 65)
FloatingFlyBtn.Font = Enum.Font.GothamBold
FloatingFlyBtn.Text = "FLY"
FloatingFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingFlyBtn.TextSize = 18
FloatingFlyBtn.Visible = false
FloatingFlyBtn.Active = true
FloatingFlyBtn.Draggable = true

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(1, 0) -- Yuvarlak buton
FlyCorner.Parent = FloatingFlyBtn

local flying = false
local speed = 65
local bodyVel, bodyGyro

local function toggleFly()
    flying = not flying
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    if flying then
        TweenService:Create(FloatingFlyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 230, 120)}):Play()
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(4e5, 4e5, 4e5)
        bodyVel.Velocity = Vector3.new(0, 0.1, 0)
        bodyVel.Parent = char.HumanoidRootPart
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(4e5, 4e5, 4e5)
        bodyGyro.CFrame = char.HumanoidRootPart.CFrame
        bodyGyro.Parent = char.HumanoidRootPart
        
        task.spawn(function()
            while flying do
                task.wait()
                bodyVel.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            end
        end)
    else
        TweenService:Create(FloatingFlyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Title.BackgroundColor3}):Play()
        if bodyVel then bodyVel:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    end
end

FlyToggleBtn.MouseButton1Click:Connect(function()
    FloatingFlyBtn.Visible = not FloatingFlyBtn.Visible
end)
FloatingFlyBtn.MouseButton1Click:Connect(toggleFly)

-- 3. 100x COOLER ULTRA R15 ANİMASYONLAR
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

-- Kapanış Animasyonu
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.4, true)
    task.wait(0.4)
    ScreenGui:Destroy()
    FlyGui:Destroy()
end)