-- SiliconNotifications.lua
-- Place this ModuleScript in ReplicatedStorage (or paste into a ModuleScript named "SiliconNotifications")

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Silicon = {}

-- Config
local slideDuration = 1
local holdDuration = 3
local barDuration = 3
local barColorStart = Color3.fromRGB(255, 255, 255)
local barColorEnd = Color3.fromRGB(0, 150, 215)

local disabled = false
local filterFn = nil

-- Expect a ScreenGui named "SiliconTemplate" under ReplicatedStorage
-- Structure expected:
-- SiliconTemplate (ScreenGui)
--  └ BG (Frame)
--     ├ Title (TextLabel)
--     ├ Description (TextLabel)
--     └ Bar (Frame)
local function getTemplate()
	return ReplicatedStorage:FindFirstChild("SiliconTemplate")
end

function Silicon:Disable()
	disabled = true
end

function Silicon:Enable()
	disabled = false
end

function Silicon:IsDisabled()
	return disabled
end

function Silicon:SetFilter(fn)
	-- fn receives (info) and should return true to BLOCK the notification, false to allow it
	filterFn = fn
end

function Silicon:ClearFilter()
	filterFn = nil
end

function Silicon:_spawnGui(info)
	if disabled then return end
	if filterFn and filterFn(info) then return end

	local player = Players.LocalPlayer
	if not player then return end

	local template = getTemplate()
	if not template then
		warn("SiliconNotifications: SiliconTemplate not found in ReplicatedStorage")
		return
	end

	local gui = template:Clone()
	gui.Name = "SiliconNotificationInstance"
	gui.Parent = player:WaitForChild("PlayerGui")

	local frame = gui:WaitForChild("BG")
	local titleLabel = frame:WaitForChild("Title")
	local contentLabel = frame:WaitForChild("Description")
	local bar = frame:WaitForChild("Bar")

	titleLabel.Text = info.Title or ""
	contentLabel.Text = info.Content or ""

	frame.AnchorPoint = Vector2.new(1, 1)
	frame.Position = UDim2.new(1, frame.Size.X.Offset + 20, 1, -20)

	-- configure bar to grow left -> right, 2px tall
	bar.AnchorPoint = Vector2.new(0, 1)
	bar.Position = UDim2.new(0, 0, 1, 0)
	bar.Size = UDim2.new(0, 0, 0, 2)
	bar.BackgroundColor3 = barColorStart

	-- slide in
	local slideIn = TweenService:Create(
		frame,
		TweenInfo.new(slideDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ Position = UDim2.new(1, -20, 1, -20) }
	)
	slideIn:Play()

	-- bar tween (size + color)
	local barTween = TweenService:Create(
		bar,
		TweenInfo.new(barDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		{ Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = barColorEnd }
	)
	barTween:Play()

	-- wait for visible time (slide in time + holdDuration)
	task.spawn(function()
		task.wait(slideDuration + holdDuration)
		local slideOut = TweenService:Create(
			frame,
			TweenInfo.new(slideDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			{ Position = UDim2.new(1, frame.Size.X.Offset + 20, 1, -20) }
		)
		slideOut:Play()
		slideOut.Completed:Wait()
		gui:Destroy()
	end)
end

function Silicon:Notify(info)
	-- info = { Title = string, Content = string, Duration = optional number (overrides holdDuration) }
	if disabled then return end
	if filterFn and filterFn(info) then return end

	-- if a custom Duration is provided, temporarily use it
	local oldHold = holdDuration
	if info.Duration and type(info.Duration) == "number" then
		holdDuration = info.Duration
	end

	-- spawn gui (non-blocking)
	task.spawn(function()
		self:_spawnGui(info)
	end)

	-- restore holdDuration (if it was overridden)
	holdDuration = oldHold
end

return Silicon
