-- // Services \\ --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Global Renk Ayarı (Varsayılan Mavi: 0, 170, 255)
local CurrentThemeColor = Color3.fromRGB(0, 170, 255)
local themedElements = {}

local function registerThemed(element, isText)
    table.insert(themedElements, {Instance = element, IsText = isText})
end

local function updateTheme(newColor)
    CurrentThemeColor = newColor
    for _, item in ipairs(themedElements) do
        if item.Instance and item.Instance.Parent then
            if item.IsText then
                item.Instance.TextColor3 = newColor
            else
                item.Instance.BackgroundColor3 = newColor
            end
        end
    end
end

-- // 1. LOADING SCREEN (Yükleme Ekranı) \\ --
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "SelimLoad"
LoadGui.Parent = CoreGui
LoadGui.ResetOnSpawn = false

local LoadFrame = Instance.new("Frame")
LoadFrame.Parent = LoadGui
LoadFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LoadFrame.BorderSizePixel = 0
LoadFrame.Position = UDim2.new(0.5, -175, 0.5, -60)
LoadFrame.Size = UDim2.new(0, 350, 0, 120)

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 8)
LoadCorner.Parent = LoadFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Parent = LoadFrame
LoadTitle.BackgroundTransparency = 1
LoadTitle.Position = UDim2.new(0, 0, 0, 15)
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = "Selim's Classic Menu 1.0 Yükleniyor..."
LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadTitle.TextSize = 15

local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadFrame
BarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BarBackground.BorderSizePixel = 0
BarBackground.Position = UDim2.new(0.1, 0, 0, 65)
BarBackground.Size = UDim2.new(0.8, 0, 0, 15)

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(0, 4)
BarBgCorner.Parent = BarBackground

local LoadBar = Instance.new("Frame")
LoadBar.Parent = BarBackground
LoadBar.BackgroundColor3 = CurrentThemeColor
LoadBar.BorderSizePixel = 0
LoadBar.Size = UDim2.new(0, 0, 1, 0)
registerThemed(LoadBar, false)

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 4)
BarCorner.Parent = LoadBar

TweenService:Create(LoadBar, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(2.2)
LoadGui:Destroy()

-- // 2. ANA GUI & PENCERE TASARIMI \\ --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SelimClassicMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Active = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Program Barı (Title Bar)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.Active = true

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TopBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Size = UDim2.new(0, 250, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Selim's Classic Menu 1.0"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Pencere Kontrol Yazılı Butonlar (Küçült & Kapat)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CloseBtn.Position = UDim2.new(1, -75, 0, 0)
CloseBtn.Size = UDim2.new(0, 75, 1, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "Kapat"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 13

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TopBar
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MinBtn.Position = UDim2.new(1, -150, 0, 0)
MinBtn.Size = UDim2.new(0, 75, 1, 0)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "Küçült"
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.TextSize = 13

CloseBtn.MouseEnter:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(232, 17, 35) CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20) CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200) end)
MinBtn.MouseEnter:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end)
MinBtn.MouseLeave:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20) end)

-- Open Menu Butonu
local OpenButton = Instance.new("TextButton")
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Position = UDim2.new(0, 10, 0.5, -25)
OpenButton.Size = UDim2.new(0, 110, 0, 42)
OpenButton.Visible = false
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Text = "Selim's Menu"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 13
OpenButton.Active = true
OpenButton.Draggable = true

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 6)
OpenCorner.Parent = OpenButton

-- // SOL SEKMELER PANELİ \\ --
local TabBar = Instance.new("ScrollingFrame")
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabBar.BorderSizePixel = 0
TabBar.Position = UDim2.new(0, 0, 0, 38)
TabBar.Size = UDim2.new(0, 130, 1, -38)
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.ScrollBarThickness = 2

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabBar
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

-- // SAĞ İÇERİK PANELİ \\ --
local Container = Instance.new("Frame")
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 140, 0, 48)
Container.Size = UDim2.new(1, -150, 1, -58)

local pages = {}
local tabButtons = {}

function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13
    
    local page = Instance.new("ScrollingFrame")
    page.Parent = Container
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 2.5, 0)
    page.ScrollBarThickness = 4
    page.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, b in pairs(tabButtons) do b.BackgroundColor3 = Color3.fromRGB(35, 35, 35) b.TextColor3 = Color3.fromRGB(200, 200, 200) end
        page.Visible = true
        btn.BackgroundColor3 = CurrentThemeColor
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    table.insert(pages, page)
    table.insert(tabButtons, btn)
    registerThemed(btn, false)
    return page
