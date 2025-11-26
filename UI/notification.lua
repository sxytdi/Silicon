--// Silicon Notifications – Refactored Professional Module
--// Clean, modern, configurable, optimized

local Silicon = {}

local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")

--====================================================
-- CONFIG
--====================================================

Silicon.MaxVisible    = 5
Silicon.Spacing       = 10
Silicon.BaseOffsetY   = -24
Silicon.AnimationTime = 0.32

Silicon.NotificationSoundEnabled = true

-- Theme Colors
Silicon.Theme = {
	Background = Color3.fromRGB(20,20,24),
	Accent     = Color3.fromRGB(120,120,255),
	Text       = Color3.fromRGB(240,240,240),
	Secondary  = Color3.fromRGB(190,190,190),
	BarBG      = Color3.fromRGB(35,35,40)
}

-- Optional icon presets
Silicon.TypePresets = {
	Success = {
		Color = Color3.fromRGB(90,255,140),
		Icon  = "rbxassetid://7734050064",
	},

	Error = {
		Color = Color3.fromRGB(255,90,90),
		Icon  = "rbxassetid://7733791703",
	},

	Warning = {
		Color = Color3.fromRGB(255,200,90),
		Icon  = "rbxassetid://7733658504",
	},

	Info = {
		Color = Color3.fromRGB(120,140,255),
		Icon  = "rbxassetid://7733656025",
	}
}

local Notifications = {}

--====================================================
-- HELPERS
--====================================================

