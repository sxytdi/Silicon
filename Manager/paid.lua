if game.PlaceId == 891852901 and identifyexecutor and string.lower(tostring(identifyexecutor())):find("xeno") then
    game.Players.LocalPlayer:Kick("Xeno not supported on Greenville.")
end

local player = game.Players.LocalPlayer
local username = player.DisplayName or player.Name

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local playerGui = player:FindFirstChildOfClass("PlayerGui")
local guiParent = playerGui or CoreGui

local Splash = Instance.new("ScreenGui")
Splash.IgnoreGuiInset = true
Splash.ResetOnSpawn = false
Splash.Parent = guiParent

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1,0,1,0)
Container.BackgroundTransparency = 1
Container.Parent = Splash

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0,120,0,120)
Logo.Position = UDim2.new(0.5,-185,0.5,-60)
Logo.BackgroundTransparency = 1
Logo.ImageTransparency = 1
Logo.Image = "rbxassetid://124780615486303"
Logo.Parent = Container

local Text = Instance.new("TextLabel")
Text.Text = "Silicon"
Text.Font = Enum.Font.MontserratBold
Text.TextColor3 = Color3.new(1,1,1)
Text.TextSize = 72
Text.BackgroundTransparency = 1
Text.TextTransparency = 1
Text.Size = UDim2.new(0,400,0,100)
Text.Position = UDim2.new(0.5,-165,0.5,-55)
Text.Parent = Container

TweenService:Create(Logo, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
task.wait(0.4)

Text.Position = UDim2.new(0.5, -185, 0.5, -55)  
Text.TextTransparency = 1

TweenService:Create(Text, TweenInfo.new(1.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -163, 0.5,-55),  
    TextTransparency = 0
}):Play()

task.wait(1.6)

TweenService:Create(Logo, TweenInfo.new(0.6), {ImageTransparency = 1}):Play()
TweenService:Create(Text, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
task.wait(0.7)
Splash:Destroy()

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Name = "Silicon_LoadBlur"
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quad), {Size = 25}):Play()

local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name = "SiliconLoader"
LoaderGui.IgnoreGuiInset = true
LoaderGui.Parent = guiParent

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 480, 0, 230)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
Frame.BackgroundTransparency = 0.1
Frame.Parent = LoaderGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 16)
local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 1.2
UIStroke.Color = Color3.fromRGB(60, 60, 65)

local Title = Instance.new("TextLabel")
Title.Text = "Silicon Loader"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 36
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0.05, 0)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Parent = Frame

local Subtitle = Instance.new("TextLabel")
Subtitle.Text = "Welcome, " .. username
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
Subtitle.TextSize = 20
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0.25, 0)
Subtitle.Size = UDim2.new(1, 0, 0, 30)
Subtitle.Parent = Frame

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.7, 0, 0, 1)
Divider.Position = UDim2.new(0.15, 0, 0.42, 0)
Divider.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
Divider.BorderSizePixel = 0
Divider.Parent = Frame

local Credits = Instance.new("TextLabel")
Credits.Text = "Developed by 5xy & Lone"
Credits.Font = Enum.Font.Gotham
Credits.TextColor3 = Color3.fromRGB(150, 150, 150)
Credits.TextSize = 16
Credits.BackgroundTransparency = 1
Credits.Position = UDim2.new(0, 0, 0.47, 0)
Credits.Size = UDim2.new(1, 0, 0, 25)
Credits.Parent = Frame

local Button = Instance.new("TextButton")
Button.Text = "Load"
Button.Font = Enum.Font.GothamBold
Button.TextSize = 26
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Size = UDim2.new(0, 180, 0, 50)
Button.Position = UDim2.new(0.5, -90, 0.68, 0)
Button.AutoButtonColor = false
Button.BackgroundTransparency = 0
Button.Parent = Frame

local ButtonGradient = Instance.new("UIGradient", Button)
ButtonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 140, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 180, 255))
}
Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 10)