end

-- Sekmeleri Oluştur
local MovementTab = CreateTab("Movement")
local CombatTab = CreateTab("Combat & Troll")
local VisualsTab = CreateTab("Visuals")
local MusicTab = CreateTab("Music Player")
local MiscTab = CreateTab("Misc & Extra")
local ScriptLoaderTab = CreateTab("Script Loader")
local SettingsTab = CreateTab("Ayarlar")
local AboutTab = CreateTab("Hakkında")

-- İlk seçeneği aktif et
pages[1].Visible = true
tabButtons[1].BackgroundColor3 = CurrentThemeColor
tabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)

-- Yardımcı Fonksiyonlar
function AddButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    local corner = Instance.new("UICorner", btn) corner.CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

function AddTextBox(parent, placeholder, callback)
    local box = Instance.new("TextBox")
    box.Parent = parent
    box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    box.Size = UDim2.new(1, -10, 0, 35)
    box.Font = Enum.Font.GothamSemibold
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderColor3 = Color3.fromRGB(160, 160, 160)
    box.TextSize = 13
    local corner = Instance.new("UICorner", box) corner.CornerRadius = UDim.new(0, 6)
    box.FocusLost:Connect(function(enter) if enter then callback(box.Text) end end)
    return box
end

-- Sürüklenebilirlik
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Küçült: Menüyü gizler, sol tarafa açma butonu getirir
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

-- Kapat: Menüyü tamamen yok eder (destroy)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    if FlyControlGui then FlyControlGui:Destroy() end
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

-- Fly Kontrol Paneli (İleri / Geri / Yukarı / Aşağı Tuşları)
local FlyControlGui = Instance.new("ScreenGui", CoreGui)
FlyControlGui.Name = "FlyControlGui"
FlyControlGui.Enabled = false
FlyControlGui.ResetOnSpawn = false

-- İleri Gitme Tuşu (W mantığı)
local ForwardBtn = Instance.new("TextButton", FlyControlGui)
ForwardBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ForwardBtn.Position = UDim2.new(1, -140, 0.6, -60)
ForwardBtn.Size = UDim2.new(0, 50, 0, 50)
ForwardBtn.Font = Enum.Font.GothamBold ForwardBtn.Text = "⬆" ForwardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ForwardBtn).CornerRadius = UDim.new(0, 25)

-- Geri Gitme Tuşu (S mantığı)
local BackwardBtn = Instance.new("TextButton", FlyControlGui)
BackwardBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
BackwardBtn.Position = UDim2.new(1, -140, 0.6, 60)
BackwardBtn.Size = UDim2.new(0, 50, 0, 50)
BackwardBtn.Font = Enum.Font.GothamBold BackwardBtn.Text = "⬇" BackwardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", BackwardBtn).CornerRadius = UDim.new(0, 25)

-- Yukarı Çıkma Tuşu
local UpBtn = Instance.new("TextButton", FlyControlGui)
UpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
UpBtn.Position = UDim2.new(1, -80, 0.6, 0)
UpBtn.Size = UDim2.new(0, 50, 0, 50)
UpBtn.Font = Enum.Font.GothamBold UpBtn.Text = "▲" UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0, 25)

-- Aşağı İnme Tuşu
local DownBtn = Instance.new("TextButton", FlyControlGui)
DownBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
DownBtn.Position = UDim2.new(1, -80, 0.6, 60)
DownBtn.Size = UDim2.new(0, 50, 0, 50)
DownBtn.Font = Enum.Font.GothamBold DownBtn.Text = "▼" DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0, 25)

local flyingForward, flyingBackward, flyingUp, flyingDown = false, false, false, false
ForwardBtn.MouseButton1Down:Connect(function() flyingForward = true end) ForwardBtn.MouseButton1Up:Connect(function() flyingForward = false end)
BackwardBtn.MouseButton1Down:Connect(function() flyingBackward = true end) BackwardBtn.MouseButton1Up:Connect(function() flyingBackward = false end)
UpBtn.MouseButton1Down:Connect(function() flyingUp = true end) UpBtn.MouseButton1Up:Connect(function() flyingUp = false end)
DownBtn.MouseButton1Down:Connect(function() flyingDown = true end) DownBtn.MouseButton1Up:Connect(function() flyingDown = false end)


