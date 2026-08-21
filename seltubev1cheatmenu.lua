-- ==============================================================================
-- 🔥 SELTUBE PREMIUM v1 (NO KEY - AVATAR & ADVANCED UI ENGINE) 🔥
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- ------------------------------------------------------------------------------
-- 1. SES & BİLDİRİM SİSTEMİ (AUDIO & NOTIFICATION SYSTEM)
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

local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "SelTubeNotificationGui"
NotificationGui.Parent = game.CoreGui

local NotifContainer = Instance.new("Frame")
NotifContainer.Parent = NotificationGui
NotifContainer.BackgroundTransparency = 1
NotifContainer.Position = UDim2.new(0.8, 0, 0.5, 0)
NotifContainer.Size = UDim2.new(0.2, -10, 0.45, 0)

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.Parent = NotifContainer
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 8)

local function showNotification(titleText, descText, duration)
    task.spawn(function()
        local card = Instance.new("Frame")
        card.Parent = NotifContainer
        card.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        card.Size = UDim2.new(1, 0, 0, 60)
        card.ClipsDescendants = true
        card.Transparency = 1

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = card

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1.5
        stroke.Color = Color3.fromRGB(255, 0, 80)
        stroke.Parent = card

        local title = Instance.new("TextLabel")
        title.Parent = card
        title.BackgroundTransparency = 1
        title.Position = UDim2.new(0.05, 0, 0.1, 0)
        title.Size = UDim2.new(0.9, 0, 0.35, 0)
        title.Font = Enum.Font.GothamBold
        title.Text = titleText
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 13
        title.TextXAlignment = Enum.TextXAlignment.Left

        local desc = Instance.new("TextLabel")
        desc.Parent = card
        desc.BackgroundTransparency = 1
        desc.Position = UDim2.new(0.05, 0, 0.45, 0)
        desc.Size = UDim2.new(0.9, 0, 0.45, 0)
        desc.Font = Enum.Font.Gotham
        desc.Text = descText
        desc.TextColor3 = Color3.fromRGB(180, 180, 190)
        desc.TextSize = 11
        desc.TextXAlignment = Enum.TextXAlignment.Left

        TweenService:Create(card, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        playSound(SOUND_CLICK, 0.3)

        task.wait(duration or 3)
        TweenService:Create(card, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        card:Destroy()
    end)
end

-- ------------------------------------------------------------------------------
-- 2. ANA EKRAN & AÇILIŞ LOADING ANIMASYONU
-- ------------------------------------------------------------------------------
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "SelTubePremiumV1"
MainGui.Parent = game.CoreGui
MainGui.ResetOnSpawn = false

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = MainGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
LoadingFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
LoadingFrame.Size = UDim2.new(0, 380, 0, 220)
LoadingFrame.ClipsDescendants = true

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 14)
LoadCorner.Parent = LoadingFrame

local LoadStroke = Instance.new("UIStroke")
LoadStroke.Thickness = 2
LoadStroke.Color = Color3.fromRGB(255, 0, 80)
LoadStroke.Parent = LoadingFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Parent = LoadingFrame
LoadTitle.BackgroundTransparency = 1
LoadTitle.Position = UDim2.new(0, 0, 0.15, 0)
LoadTitle.Size = UDim2.new(1, 0, 0, 35)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = "⚡ SELTUBE PREMIUM v1 ⚡"
LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadTitle.TextSize = 18

local LoadStatus = Instance.new("TextLabel")
LoadStatus.Parent = LoadingFrame
LoadStatus.BackgroundTransparency = 1
LoadStatus.Position = UDim2.new(0, 0, 0.45, 0)
LoadStatus.Size = UDim2.new(1, 0, 0, 25)
LoadStatus.Font = Enum.Font.GothamSemibold
LoadStatus.Text = "Sistem Modülleri Yükleniyor..."
LoadStatus.TextColor3 = Color3.fromRGB(150, 150, 170)
LoadStatus.TextSize = 12

local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingFrame
BarBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
BarBackground.Position = UDim2.new(0.1, 0, 0.7, 0)
BarBackground.Size = UDim2.new(0.8, 0, 0, 10)

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = BarBackground

local BarFill = Instance.new("Frame")
BarFill.Parent = BarBackground
BarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
BarFill.Size = UDim2.new(0, 0, 1, 0)

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = BarFill

-- Loading Animasyonu Döngüsü
playSound(SOUND_OPEN, 0.6)
TweenService:Create(BarFill, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()

task.spawn(function()
    local steps = {"Veriler Doğrulanıyor...", "Profil Resmi Çekiliyor...", "Modüller Enjekte Ediliyor...", "Hazır!"}
    for i, stepText in ipairs(steps) do
        LoadStatus.Text = stepText
        task.wait(0.5)
    end
    task.wait(0.2)
    LoadingFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.4, true)
    task.wait(0.4)
    LoadingFrame:Destroy()
end)

-- ------------------------------------------------------------------------------
-- 3. ANA HUB PENCERESİ VE AVATAR SİSTEMİ
-- ------------------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.28, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 420)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