Button.MouseEnter:Connect(function()
    TweenService:Create(ButtonGradient, TweenInfo.new(0.3), {
    }):Play()
end)
Button.MouseLeave:Connect(function()
    TweenService:Create(ButtonGradient, TweenInfo.new(0.3), {
    }):Play()
end)
Button.MouseButton1Down:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0, 175, 0, 47)}):Play()
end)
Button.MouseButton1Up:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0, 180, 0, 50)}):Play()
end)

local Close = Instance.new("TextButton")
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 28
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(1, -35, 0, 5)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Parent = Frame

Close.MouseEnter:Connect(function()
    TweenService:Create(Close, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 60, 60)}):Play()
end)
Close.MouseLeave:Connect(function()
    TweenService:Create(Close, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

Close.MouseButton1Click:Connect(function()
    TweenService:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1.5, 0, 0.5, 0)}):Play()
    TweenService:Create(blur, TweenInfo.new(1), {Size = 0}):Play()
    task.wait(0.7)
    LoaderGui:Destroy()
    blur:Destroy()
end)

local startPos = UDim2.new(1.2, 0, 0.5, 0)
Frame.Position = startPos
TweenService:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play()

Button.MouseButton1Click:Connect(function()
    Button.Text = "Loading..."
    Button.Active = false

    local CONFIG_URL = "https://raw.githubusercontent.com/sxytdi/Silicon/refs/heads/main/Manager/ScriptSwitch.txt"
    
    local success, configText = pcall(function()
        return game:HttpGet(CONFIG_URL)
    end)

    local allowedScripts = {}

    if success and configText then
        for line in configText:gmatch("[^\r\n]+") do
            local key, value = line:match("^(.-)=(.-)$")
            if key and value then
                key = key:gsub("%s+", "") 
                value = value:gsub("%s+", "")
                allowedScripts[key] = (value:lower() == "true")
            end
        end
    else
        player:Kick("Failed to fetch script switch config. All scripts disabled.")
    end

    local gameTags = {
        Greenville        = 891852901,
        RensselaerCounty  = 4637668954,
        Flick             = 136801880565837,
        SouthwestFlorida  = 5104202731,
    }

    local currentGameTag = nil
    for tag, placeId in pairs(gameTags) do
        if game.PlaceId == placeId then
            currentGameTag = tag
            break
        end
    end

    local fadeOut = TweenService:Create(Frame, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(-1, 0, 0.5, 0)
    })
    fadeOut:Play()
    TweenService:Create(blur, TweenInfo.new(1), {Size = 0}):Play()

    task.wait(0.8)

    if not currentGameTag then
        player:Kick("This game is not supported by Silicon Loader.")
        return
    end

    if not allowedScripts[currentGameTag] then
        player:Kick("This script is currently disabled by the developer.")
        return
    end

    if typeof(script_key) ~= "string" or #script_key ~= 16 or not script_key:match("^[A-Za-z0-9]+$") then
        player:Kick("Invalid or missing script key.")
        return
    end

    if game.PlaceId == gameTags.Greenville then
        loadstring(game:HttpGet("https://api.siliconxploits.xyz/greenville-check"))()
        loadstring(game:HttpGet("https://api.siliconxploits.xyz/secure/9027483615902748"))()
    end
        
    if game.PlaceId == gameTags.RensselaerCounty then
        loadstring(game:HttpGet("https://api.siliconxploits.xyz/secure/4824804718429069"))()
    end
        
    if game.PlaceId == gameTags.Flick then
        loadstring(game:HttpGet("https://api.siliconxploits.xyz/secure/2487586789486805"))()
    end
        
    if game.PlaceId == gameTags.SouthwestFlorida then
        loadstring(game:HttpGet("https://api.siliconxploits.xyz/secure/8825723069239146"))()
    end

    task.wait(2)
    fadeOut.Completed:Wait()
    LoaderGui:Destroy()
    blur:Destroy()
end)