-- // HİLELER VE ÖZELLİKLER \\ --

-- 1. MOVEMENT
local FlyBtn = AddButton(MovementTab, "Fly (Mobil/PC Uçuş): OFF", function() end)
local flying = false local flySpeed = 50 local bg, bv
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
    FlyBtn.BackgroundColor3 = flying and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if flying then registerThemed(FlyBtn, false) end
    FlyControlGui.Enabled = flying
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if flying then
        if humanoid then humanoid.PlatformStand = true end
        bv = Instance.new("BodyVelocity", rootPart) bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge) bv.Velocity = Vector3.new(0,0,0)
        bg = Instance.new("BodyGyro", rootPart) bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge) bg.CFrame = rootPart.CFrame
        task.spawn(function()
            while flying do
                RunService.RenderStepped:Wait()
                local moveDir = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) or flyingForward then moveDir = moveDir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) or flyingBackward then moveDir = moveDir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) or flyingUp then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or flyingDown then moveDir = moveDir - Vector3.new(0, 1, 0) end
                bv.Velocity = moveDir * flySpeed bg.CFrame = Camera.CFrame
            end
        end)
    else
        if humanoid then humanoid.PlatformStand = false end
        if bv then bv:Destroy() end if bg then bg:Destroy() end
    end
end)

-- Airwalk Özelliği
local AirwalkBtn = AddButton(MovementTab, "Airwalk (Havada Yürüme): OFF", function() end)
local airwalkActive = false local airwalkPart = nil
AirwalkBtn.MouseButton1Click:Connect(function()
    airwalkActive = not airwalkActive
    AirwalkBtn.Text = airwalkActive and "Airwalk: ON" or "Airwalk: OFF"
    AirwalkBtn.BackgroundColor3 = airwalkActive and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if airwalkActive then
        registerThemed(AirwalkBtn, false)
        airwalkPart = Instance.new("Part", Workspace)
        airwalkPart.Name = "AirwalkPlatform"
        airwalkPart.Size = Vector3.new(4, 1, 4)
        airwalkPart.Transparency = 1
        airwalkPart.Anchored = true
        airwalkPart.CanCollide = true
        task.spawn(function()
            while airwalkActive do
                RunService.RenderStepped:Wait()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and airwalkPart then
                    local root = char.HumanoidRootPart
                    airwalkPart.CFrame = root.CFrame - Vector3.new(0, 3.5, 0)
                end
            end
            if airwalkPart then airwalkPart:Destroy() airwalkPart = nil end
        end)
    else
        if airwalkPart then airwalkPart:Destroy() airwalkPart = nil end
    end
end)

local BhopBtn = AddButton(MovementTab, "Bunny Hop: OFF", function() end)
local bhopActive = false
BhopBtn.MouseButton1Click:Connect(function()
    bhopActive = not bhopActive
    BhopBtn.Text = bhopActive and "Bunny Hop: ON" or "Bunny Hop: OFF"
    BhopBtn.BackgroundColor3 = bhopActive and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if bhopActive then registerThemed(BhopBtn, false) end
    task.spawn(function()
        while bhopActive do
            RunService.RenderStepped:Wait()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                local humanoid = char.Humanoid
                if humanoid.FloorMaterial ~= Enum.Material.Air then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end
    end)
end)

local NoGravBtn = AddButton(MovementTab, "No Gravity (Yerçekimi Yok): OFF", function() end)
local noGravActive = false
NoGravBtn.MouseButton1Click:Connect(function()
    noGravActive = not noGravActive
    NoGravBtn.Text = noGravActive and "No Gravity: ON" or "No Gravity: OFF"
    NoGravBtn.BackgroundColor3 = noGravActive and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if noGravActive then registerThemed(NoGravBtn, false) end
    Workspace.Gravity = noGravActive and 0 or 196.2
end)

local NoclipBtn = AddButton(MovementTab, "Noclip: OFF", function() end)
local noclipActive = false local noclipConn
NoclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    NoclipBtn.Text = noclipActive and "Noclip: ON" or "Noclip: OFF"
    NoclipBtn.BackgroundColor3 = noclipActive and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if noclipActive then
        registerThemed(NoclipBtn, false)
        noclipConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    else if noclipConn then noclipConn:Disconnect() end end
end)

AddTextBox(MovementTab, "Hız Ayarla (Örn: 50)", function(val)
    local spd = tonumber(val)
    if spd and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = spd
    end
end)

