if identifyexecutor then
    local name, version = identifyexecutor()
    if name and (name:lower():find("xeno") or name:lower():find("dssd")) then
        local TweenService = game:GetService("TweenService")
        local Lighting = game:GetService("Lighting")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local username = player.DisplayName or player.Name
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.IgnoreGuiInset = true
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = player:WaitForChild("PlayerGui")
        local blur = Instance.new("BlurEffect")
        blur.Size = 0
        blur.Parent = Lighting
        TweenService:Create(blur, TweenInfo.new(0.8), {Size = 25}):Play()
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 480, 0, 240)
        Frame.Position = UDim2.new(1.3, 0, 0.5, 0)
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
        Frame.BackgroundTransparency = 0.1
        Frame.Parent = ScreenGui
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 16)
        local stroke = Instance.new("UIStroke", Frame)
        stroke.Thickness = 1.2
        stroke.Color = Color3.fromRGB(60, 60, 65)
        local Title = Instance.new("TextLabel")
        Title.Text = "Silicon API"
        Title.Font = Enum.Font.GothamBold
        Title.TextColor3 = Color3.new(1, 1, 1)
        Title.TextSize = 40
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1, 0, 0, 50)
        Title.Position = UDim2.new(0, 0, 0.08, 0)
        Title.TextXAlignment = Enum.TextXAlignment.Center
        Title.Parent = Frame
        local Welcome = Instance.new("TextLabel")
        Welcome.Text = "Welcome, " .. username
        Welcome.Font = Enum.Font.Gotham
        Welcome.TextColor3 = Color3.fromRGB(180, 180, 180)
        Welcome.TextSize = 20
        Welcome.BackgroundTransparency = 1
        Welcome.Size = UDim2.new(1, 0, 0, 35)
        Welcome.Position = UDim2.new(0, 0, 0.30, 0)
        Welcome.TextXAlignment = Enum.TextXAlignment.Center
        Welcome.Parent = Frame
        local Warning = Instance.new("TextLabel")
        Warning.Font = Enum.Font.GothamBold
        Warning.TextColor3 = Color3.fromRGB(255, 85, 85)
        Warning.TextSize = 19
        Warning.TextWrapped = true
        Warning.BackgroundTransparency = 1
        Warning.Size = UDim2.new(0.88, 0, 0, 65)
        Warning.Position = UDim2.new(0.06, 0, 0.46, 0)
        Warning.TextXAlignment = Enum.TextXAlignment.Center
        Warning.Parent = Frame
        if name:lower():find("xeno") then
            Warning.Text = "Xeno isn't supported on Greenville"
        elseif name:lower():find("solara") then
            Warning.Text = "Solara isn't supported on Greenville"
        end
        local Divider = Instance.new("Frame")
        Divider.Size = UDim2.new(0.7, 0, 0, 1)
        Divider.Position = UDim2.new(0.15, 0, 0.72, 0)
        Divider.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
        Divider.BorderSizePixel = 0
        Divider.Parent = Frame
        local Thanks = Instance.new("TextLabel")
        Thanks.Text = "Thanks for using Silicon!"
        Thanks.Font = Enum.Font.GothamBold
        Thanks.TextColor3 = Color3.new(1, 1, 1)
        Thanks.TextSize = 19
        Thanks.BackgroundTransparency = 1
        Thanks.Size = UDim2.new(1, 0, 0, 35)
        Thanks.Position = UDim2.new(0, 0, 0.78, 0)
        Thanks.TextXAlignment = Enum.TextXAlignment.Center
        Thanks.Parent = Frame
        TweenService:Create(Frame, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        task.wait(5)
        while true do
            local part = Instance.new("Part", workspace)
        end
    end
end
