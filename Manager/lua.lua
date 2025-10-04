-- Generated using RoadToGlory's Converter v1.1 (RoadToGlory#9879)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui
pcall(function() playerGui = player:WaitForChild("PlayerGui") end)
local container
if playerGui then
	container = playerGui:FindFirstChild("Selector") or Instance.new("ScreenGui")
	container.Name = "Selector"
	container.ResetOnSpawn = false
	container.IgnoreGuiInset = true
	container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	container.Parent = playerGui
else
	container = game:GetService("CoreGui")
end

local Converted = {
	["_Load Screen"] = Instance.new("Frame");
	["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint");
	["_UICorner"] = Instance.new("UICorner");
	["_Border"] = Instance.new("Frame");
	["_Title"] = Instance.new("TextLabel");
	["_Creds"] = Instance.new("TextLabel");
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
Converted["_Load Screen"].Parent = container

Converted["_UIAspectRatioConstraint"].AspectRatio = 2.63
Converted["_UIAspectRatioConstraint"].Parent = Converted["_Load Screen"]

Converted["_UICorner"].CornerRadius = UDim.new(0, 18)
Converted["_UICorner"].Parent = Converted["_Load Screen"]

Converted["_Border"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Border"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Border"].BorderSizePixel = 0
Converted["_Border"].Position = UDim2.new(0, 0, 0.3, 0)
Converted["_Border"].Size = UDim2.new(0, 564, 0, 1)
Converted["_Border"].Name = "Border"
Converted["_Border"].Parent = Converted["_Load Screen"]

Converted["_Title"].Font = Enum.Font.GothamBold
Converted["_Title"].Text = "Silicon Loader V1"
Converted["_Title"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Title"].TextSize = 40
Converted["_Title"].BackgroundTransparency = 1
Converted["_Title"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Title"].BorderSizePixel = 0
Converted["_Title"].Position = UDim2.new(0, 0, 0.00606661057, 0)
Converted["_Title"].Size = UDim2.new(0, 565, 0, 64)
Converted["_Title"].Name = "Title"
Converted["_Title"].Parent = Converted["_Load Screen"]

Converted["_Creds"].Font = Enum.Font.GothamBold
Converted["_Creds"].Text = ""
Converted["_Creds"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Creds"].TextDirection = Enum.TextDirection.RightToLeft
Converted["_Creds"].TextSize = 20
Converted["_Creds"].BackgroundTransparency = 1
Converted["_Creds"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Creds"].BorderSizePixel = 0
Converted["_Creds"].Position = UDim2.new(-0.00176850287, 0, 0.306976736, 0)
Converted["_Creds"].Size = UDim2.new(0, 565, 0, 69)
Converted["_Creds"].Name = "Creds"
Converted["_Creds"].Parent = Converted["_Load Screen"]

Converted["_Cred 2"].Font = Enum.Font.GothamBold
Converted["_Cred 2"].Text = "Developed by 5xy & Lone"
Converted["_Cred 2"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Cred 2"].TextDirection = Enum.TextDirection.RightToLeft
Converted["_Cred 2"].TextSize = 20
Converted["_Cred 2"].BackgroundTransparency = 1
Converted["_Cred 2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Cred 2"].BorderSizePixel = 0
Converted["_Cred 2"].Position = UDim2.new(0.00177131582, 0, -0.0118638193, 0)
Converted["_Cred 2"].Size = UDim2.new(0, 565, 0, 35)
Converted["_Cred 2"].Name = "Cred 2"
Converted["_Cred 2"].Parent = Converted["_Creds"]

Converted["_Cred"].Font = Enum.Font.GothamBold
Converted["_Cred"].Text = "Last Script Update: 4th Oct"
Converted["_Cred"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Cred"].TextDirection = Enum.TextDirection.RightToLeft
Converted["_Cred"].TextSize = 20
Converted["_Cred"].BackgroundTransparency = 1
Converted["_Cred"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Cred"].BorderSizePixel = 0
Converted["_Cred"].Position = UDim2.new(0.00177131582, 0, 0.495382547, 0)
Converted["_Cred"].Size = UDim2.new(0, 565, 0, 35)
Converted["_Cred"].Name = "Cred"
Converted["_Cred"].Parent = Converted["_Creds"]

Converted["_TextButton"].Font = Enum.Font.GothamBold
Converted["_TextButton"].Text = "Load"
Converted["_TextButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextButton"].TextSize = 30
Converted["_TextButton"].BackgroundColor3 = Color3.fromRGB(0, 150, 215)
Converted["_TextButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextButton"].BorderSizePixel = 0
Converted["_TextButton"].Position = UDim2.new(0.321867526, 0, 0.674418628, 0)
Converted["_TextButton"].Size = UDim2.new(0, 200, 0, 50)
Converted["_TextButton"].Parent = Converted["_Load Screen"]

Converted["_UICorner1"].Parent = Converted["_TextButton"]

Converted["_Load Screen"].Visible = false
local targetPos = Converted["_Load Screen"].Position
Converted["_Load Screen"].Position = UDim2.new(-1, 0, targetPos.Y.Scale, targetPos.Y.Offset)

local executorWhitelist = {
	["Solara"] = true,
	["Delta"] = true,
	["Wave"] = true,
	["Velocity"] = true,
	["Swift"] = true,
	["Zenith"] = true,
	["Volcano"] = true,
	["Seliware"] = true,
	["Hydrogen"] = true,
	["Xeno"] = true,
	["Krnl"] = true,
}

Converted["_TextButton"].MouseButton1Click:Connect(function()
	Converted["_Load Screen"].Visible = true
	local tween = TweenService:Create(Converted["_Load Screen"], TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos})
	tween:Play()
	tween.Completed:Wait()
	local success, executorName = pcall(identifyexecutor)
	if not (success and executorName and executorWhitelist[executorName]) then
		if player then
			player:Kick("Unsupported executor: "..tostring(executorName))
		end
		return
	end
	if game.PlaceId == 891852901 then
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3c449b82c414c774ea51869482031c55.lua"))()
	elseif game.PlaceId == 5104202731 then
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/fe0a47be0fedc464bd089b119429baa8.lua"))()
	elseif game.PlaceId == 4637668954 then
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/619b44cbfb541a3a85463bba0ad5340f.lua"))()
	elseif game.PlaceId == 72712036210947 then
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e41f0794d595dbe9e8802c3427d77558.lua"))()
	end
end)