AddTextBox(MovementTab, "Zıplama Gücü (Örn: 100)", function(val)
    local jmp = tonumber(val)
    if jmp and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = jmp
    end
end)


-- 2. COMBAT & TROLL
local GodBtn = AddButton(CombatTab, "GodMode (Ölümsüzlük): OFF", function() end)
local godActive, godConn = false, nil
GodBtn.MouseButton1Click:Connect(function()
    godActive = not godActive
    GodBtn.Text = godActive and "GodMode: ON" or "GodMode: OFF"
    GodBtn.BackgroundColor3 = godActive and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if godActive then
        registerThemed(GodBtn, false)
        godConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then char.Humanoid.Health = char.Humanoid.MaxHealth end
        end)
    else if godConn then godConn:Disconnect() end end
end)

local SpinBtn = AddButton(CombatTab, "Spin (Dönme): OFF", function() end)
local spinActive = false
SpinBtn.MouseButton1Click:Connect(function()
    spinActive = not spinActive
    SpinBtn.Text = spinActive and "Spin: ON" or "Spin: OFF"
    SpinBtn.BackgroundColor3 = spinActive and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if spinActive then registerThemed(SpinBtn, false) end
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if spinActive and root then
        local att = Instance.new("Attachment", root) local av = Instance.new("AngularVelocity", root)
        av.Attachment0 = att av.AngularVelocity = Vector3.new(0, 50, 0) av.MaxTorque = math.huge
        task.spawn(function() while spinActive do task.wait() end av:Destroy() att:Destroy() end)
    end
end)

local TpBox = AddTextBox(CombatTab, "Işınlanılacak Kişi (İsim)", function() end)
AddButton(CombatTab, "Kişiye Işınlan", function()
    local targetName = TpBox.Text:lower()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Name:lower():sub(1, #targetName) == targetName then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
end)

-- Gelişmiş Morph / Saç, Gözlük, Kıyafet Dahil Avatar Kopyalama Özelliği
local MorphBox = AddTextBox(CombatTab, "Morph Olunacak Kişi (İsim)", function() end)
AddButton(CombatTab, "Kişinin Avatarına Dönüş (Morph)", function()
    local targetName = MorphBox.Text:lower()
    local targetPlayer = nil
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Name:lower():sub(1, #targetName) == targetName then
            targetPlayer = player
            break
        end
    end
    
    if targetPlayer and targetPlayer.Character and LocalPlayer.Character then
        local myChar = LocalPlayer.Character
        local targetChar = targetPlayer.Character
        
        -- Kendi üzerimizdeki saç, aksesuar, kıyafet ve gövde kalıplarını temizle
        for _, v in ipairs(myChar:GetChildren()) do
            if v:IsA("Accessory") or v:IsA("Clothing") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                v:Destroy()
            end
        end
        
        -- Hedef oyuncunun tüm aksesuarlarını (saç, gözlük, şapka vb.), kıyafetlerini ve renklerini kopyala
        for _, v in ipairs(targetChar:GetChildren()) do
            if v:IsA("Accessory") or v:IsA("Clothing") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                v:Clone().Parent = myChar
            end
        end
        
        -- Eğer R15 veya R6 model kıyafet değişimlerinde parça kalırsa diye HumanoidDescription desteği
        local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
        local myHumanoid = myChar:FindFirstChildOfClass("Humanoid")
        if targetHumanoid and myHumanoid then
            local success, desc = pcall(function() return targetHumanoid:GetAppliedDescription() end)
            if success and desc then
                pcall(function() myHumanoid:ApplyDescription(desc) end)
            end
        end
    end
end)


-- 3. VISUALS
local EspBtn = AddButton(VisualsTab, "ESP: OFF", function() end)
local espActive = false local espConns = {}
EspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    EspBtn.Text = espActive and "ESP: ON" or "ESP: OFF"
    EspBtn.BackgroundColor3 = espActive and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if espActive then registerThemed(EspBtn, false) end
    if not espActive then
        for _, c in ipairs(espConns) do c:Disconnect() end espConns = {}
        for _, p in ipairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local function apply(c)
                    if not c:FindFirstChild("Highlight") then
                        local hl = Instance.new("Highlight", c) hl.FillColor = Color3.fromRGB(255, 0, 0) hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    end
                end
                if p.Character then apply(p.Character) end
                table.insert(espConns, p.CharacterAdded:Connect(apply))
            end
        end
    end
end)

local FullbrightBtn = AddButton(VisualsTab, "Fullbright (Aydınlık): OFF", function() end)
local fbActive = false
FullbrightBtn.MouseButton1Click:Connect(function()
    fbActive = not fbActive
    FullbrightBtn.Text = fbActive and "Fullbright: ON" or "Fullbright: OFF"
    FullbrightBtn.BackgroundColor3 = fbActive and CurrentThemeColor or Color3.fromRGB(45, 45, 45)
    if fbActive then registerThemed(FullbrightBtn, false) end
    Lighting.Brightness = fbActive and 2 or 1 Lighting.ClockTime = fbActive and 14 or 12 Lighting.GlobalShadows = not fbActive
end)


-- 4. MUSIC PLAYER
local currentMusic = nil
AddTextBox(MusicTab, "Şarkı ID Gir (Örn: 1837879086)", function(idText)
    local id = tonumber(idText)
    if id then
        if currentMusic then currentMusic:Destroy() end
        currentMusic = Instance.new("Sound")
        currentMusic.SoundId = "rbxassetid://" .. tostring(id)
        currentMusic.Volume = 1
        currentMusic.Looped = true
        currentMusic.Parent = CoreGui
        currentMusic:Play()
    end
end)

AddTextBox(MusicTab, "Ses Seviyesi (0 - 100)", function(volText)
    local vol = tonumber(volText)
    if vol and currentMusic then currentMusic.Volume = math.clamp(vol, 0, 100) end
end)

AddButton(MusicTab, "Müziği Durdur", function()
    if currentMusic then currentMusic:Stop() currentMusic:Destroy() currentMusic = nil end
end)


-- 5. MISC & EXTRA
AddButton(MiscTab, "Sit (Otur)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.Sit = true
    end
end)

AddButton(MiscTab, "Btools (Silme Aracı)", function()
    local tool = Instance.new("Tool", LocalPlayer.Backpack) tool.Name = "DeleteTool" tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse() if mouse.Target then mouse.Target:Destroy() end
    end)
end)


