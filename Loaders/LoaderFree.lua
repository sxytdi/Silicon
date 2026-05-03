local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local gameId = game.GameId
local player = Players.LocalPlayer
local placeId = game.PlaceId

local allowedExecutors = {
    "Madium",   
    "Opiumware", 
    "Delta", 
    "Bunni", 
    "Codex", 
    "Silicon",
    "Velocity",  
    "Cryptic",
    "Hydrogen",
    "Potassium", 
    "Wave", 
    "Isaeva",
    "MacSploit", 
    "Cosmic",
    "Volt", 
    "Synapse Z", 
    "Volcano", 
    "Seliware", 
    "SirHurt"
}

local function check()
    if identifyexecutor then
        local name = identifyexecutor()
        local allowed = false

        for _, v in ipairs(allowedExecutors) do
            if name:find(v) then
                allowed = true
                break
            end
        end

        if not allowed then
            task.spawn(function()
                player:Kick("Unauthorized: " .. name)
            end)
            task.wait(0.1)
            while true do end
        end
    else
        task.spawn(function()
            player:Kick("Execution Environment Not Found")
        end)
        task.wait(0.1)
        while true do end
    end
end

check()

task.wait(0.15)

local TweenService = game:GetService("TweenService")

if player then
    local guiParent = player:WaitForChild("PlayerGui")

    local Splash = Instance.new("ScreenGui")
    Splash.IgnoreGuiInset = true
    Splash.ResetOnSpawn = false
    Splash.Parent = guiParent

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 1, 0)
    Container.BackgroundTransparency = 1
    Container.Parent = Splash

    local Logo = Instance.new("ImageLabel")
    Logo.Size = UDim2.new(0, 120, 0, 120)
    Logo.Position = UDim2.new(0.5, -185, 0.5, -60)
    Logo.BackgroundTransparency = 1
    Logo.ImageTransparency = 1
    Logo.Image = "rbxassetid://124780615486303"
    Logo.Parent = Container

    local Text = Instance.new("TextLabel")
    Text.Text = "Silicon"
    Text.Font = Enum.Font.MontserratBold
    Text.TextColor3 = Color3.new(1, 1, 1)
    Text.TextSize = 72
    Text.BackgroundTransparency = 1
    Text.TextTransparency = 1
    Text.Size = UDim2.new(0, 400, 0, 100)
    Text.Position = UDim2.new(0.5, -165, 0.5, -55)
    Text.Parent = Container

    TweenService:Create(Logo, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
        ImageTransparency = 0
    }):Play()

    task.wait(0.4)

    TweenService:Create(Text, TweenInfo.new(1.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -163, 0.5, -55),
        TextTransparency = 0
    }):Play()

    task.wait(1.6)

    TweenService:Create(Logo, TweenInfo.new(0.6), {ImageTransparency = 1}):Play()
    TweenService:Create(Text, TweenInfo.new(0.6), {TextTransparency = 1}):Play()

    task.wait(0.7)
    Splash:Destroy()
end

if getgenv then
    if getgenv().SiliconLoaded then
        player:Kick("Silicon | Why did you execute twice?")
        return
    else
        getgenv().SiliconLoaded = true
    end
end

if placeId == 891852901 then 
    print("Greenville")
    loadstring(game:HttpGet("https://luaprot.net/api/v1/loaders/get/55536199696471763640"))()
elseif placeId == 139439863257440 then
    print("Young Street, Ontario")
    loadstring(game:HttpGet("https://luaprot.net/api/v1/loaders/get/37402498676520066316"))()
end