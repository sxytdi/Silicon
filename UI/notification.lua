local Silicon = {}
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Notifications = {}
local MaxVisible = 4
local Spacing = 10
local BaseY = -20

Silicon.NotificationSoundEnabled = true
Silicon.NotificationDuration = 4

local function createTween(o, t, d)
    TweenService:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), d):Play()
end

function Silicon:Notify(data)
    task.spawn(function()
        local TitleText = data.Title or "Notification"
        local ContentText = data.Content or ""
        local Muted = data.Mute == true

        local gui = Instance.new("ScreenGui")
        gui.Name = "SiliconNotification"
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = PlayerGui

        local BG = Instance.new("Frame")
        BG.Parent = gui
        BG.Size = UDim2.new(0, 330, 0, 94)
        BG.Position = UDim2.new(1, 350, 1, BaseY)
        BG.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
        BG.BorderSizePixel = 0
        BG.ClipsDescendants = true

        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 12)
        c.Parent = BG

        local Shadow = Instance.new("ImageLabel")
        Shadow.Parent = BG
        Shadow.BackgroundTransparency = 1
        Shadow.Position = UDim2.new(0, -12, 0, -12)
        Shadow.Size = UDim2.new(1, 24, 1, 24)
        Shadow.Image = "rbxassetid://1316045217"
        Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
        Shadow.ImageTransparency = 0.82
        Shadow.ScaleType = Enum.ScaleType.Slice
        Shadow.SliceCenter = Rect.new(10,10,118,118)
        Shadow.ZIndex = 0

        local IconWrap = Instance.new("Frame")
        IconWrap.Parent = BG
        IconWrap.Position = UDim2.new(0, 18, 0, 21)
        IconWrap.Size = UDim2.new(0, 44, 0, 44)
        IconWrap.BackgroundColor3 = Color3.fromRGB(22, 22, 28)

        local ic = Instance.new("UICorner")
        ic.CornerRadius = UDim.new(1, 0)
        ic.Parent = IconWrap

        local is = Instance.new("UIStroke")
        is.Color = Color3.fromRGB(0, 170, 255)
        is.Thickness = 1.4
        is.Parent = IconWrap

        local Icon = Instance.new("ImageLabel")
        Icon.Parent = IconWrap
        Icon.BackgroundTransparency = 1
        Icon.Size = UDim2.new(0, 26, 0, 26)
        Icon.Position = UDim2.new(0.5, -13, 0.5, -13)
        Icon.Image = "rbxassetid://124780615486303"

        local Title = Instance.new("TextLabel")
        Title.Parent = BG
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0, 78, 0, 20)
        Title.Size = UDim2.new(1, -120, 0, 26)
        Title.Font = Enum.Font.GothamBold
        Title.TextColor3 = Color3.fromRGB(255,255,255)
        Title.TextSize = 19
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Text = TitleText

        local Desc = Instance.new("TextLabel")
        Desc.Parent = BG
        Desc.BackgroundTransparency = 1
        Desc.Position = UDim2.new(0, 78, 0, 45)
        Desc.Size = UDim2.new(1, -120, 0, 36)
        Desc.Font = Enum.Font.Gotham
        Desc.TextColor3 = Color3.fromRGB(200,200,200)
        Desc.TextSize = 13
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.TextWrapped = true
        Desc.Text = ContentText

        local BarBG = Instance.new("Frame")
        BarBG.Parent = BG
        BarBG.Position = UDim2.new(0, 14, 1, -8)
        BarBG.Size = UDim2.new(1, -28, 0, 3)
        BarBG.BackgroundColor3 = Color3.fromRGB(12, 12, 16)

        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 3)
        bc.Parent = BarBG

        local Bar = Instance.new("Frame")
        Bar.Parent = BarBG
        Bar.Size = UDim2.new(0, 0, 1, 0)
        Bar.BackgroundColor3 = Color3.fromRGB(0,170,255)

        local bc2 = Instance.new("UICorner")
        bc2.CornerRadius = UDim.new(0, 3)
        bc2.Parent = Bar

        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Parent = BG
        CloseBtn.Position = UDim2.new(1, -28, 0, 12)
        CloseBtn.Size = UDim2.new(0, 16, 0, 16)
        CloseBtn.BackgroundTransparency = 1
        CloseBtn.Text = ""

        local A = Instance.new("Frame")
        A.Parent = CloseBtn
        A.AnchorPoint = Vector2.new(0.5,0.5)
        A.Position = UDim2.new(0.5,0,0.5,0)
        A.Size = UDim2.new(1,0,0,2)
        A.BackgroundColor3 = Color3.fromRGB(180,180,185)
        A.BorderSizePixel = 0
        A.Rotation = 45

        local B = A:Clone()
        B.Parent = CloseBtn
        B.Rotation = -45

        if not Muted and Silicon.NotificationSoundEnabled then
            local s = Instance.new("Sound")
            s.SoundId = "rbxassetid://1788243907"
            s.Volume = 0.9
            s.PlayOnRemove = true
            s.Parent = SoundService
            s:Destroy()
        end

        table.insert(Notifications, 1, {Gui = gui, BG = BG})

        for i, n in ipairs(Notifications) do
            local y = BaseY - ((i - 1) * (94 + Spacing))
            createTween(n.BG, 0.3, {Position = UDim2.new(1, -20, 1, y)})
            if i > MaxVisible then
                table.remove(Notifications, i)
                n.Gui:Destroy()
            end
        end

        createTween(BG, 0.35, {Position = UDim2.new(1, -20, 1, BaseY)})
        TweenService:Create(Bar, TweenInfo.new(Silicon.NotificationDuration, Enum.EasingStyle.Linear), {Size = UDim2.new(1,0,1,0)}):Play()

        local dismissed = false

        local function dismiss()
            if dismissed then return end
            dismissed = true
            TweenService:Create(BG, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 350, 1, BaseY)}):Play()
            task.wait(0.3)

            for i, n in ipairs(Notifications) do
                if n.Gui == gui then
                    table.remove(Notifications, i)
                    break
                end
            end

            gui:Destroy()

            for i, n in ipairs(Notifications) do
                local y = BaseY - ((i - 1) * (94 + Spacing))
                createTween(n.BG, 0.25, {Position = UDim2.new(1, -20, 1, y)})
            end
        end

        CloseBtn.MouseButton1Click:Connect(dismiss)
        task.delay(Silicon.NotificationDuration, dismiss)
    end)
end

return Silicon