task.delay(2.6, function()
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame:TweenSize(UDim2.new(0, 520, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
    showNotification("SelTube Premium", "Başarıyla Yüklendi! Hoş geldin " .. LocalPlayer.DisplayName, 4)
end)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local RGBStroke = Instance.new("UIStroke")
RGBStroke.Thickness = 2
RGBStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RGBStroke.Parent = MainFrame

task.spawn(function()
    while true do
        for i = 0, 1, 0.005 do
            RGBStroke.Color = Color3.fromHSV(i, 0.8, 1)
            task.wait(0.03)
        end
    end
end)

-- SOL PANEL (PROFİL VE SEKMELER)
local LeftPanel = Instance.new("Frame")
LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
LeftPanel.Size = UDim2.new(0, 160, 1, 0)

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 14)
LeftCorner.Parent = LeftPanel

-- OYUNCU PROFİL SİMGESİ (AVATAR THUMBNAIL)
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Name = "AvatarImage"
AvatarImage.Parent = LeftPanel
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
AvatarImage.Position = UDim2.new(0.25, 0, 0.06, 0)
AvatarImage.Size = UDim2.new(0, 80, 0, 80)
AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImage

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Thickness = 2
AvatarStroke.Color = Color3.fromRGB(255, 0, 80)
AvatarStroke.Parent = AvatarImage

-- HOŞ GELDİN YAZISI
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Name = "WelcomeLabel"
WelcomeLabel.Parent = LeftPanel
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Position = UDim2.new(0.05, 0, 0.28, 0)
WelcomeLabel.Size = UDim2.new(0.9, 0, 0.08, 0)
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.Text = "Hoş geldin,\n" .. LocalPlayer.DisplayName .. "!"
WelcomeLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
WelcomeLabel.TextSize = 11
WelcomeLabel.TextWrapped = true

-- SEKME BUTONLARI KONTEYNERİ
local TabContainer = Instance.new("Frame")
TabContainer.Parent = LeftPanel
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 0, 0.38, 0)
TabContainer.Size = UDim2.new(1, 0, 0.6, 0)

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabContainer
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- SAĞ PANEL (İÇERİK ALANI)
local RightPanel = Instance.new("Frame")
RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundTransparency = 1
RightPanel.Position = UDim2.new(0.31, 0, 0.1, 0)
RightPanel.Size = UDim2.new(0.68, 0, 0.88, 0)

-- ÜST BAŞLIK & KONTROL BUTONLARI
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundTransparency = 1
Header.Position = UDim2.new(0.31, 0, 0, 0)
Header.Size = UDim2.new(0.68, 0, 0.1, 0)

local TitleText = Instance.new("TextLabel")
TitleText.Parent = Header
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 0, 0.2, 0)
TitleText.Size = UDim2.new(0.7, 0, 0.6, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "👑 SELTUBE PREMIUM"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 50)
CloseBtn.Position = UDim2.new(0.85, 0, 0.2, 0)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- MENÜYÜ GİZLE / AÇ BUTONU
local OpenGui = Instance.new("ScreenGui")
OpenGui.Name = "SelTubeOpenGui"
OpenGui.Parent = game.CoreGui

local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = OpenGui
OpenBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
OpenBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
OpenBtn.Size = UDim2.new(0, 120, 0, 42)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Text = "⚡ SelTube AÇ"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 12
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

task.spawn(function()
    while true do
        for i = 0, 1, 0.005 do
            OpenStroke.Color = Color3.fromHSV(i, 0.8, 1)
            task.wait(0.03)
        end
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
    MainFrame:TweenSize(UDim2.new(0, 520, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)
end)

-- ------------------------------------------------------------------------------
-- 4. SEKME (TAB) SİSTEMİ MOTORU
-- ------------------------------------------------------------------------------
local tabs = {}
local currentTab = nil

local function createTab(tabName, iconText)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Parent = TabContainer
    tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 36)
    tabBtn.Size = UDim2.new(0.88, 0, 0, 36)
    tabBtn.Font = Enum.Font.GothamSemibold
    tabBtn.Text = (iconText or "📌") .. " " .. tabName
    tabBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
    tabBtn.TextSize = 11

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = tabBtn

    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Parent = RightPanel
    tabFrame.BackgroundTransparency = 1
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
    tabFrame.ScrollBarThickness = 4
    tabFrame.Visible = false

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = tabFrame
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 8)

    tabBtn.MouseButton1Click:Connect(function()
        playSound(SOUND_CLICK, 0.3)
        for _, t in pairs(tabs) do
            t.Frame.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(25, 25, 36)
            t.Button.TextColor3 = Color3.fromRGB(160, 160, 180)
        end
        tabFrame.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        currentTab = tabFrame
    end)

    table.insert(tabs, {Button = tabBtn, Frame = tabFrame})
    
    if #tabs == 1 then
        tabFrame.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        currentTab = tabFrame
    end

    return tabFrame
