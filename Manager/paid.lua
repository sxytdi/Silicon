local Silicon = loadstring(game:HttpGet("https://raw.githubusercontent.com/sxytdi/Silicon/refs/heads/main/UI/notification.lua"))()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")
local guiParent = playerGui or CoreGui

Silicon:Notify({
	Title = "Welcome!",
	Content = "Silicon Loaded.",
})

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Name = "LoadScreenBlur"
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 25}):Play()

local Converted = {
	["_Load Screen"] = Instance.new("Frame");
	["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint");
	["_UICorner"] = Instance.new("UICorner");
	["_Border"] = Instance.new("Frame");
	["_Title"] = Instance.new("TextLabel");
	["_Creds"] = Instance.new("Frame");
	["_Cred 2"] = Instance.new("TextLabel");
	["_Cred"] = Instance.new("TextLabel");
	["_TextButton"] = Instance.new("TextButton");
	["_UICorner1"] = Instance.new("UICorner");
}

Converted["_Load Screen"].BackgroundColor3 = Color3.fromRGB(36, 36, 36)
Converted["_Load Screen"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Load Screen"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Load Screen"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Load Screen"].Size = UDim2.new(0, 714, 0, 215)
Converted["_Load Screen"].Name = "Load Screen"
Converted["_Load Screen"].Parent = Instance.new("ScreenGui", guiParent)

Converted["_UIAspectRatioConstraint"].AspectRatio = 2.63
Converted["_UIAspectRatioConstraint"].Parent = Converted["_Load Screen"]

Converted["_UICorner"].CornerRadius = UDim.new(0, 18)
Converted["_UICorner"].Parent = Converted["_Load Screen"]

Converted["_Border"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Border"].BorderSizePixel = 0
Converted["_Border"].Position = UDim2.new(0, 0, 0.3, 0)
Converted["_Border"].Size = UDim2.new(0, 564, 0, 1)
Converted["_Border"].Parent = Converted["_Load Screen"]

Converted["_Title"].Font = Enum.Font.GothamBold
Converted["_Title"].Text = "Silicon Loader V1"
Converted["_Title"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Title"].TextSize = 40
Converted["_Title"].BackgroundTransparency = 1
Converted["_Title"].Size = UDim2.new(0, 565, 0, 64)
Converted["_Title"].Parent = Converted["_Load Screen"]

Converted["_Creds"].BackgroundTransparency = 1
Converted["_Creds"].Position = UDim2.new(0, 0, 0.31, 0)
Converted["_Creds"].Size = UDim2.new(0, 565, 0, 69)
Converted["_Creds"].Parent = Converted["_Load Screen"]

Converted["_Cred 2"].Font = Enum.Font.GothamBold
Converted["_Cred 2"].Text = "Developed by 5xy & Lone"
Converted["_Cred 2"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Cred 2"].TextSize = 20
Converted["_Cred 2"].BackgroundTransparency = 1
Converted["_Cred 2"].Position = UDim2.new(0, 0, 0, 0)
Converted["_Cred 2"].Size = UDim2.new(0, 565, 0, 35)
Converted["_Cred 2"].Parent = Converted["_Creds"]

Converted["_Cred"].Font = Enum.Font.GothamBold
Converted["_Cred"].Text = "Last Script Update: nil"
Converted["_Cred"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Cred"].TextSize = 20
Converted["_Cred"].BackgroundTransparency = 1
Converted["_Cred"].Position = UDim2.new(0, 0, 0.5, 0)
Converted["_Cred"].Size = UDim2.new(0, 565, 0, 35)
Converted["_Cred"].Parent = Converted["_Creds"]

Converted["_TextButton"].Font = Enum.Font.GothamBold
Converted["_TextButton"].Text = "Load"
Converted["_TextButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextButton"].TextSize = 30
Converted["_TextButton"].BackgroundColor3 = Color3.fromRGB(0, 150, 215)
Converted["_TextButton"].Position = UDim2.new(0.32, 0, 0.67, 0)
Converted["_TextButton"].Size = UDim2.new(0, 200, 0, 50)
Converted["_TextButton"].Parent = Converted["_Load Screen"]

Converted["_UICorner1"].Parent = Converted["_TextButton"]

Converted["_Load Screen"].Visible = true
local targetPos = Converted["_Load Screen"].Position
Converted["_Load Screen"].Position = UDim2.new(-1, 0, 0.5, 0)
TweenService:Create(Converted["_Load Screen"], TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()

local executorWhitelist = {
	["Solara"] = true, ["Delta"] = true, ["Wave"] = true,
	["Velocity"] = true, ["Swift"] = true, ["Zenith"] = true,
	["Volcano"] = true, ["Seliware"] = true, ["Hydrogen"] = true,
	["Krnl"] = true, ["LX63"] = true, ["Bunni"] = true,
}

Converted["_TextButton"].MouseButton1Click:Connect(function()
	Converted["_TextButton"].Text = "Loading..."
	Converted["_TextButton"].Active = false
	task.wait(2)

	local slideOut = TweenService:Create(Converted["_Load Screen"], TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(-1, 0, 0.5, 0)})
	slideOut:Play()
	TweenService:Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0}):Play()

	local success, executorName = pcall(identifyexecutor)
	if not (success and executorName and executorWhitelist[executorName]) then
		player:Kick("Unsupported executor: "..tostring(executorName))
		return
	end

	if game.PlaceId == 891852901 then
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/beda9a2667a9e6534dac3e7c378fa3e2.lua"))()
	elseif game.PlaceId == 4637668954 then
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3cc82a592e165b81981ca0da7906b0d4.lua"))()
	elseif game.PlaceId == 135155039067698 then
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/4e46381b1266a81f6b2f44973e084714.lua"))()
	elseif game.PlaceId == 5104202731 then
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/f2f649c1e99cf64b62bac3d9bc54da13.lua"))()
	end

	task.wait(2)
	slideOut.Completed:Wait()
	blur:Destroy()
end)
