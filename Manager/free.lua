local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SquareUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 250)
frame.Position = UDim2.new(0.5, -125, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.ClipsDescendants = true
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true 

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 60, 60)
stroke.Thickness = 1
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 40)
title.Position = UDim2.new(0.5, -95, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Script Loader"
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.Gotham
closeButton.TextSize = 18
closeButton.Parent = frame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeButton
local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(150, 0, 0)
closeStroke.Thickness = 1
closeStroke.Transparency = 0.5
closeStroke.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local acbButton = Instance.new("TextButton")
acbButton.Size = UDim2.new(0, 200, 0, 50)
acbButton.Position = UDim2.new(0.5, -100, 0, 60)
acbButton.Text = "ACB"
acbButton.BackgroundColor3 = Color3.fromRGB(0, 50, 100)
acbButton.TextColor3 = Color3.fromRGB(255, 255, 255)
acbButton.Font = Enum.Font.GothamSemibold
acbButton.TextSize = 18
acbButton.Parent = frame
local acbCorner = Instance.new("UICorner")
acbCorner.CornerRadius = UDim.new(0, 10)
acbCorner.Parent = acbButton
local acbStroke = Instance.new("UIStroke")
acbStroke.Color = Color3.fromRGB(0, 100, 200)
acbStroke.Thickness = 1
acbStroke.Transparency = 0.8
acbStroke.Parent = acbButton

local loadButton = Instance.new("TextButton")
loadButton.Size = UDim2.new(0, 200, 0, 50)
loadButton.Position = UDim2.new(0.5, -100, 0, 130)
loadButton.Text = "Load Script"
loadButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loadButton.TextColor3 = Color3.fromRGB(200, 200, 200)
loadButton.AutoButtonColor = false
loadButton.Font = Enum.Font.GothamSemibold
loadButton.TextSize = 18
loadButton.Parent = frame
local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 10)
loadCorner.Parent = loadButton
local loadStroke = Instance.new("UIStroke")
loadStroke.Color = Color3.fromRGB(100, 100, 100)
loadStroke.Thickness = 1
loadStroke.Transparency = 0.8
loadStroke.Parent = loadButton

local acbClicked = false

acbButton.MouseButton1Click:Connect(function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Remote = ReplicatedStorage:WaitForChild("Remote", 5)  

	if not Remote then
		print("[DEBUG] Remote folder not found or timed out.")
		return
	end

	task.spawn(function()
		if Remote:FindFirstChild("BanMe") then
			Remote.BanMe:Destroy()
			print("[DEBUG] BanMe has been destroyed.")
		end

		if Remote:FindFirstChild("Bunny") then
			Remote.Bunny:Destroy()
			print("[DEBUG] Bunny has been destroyed.")
		end
	end)

    acbClicked = true
    loadButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    loadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadButton.AutoButtonColor = true
end)

loadButton.MouseButton1Click:Connect(function()
    if acbClicked then
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/1e6ddc1413e293f1c1e9702a913ee2cb.lua"))()
    else
        print("ERROR")
    end
end)
