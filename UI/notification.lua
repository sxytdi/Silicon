local Silicon = {}
local ActiveNotification = nil
local TweenService = game:GetService("TweenService")

function Silicon:Notify(tbl)
    task.spawn(function()
        local TitleText = tbl.Title or "Notification"
        local ContentText = tbl.Content or "No message"

        if ActiveNotification then
            local old = ActiveNotification
            ActiveNotification = nil
            local slideOutOld = TweenService:Create(old.BG, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 320, 1, -20)})
            slideOutOld:Play()
            slideOutOld.Completed:Wait()
            if old.Gui then old.Gui:Destroy() end
        end

        local gui = Instance.new("ScreenGui")
        gui.Name = "SiliconNotifications"
        gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local BG = Instance.new("Frame")
        BG.Parent = gui
        BG.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
        BG.BorderSizePixel = 0
        BG.AnchorPoint = Vector2.new(1, 1)
        BG.Position = UDim2.new(1, 320, 1, -20)
        BG.Size = UDim2.new(0, 300, 0, 100)

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 10)
        Corner.Parent = BG

        local BottomMask = Instance.new("Frame")
        BottomMask.Parent = BG
        BottomMask.BackgroundColor3 = BG.BackgroundColor3
        BottomMask.BorderSizePixel = 0
        BottomMask.AnchorPoint = Vector2.new(0, 1)
        BottomMask.Position = UDim2.new(0, 0, 1, 0)
        BottomMask.Size = UDim2.new(1, 0, 0, 10)
        BottomMask.ZIndex = 2

        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Parent = BG
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Size = UDim2.new(0, 70, 0, 70)
        ImageLabel.Position = UDim2.new(0.07, 0, 0.15, 0)
        ImageLabel.Image = "rbxassetid://124780615486303"
        ImageLabel.ImageTransparency = 0.05

        local Title = Instance.new("TextLabel")
        Title.Parent = BG
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0.33, -15, 0.27, 0)
        Title.Size = UDim2.new(0, 180, 0, 30)
        Title.Font = Enum.Font.GothamBold
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextTransparency = 0.05
        Title.TextSize = 20
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.TextYAlignment = Enum.TextYAlignment.Top
        Title.TextWrapped = true
        Title.Text = TitleText

        local Description = Instance.new("TextLabel")
        Description.Parent = BG
        Description.BackgroundTransparency = 1
        Description.Position = UDim2.new(0.33, -15, 0.48, 0)
        Description.Size = UDim2.new(0, 180, 0, 40)
        Description.Font = Enum.Font.GothamMedium
        Description.TextColor3 = Color3.fromRGB(210, 210, 210)
        Description.TextTransparency = 0.1
        Description.TextSize = 16
        Description.TextXAlignment = Enum.TextXAlignment.Left
        Description.TextYAlignment = Enum.TextYAlignment.Top
        Description.TextWrapped = true
        Description.Text = ContentText

        local Bar = Instance.new("Frame")
        Bar.Parent = BG
        Bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        Bar.BorderSizePixel = 0
        Bar.Position = UDim2.new(0, 0, 1, -2)
        Bar.Size = UDim2.new(0, 0, 0, 2)
        Bar.ZIndex = 3

        local Shadow = Instance.new("ImageLabel")
        Shadow.Parent = BG
        Shadow.BackgroundTransparency = 1
        Shadow.Position = UDim2.new(0, -10, 0, -10)
        Shadow.Size = UDim2.new(1, 20, 1, 20)
        Shadow.Image = "rbxassetid://1316045217"
        Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        Shadow.ImageTransparency = 0.8
        Shadow.ScaleType = Enum.ScaleType.Slice
        Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
        Shadow.ZIndex = 0

        local function adjustSize()
            local neededHeight = math.max(100, Title.TextBounds.Y + Description.TextBounds.Y + 40)
            BG.Size = UDim2.new(0, 300, 0, neededHeight)
        end

        Title:GetPropertyChangedSignal("TextBounds"):Connect(adjustSize)
        Description:GetPropertyChangedSignal("TextBounds"):Connect(adjustSize)
        adjustSize()

        ActiveNotification = {Gui = gui, BG = BG}

        local slideIn = TweenService:Create(BG, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 1, -20)})
        slideIn:Play()

        local barTween = TweenService:Create(Bar, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 0, 2)})
        barTween:Play()

        task.wait(3.5)

        local slideOut = TweenService:Create(BG, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 320, 1, -20)})
        slideOut:Play()
        slideOut.Completed:Wait()

        if gui then gui:Destroy() end
        if ActiveNotification and ActiveNotification.Gui == gui then
            ActiveNotification = nil
        end
    end)
end

return Silicon