-- 6. SCRIPT LOADER
local scriptUrlBox = AddTextBox(ScriptLoaderTab, "https://example.com/script.lua", function() end)
AddButton(ScriptLoaderTab, "Scripti Load Et (Çalıştır)", function()
    local url = scriptUrlBox.Text
    if url and url ~= "" then
        local success, result = pcall(function() return game:HttpGet(url) end)
        if success then
            local fn, err = loadstring(result)
            if fn then pcall(fn) else warn("Loadstring hatası: " .. tostring(err)) end
        else warn("URL'den veri çekilemedi: " .. tostring(result)) end
    end
end)


-- 7. AYARLAR SEKMESİ (Tuş Renklerini Değiştirme)
local themeLabel = Instance.new("TextLabel", SettingsTab)
themeLabel.BackgroundTransparency = 1
themeLabel.Size = UDim2.new(1, -10, 0, 30)
themeLabel.Font = Enum.Font.GothamBold
themeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
themeLabel.TextSize = 13
themeLabel.TextXAlignment = Enum.TextXAlignment.Left
themeLabel.Text = "  Menü Tema Rengini Değiştir:"

AddButton(SettingsTab, "Mavi Tema (Varsayılan)", function()
    updateTheme(Color3.fromRGB(0, 170, 255))
end)

AddButton(SettingsTab, "Kırmızı Tema", function()
    updateTheme(Color3.fromRGB(232, 17, 35))
end)

AddButton(SettingsTab, "Yeşil Tema", function()
    updateTheme(Color3.fromRGB(0, 200, 80))
end)

AddButton(SettingsTab, "Mor Tema", function()
    updateTheme(Color3.fromRGB(138, 43, 226))
end)

AddButton(SettingsTab, "Turuncu Tema", function()
    updateTheme(Color3.fromRGB(255, 140, 0))
end)


-- 8. HAKKINDA SEKMESİ
local infoLabel = Instance.new("TextLabel", AboutTab)
infoLabel.BackgroundTransparency = 1
infoLabel.Size = UDim2.new(1, -10, 0, 100)
infoLabel.Font = Enum.Font.GothamBold
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.TextSize = 14
infoLabel.TextWrapped = true
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Text = "Selim's Classic Menu sürüm 1.0\nSelim tarafından yapılmıştır 2026\n\nYeni ayarlar sekmesinden tema rengini dilediğiniz gibi değiştirebilirsiniz!"