local function Tween(obj, info, props)
	return TweenService:Create(obj, TweenInfo.new(info.Time or info, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
end

local function Create(class, props)
	local inst = Instance.new(class)
	for k, v in next, props do inst[k] = v end
	return inst
end

--====================================================
-- CORE NOTIFICATION CREATION
--====================================================

function Silicon:Notify(data)
	task.spawn(function()

		-- Extract Data
		local title     = data.Title or "Notification"
		local content   = data.Content or "Message"
		local duration  = data.Duration or 3.5
		local mute      = data.Mute == true
		local onClick   = data.Callback
		local nType     = data.Type -- Success / Error / Warning / Info
		local customMax = data.Max or Silicon.MaxVisible

		local preset = Silicon.TypePresets[nType]
		local accentColor = preset and preset.Color or Silicon.Theme.Accent
		local iconID      = preset and preset.Icon  or data.Icon or "rbxassetid://124780615486303"

		local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

		--=============================================
		-- GUI ROOT
		--=============================================

		local gui = Create("ScreenGui", {
			Name = "SiliconNotification",
			Parent = playerGui,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		})

		local bg = Create("Frame", {
			Parent = gui,
			BackgroundColor3 = Silicon.Theme.Background,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(1,1),
			Size = UDim2.new(0, 300, 0, 80),
			Position = UDim2.new(1, 320, 1, Silicon.BaseOffsetY),
			ClipsDescendants = true
		})

		Create("UICorner", {Parent = bg, CornerRadius = UDim.new(0, 10)})

		-- Shadow
		Create("ImageLabel", {
			Parent = bg,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, -16, 0, -16),
			Size = UDim2.new(1, 32, 1, 32),
			Image = "rbxassetid://1316045217",
			ImageTransparency = 0.86,
			ZIndex = 0
		})

		--=============================================
		-- ICON
		--=============================================

		local iconWrap = Create("Frame", {
			Parent = bg,
			BackgroundColor3 = Silicon.Theme.BarBG,
			Size = UDim2.new(0, 38, 0, 38),
			Position = UDim2.new(0, 14, 0, 18)
		})
		Create("UICorner", {Parent = iconWrap, CornerRadius = UDim.new(1, 0)})

		Create("ImageLabel", {
			Parent = iconWrap,
			BackgroundTransparency = 1,
			Image = iconID,
			ImageColor3 = accentColor,
			Size = UDim2.new(0, 22, 0, 22),
			Position = UDim2.new(0.5, -11, 0.5, -11)
		})

		--=============================================
		-- TEXT
		--=============================================

		Create("TextLabel", {
			Parent = bg,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 64, 0, 14),
			Size = UDim2.new(1, -80, 0, 24),
			Font = Enum.Font.GothamSemibold,
			TextColor3 = Silicon.Theme.Text,
			TextSize = 18,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = title
		})

		Create("TextLabel", {
			Parent = bg,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 64, 0, 34),
			Size = UDim2.new(1, -80, 0, 36),
			Font = Enum.Font.Gotham,
			TextColor3 = Silicon.Theme.Secondary,
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = content
		})

		--=============================================
		-- TIMER BAR
		--=============================================

		local barBG = Create("Frame", {
			Parent = bg,
			BackgroundColor3 = Silicon.Theme.BarBG,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 10, 1, -8),
			Size = UDim2.new(1, -20, 0, 3)
		})
		Create("UICorner", {Parent = barBG, CornerRadius = UDim.new(0, 3)})

		local bar = Create("Frame", {
			Parent = barBG,
			BackgroundColor3 = accentColor,
			Size = UDim2.new(0, 0, 1, 0)
		})
		Create("UICorner", {Parent = bar, CornerRadius = UDim.new(0, 3)})

		--=============================================
		-- CLOSE BUTTON
		--=============================================

		local close = Create("TextButton", {
			Parent = bg,
			BackgroundTransparency = 1,
			Text = "×",
			Font = Enum.Font.GothamBold,
			TextScaled = true,
			Size = UDim2.new(0, 16, 0, 16),
			Position = UDim2.new(1, -26, 0, 10),
			TextColor3 = Silicon.Theme.Secondary
		})

		close.MouseEnter:Connect(function()
			Tween(close, 0.15, {TextColor3 = Color3.fromRGB(255,80,80)}):Play()
		end)

		close.MouseLeave:Connect(function()
			Tween(close, 0.15, {TextColor3 = Silicon.Theme.Secondary}):Play()
		end)

		--=============================================
		-- SOUND
		--=============================================

		if Silicon.NotificationSoundEnabled and not mute then
			local snd = Create("Sound", {
				SoundId = data.Sound or "rbxassetid://1788243907",
				Volume = 1,
				PlayOnRemove = true,
				Parent = SoundService
			})
			snd:Destroy()
		end

		--=============================================
		-- STACK MANAGEMENT
		--=============================================

		table.insert(Notifications, 1, {Gui = gui, BG = bg})

		for i, note in ipairs(Notifications) do
			if i > customMax then
				table.remove(Notifications, i)
				note.Gui:Destroy()
			else
				local y = Silicon.BaseOffsetY - (i - 1) * (bg.Size.Y.Offset + Silicon.Spacing)
				Tween(note.BG, Silicon.AnimationTime, {Position = UDim2.new(1, -16, 1, y)}):Play()
			end
		end

		Tween(bg, Silicon.AnimationTime, {Position = UDim2.new(1, -16, 1, Silicon.BaseOffsetY)}):Play()
		Tween(bar, duration, {Size = UDim2.new(1, 0, 1, 0)}):Play()

		--=============================================
		-- DISMISS LOGIC
		--=============================================

		local dismissed = false
		
		local function dismiss()
			if dismissed then return end
			dismissed = true

			local t = Tween(bg, Silicon.AnimationTime, {
				Position = UDim2.new(1, 320, 1, Silicon.BaseOffsetY)
			})
			t:Play()
			t.Completed:Wait()

			for i, note in ipairs(Notifications) do
				if note.Gui == gui then
					table.remove(Notifications, i)
					break
				end
			end

			gui:Destroy()

			for i, note in ipairs(Notifications) do
				local y = Silicon.BaseOffsetY - (i - 1) * (note.BG.Size.Y.Offset + Silicon.Spacing)
				Tween(note.BG, 0.25, {Position = UDim2.new(1, -16, 1, y)}):Play()
			end
		end

		-- Click event
		if onClick then
			bg.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					onClick()
				end
			end)
		end

		close.MouseButton1Click:Connect(dismiss)
		task.delay(duration + 0.1, dismiss)
	end)
end

return Silicon
