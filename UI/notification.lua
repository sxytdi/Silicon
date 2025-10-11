local Silicon = {}
local TweenService = game:GetService("TweenService")
local Notifications = {}
local MaxVisible = 4
local NotificationSpacing = 10
local BaseY = -20

function Silicon:Notify(tbl)
    task.spawn(function()
        local TitleText = tbl.Title or "Notification"
        local ContentText = tbl.Content or "No message"

        local gui = Instance.new("ScreenGui")
        gui.Name = "SiliconNotifications"
        gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local BG = Instance.new("Frame")
        BG.Parent = gui
        BG.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
        BG.BorderSizePixel = 0
        BG.AnchorPoint = Vector2.new(1, 1)
        BG.Size = UDim2.new(0, 300, 0, 90)
        BG.Position = UDim2.new(1, 320, 1, BaseY)
        BG.ClipsDescendants = true

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 10)
        Corner.Parent = BG

        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Parent = BG
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Size = UDim2.new(0, 50, 0, 50)
        ImageLabel.Position = UDim2.new(0.07, 0, 0.25, 0)
        ImageLabel.Image = "rbxassetid://124780615486303"
        ImageLabel.ImageTransparency = 0.05

        local Title = Instance.new("TextLabel")
        Title.Parent = BG
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0.33, -15, 0.27, 0)
        Title.Size = UDim2.new(0, 180, 0, 28)
        Title.Font = Enum.Font.GothamBold
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextTransparency = 0.05
        Title.TextSize = 18
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.TextYAlignment = Enum.TextYAlignment.Top
        Title.TextWrapped = true
        Title.Text = TitleText

        local Description = Instance.new("TextLabel")
        Description.Parent = BG
        Description.BackgroundTransparency = 1
        Description.Position = UDim2.new(0.33, -15, 0.54, 0)
        Description.Size = UDim2.new(0, 180, 0, 20)
        Description.Font = Enum.Font.Gotham
        Description.TextColor3 = Color3.fromRGB(210, 210, 210)
        Description.TextTransparency = 0.1
        Description.TextSize = 13
        Description.TextXAlignment = Enum.TextXAlignment.Left
        Description.TextYAlignment = Enum.TextYAlignment.Top
        Description.TextWrapped = true
        Description.Text = ContentText

        local Bar = Instance.new("Frame")
        Bar.Parent = BG
        Bar.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
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
        Shadow.ImageTransparency = 0.85
        Shadow.ScaleType = Enum.ScaleType.Slice
        Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
        Shadow.ZIndex = 0

        table.insert(Notifications, 1, { Gui = gui, BG = BG })

        for i, note in ipairs(Notifications) do
            local offsetY = BaseY - ((i - 1) * (BG.Size.Y.Offset + NotificationSpacing))
            TweenService:Create(note.BG, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(1, -20, 1, offsetY) }):Play()
            if i > MaxVisible then
                table.remove(Notifications, i)
                note.Gui:Destroy()
            end
        end

        local slideIn = TweenService:Create(BG, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(1, -20, 1, BaseY) })
        slideIn:Play()

        local barTween = TweenService:Create(Bar, TweenInfo.new(3.2, Enum.EasingStyle.Linear), { Size = UDim2.new(1, 0, 0, 2) })
        barTween:Play()

        task.wait(3.6)

        local slideOut = TweenService:Create(BG, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = UDim2.new(1, 320, 1, BaseY) })
        slideOut:Play()
        slideOut.Completed:Wait()

        for i, note in ipairs(Notifications) do
            if note.Gui == gui then
                table.remove(Notifications, i)
                break
            end
        end

        gui:Destroy()

        for i, note in ipairs(Notifications) do
            local offsetY = BaseY - ((i - 1) * (note.BG.Size.Y.Offset + NotificationSpacing))
            TweenService:Create(note.BG, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(1, -20, 1, offsetY) }):Play()
        end
    end)
end

return Silicon
