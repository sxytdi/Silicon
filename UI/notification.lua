local Silicon = {}

function Silicon:Notify(tbl)
    local TitleText = tbl.Title or "Notification"
    local ContentText = tbl.Content or "No message"

    local gui = Instance.new("ScreenGui")
    gui.Name = "SiliconNotifications"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local BG = Instance.new("Frame")
    BG.Parent = gui
    BG.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
    BG.BorderSizePixel = 0
    BG.AnchorPoint = Vector2.new(1, 1)
    BG.Position = UDim2.new(1, 320, 1, -20)
    BG.Size = UDim2.new(0, 300, 0, 100)

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = BG

    local Shadow = Instance.new("ImageLabel")
    Shadow.Parent = BG
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.75
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.ZIndex = 0

    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Parent = BG
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.new(0, 80, 0, 80)
    ImageLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    ImageLabel.Image = "rbxassetid://124780615486303"

    local Title = Instance.new("TextLabel")
    Title.Parent = BG
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.35, -10, 0.33, 0)
    Title.Size = UDim2.new(0, 180, 0, 25)
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Text = TitleText

    local Description = Instance.new("TextLabel")
    Description.Parent = BG
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0.35, -10, 0.58, 0)
    Description.Size = UDim2.new(0, 180, 0, 22)
    Description.Font = Enum.Font.Gotham
    Description.TextColor3 = Color3.fromRGB(220, 220, 220)
    Description.TextSize = 17
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Text = ContentText

    local Bar = Instance.new("Frame")
    Bar.Parent = BG
    Bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    Bar.BorderSizePixel = 0
    Bar.Position = UDim2.new(0, 0, 1, -2)
    Bar.Size = UDim2.new(0, 0, 0, 2)

    local TweenService = game:GetService("TweenService")

    local slideIn = TweenService:Create(BG, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 1, -20)})
    slideIn:Play()

    local barTween = TweenService:Create(Bar, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 0, 2)})
    barTween:Play()

    task.wait(3.8)

    local slideOut = TweenService:Create(BG, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 320, 1, -20)})
    slideOut:Play()

    slideOut.Completed:Connect(function()
        gui:Destroy()
    end)
end

return Silicon
