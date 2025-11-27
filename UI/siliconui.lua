-- Silicon UI Library (ModuleScript)
-- Place this in ReplicatedStorage as a ModuleScript named "SiliconUI"

local Silicon = {}
Silicon.__index = Silicon

function Silicon:Create(options)
    -- options.Title

    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SiliconUI"
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local Corner = Instance.new("UICorner", MainFrame)
    Corner.CornerRadius = UDim.new(0, 12)

    -- Shadow
    local Shadow = Instance.new("ImageLabel", MainFrame)
    Shadow.ZIndex = -1
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
    Shadow.ImageTransparency = 0.5
    Shadow.BackgroundTransparency = 1

    -- Close Button
    local Close = Instance.new("TextButton", MainFrame)
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.Position = UDim2.new(1, -40, 0, 5)
    Close.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Close.Text = "X"
    Close.TextColor3 = Color3.fromRGB(220, 80, 80)
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 18
    Close.AutoButtonColor = false

    Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)

    Close.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)

    -- Title Bar
    local dragging = false
    local dragStart, startPos

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, -20, 0, 40)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = options.Title or "Silicon UI"
    Title.TextColor3 = Color3.fromRGB(235, 235, 235)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    Title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Divider
    local Separator = Instance.new("Frame", MainFrame)
    Separator.Size = UDim2.new(1, -20, 0, 1)
    Separator.Position = UDim2.new(0, 10, 0, 42)
    Separator.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    -- Tabs
    local Tabs = Instance.new("ScrollingFrame", MainFrame)
    Tabs.Size = UDim2.new(1, -20, 0, 40)
    Tabs.Position = UDim2.new(0, 10, 0, 50)
    Tabs.CanvasSize = UDim2.new(0, 600, 0, 0)
    Tabs.ScrollBarThickness = 0
    Tabs.BackgroundTransparency = 1

    local UIList = Instance.new("UIListLayout", Tabs)
    UIList.FillDirection = Enum.FillDirection.Horizontal
    UIList.Padding = UDim.new(0, 8)

    -- Divider under tabs
    local TabsDivider = Instance.new("Frame", MainFrame)
    TabsDivider.Size = UDim2.new(1, -20, 0, 1)
    TabsDivider.Position = UDim2.new(0, 10, 0, 97)
    TabsDivider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    -- Create API wrapper
    local UI = {}

    function UI:AddTab(name)
        local Tab = Instance.new("TextButton", Tabs)
        Tab.Size = UDim2.new(0, 90, 1, 0)
        Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Tab.Text = name
        Tab.TextColor3 = Color3.fromRGB(200, 200, 200)
        Tab.Font = Enum.Font.GothamSemibold
        Tab.TextSize = 16
        Tab.AutoButtonColor = false

        Instance.new("UICorner", Tab).CornerRadius = UDim.new(0, 8)

        Tab.MouseEnter:Connect(function()
            Tab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)

        Tab.MouseLeave:Connect(function()
            Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)

        return Tab
    end

    return UI
end

return Silicon
