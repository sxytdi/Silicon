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
    BG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    BG.BorderSizePixel = 0
    BG.AnchorPoint = Vector2.new(1, 1)
    BG.Position = UDim2.new(1, 320, 1, -20)
    BG.Size = UDim2.new(0, 300, 0, 100)

    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Parent = BG
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.new(0, 100, 0, 100)
    ImageLabel.Image = "rbxassetid://124780615486303"

    local Title = Instance.new("TextLabel")
    Title.Parent = BG
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.33, 0, 0.35, 0)
    Title.Size = UDim2.new(0, 180, 0, 25)
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Text = TitleText

    local Description = Instance.new("TextLabel")
    Description.Parent = BG
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0.33, 0, 0.55, 0)
    Description.Size = UDim2.new(0, 180, 0, 22)
    Description.Font = Enum.Font.Gotham
    Description.TextColor3 = Color3.fromRGB(255, 255, 255)
    Description.TextSize = 17
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Text = ContentText

    local Bar = Instance.new("Frame")
    Bar.Parent = BG
    Bar.BackgroundColor3 = Color3.fromRGB(0, 150, 215)
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