end

-- UI ELAMAN OLUŞTURUCULARI (TOGGLE, SLIDER, BUTTON)
local function addToggle(parentTab, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parentTab
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    btn.Size = UDim2.new(0.96, 0, 0, 40)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text .. " [ KAPALI ]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 230)
    btn.TextSize = 11
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local state = false
    btn.MouseButton1Click:Connect(function()
        playSound(SOUND_POWER, 0.4)
        state = not state
        btn.Text = text .. (state and " [ AÇIK ]" or " [ KAPALI ]")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(22, 22, 32)
        callback(state)
    end)
    return btn
end

local function addSlider(parentTab, text, minVal, maxVal, defaultVal, callback)
    local container = Instance.new("Frame")
    container.Parent = parentTab
    container.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    container.Size = UDim2.new(0.96, 0, 0, 50)

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

-- ------------------------------------------------------------------------------
-- 5. SEKMELER & ÖZELLİKLER (FEATURES ENGINE)
-- ------------------------------------------------------------------------------

local mainTab = createTab("Ana Özellikler", "⚡")
local espTab = createTab("Görsel & ESP", "👁️")
local moveTab = createTab("Hareket & Fly", "🚀")
local serverTab = createTab("Sunucu Araçları", "🌐")

-- --- ANA ÖZELLİKLER ---
local walkSpeed = 16
addSlider(mainTab, "Yürüme Hızı (WalkSpeed)", 16, 250, 16, function(val)
    walkSpeed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

local jumpPower = 50
addSlider(mainTab, "Zıplama Gücü (JumpPower)", 50, 300, 50, function(val)
    jumpPower = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
        LocalPlayer.Character.Humanoid.UseJumpPower = true
    end
end)

addToggle(mainTab, "Noclip (Duvar Geçme)", function(state)
    _G.Noclip = state
    showNotification("Noclip", state and "Aktif Edildi!" or "Devre Dışı!", 2)
end)

RunService.Stepped:Connect(function()
    if _G.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

addToggle(mainTab, "Sonsuz Zıplama (Infinite Jump)", function(state)
    _G.InfJump = state
end)

UserInputService.JumpRequest:Connect(function()
    if _G.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- --- GÖRSEL & ESP ---
addToggle(espTab, "Player Highlight ESP", function(state)
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

-- --- HAREKET & WASD FLY ---
local flySpeed = 50
addSlider(moveTab, "Uçuş Hızı (Fly Speed)", 20, 300, 50, function(val)
    flySpeed = val
end)

local FlyGui = Instance.new("ScreenGui")
FlyGui.Name = "SelTubeFlyGui"
FlyGui.Parent = game.CoreGui

local FloatingFlyBtn = Instance.new("TextButton")
FloatingFlyBtn.Parent = FlyGui
FloatingFlyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
FloatingFlyBtn.Position = UDim2.new(0.08, 0, 0.5, 0)
FloatingFlyBtn.Size = UDim2.new(0, 55, 0, 55)
FloatingFlyBtn.Font = Enum.Font.GothamBold
FloatingFlyBtn.Text = "FLY"
FloatingFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingFlyBtn.TextSize = 14
FloatingFlyBtn.Visible = false
FloatingFlyBtn.Active = true
FloatingFlyBtn.Draggable = true

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(1, 0)
FlyCorner.Parent = FloatingFlyBtn

local flying = false
local bodyVel, bodyGyro, renderConnection

local function toggleFly()
    flying = not flying
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
    local hrp = char.HumanoidRootPart
    local humanoid = char.Humanoid

    if flying then
        FloatingFlyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
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
        FloatingFlyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
        if renderConnection then renderConnection:Disconnect() end
        if bodyVel then bodyVel:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        humanoid.PlatformStand = false
    end
end

addToggle(moveTab, "Yönlü WASD / Mobil Fly", function(state)
    FloatingFlyBtn.Visible = state
end)
FloatingFlyBtn.MouseButton1Click:Connect(toggleFly)

-- --- SUNUCU ARAÇLARI ---
local rejoining = false
local function addBtn(tab, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = tab
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    btn.Size = UDim2.new(0.96, 0, 0, 38)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 230)
    btn.TextSize = 11

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        playSound(SOUND_CLICK, 0.4)
        callback()
    end)
end

addBtn(serverTab, "Tekrar Katıl (Rejoin Server)", function()
    if not rejoining then
        rejoining = true
        showNotification("Sunucu", "Tekrar bağlanılıyor...", 3)
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

addBtn(serverTab, "Sunucuyu Kopyala (Copy Server ID)", function()
    setclipboard(tostring(game.JobId))
    showNotification("Panoya Kopyalandı", "Job ID başarıyla kopyalandı!", 2)
end)