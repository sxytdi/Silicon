local Silicon = {}
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Notifications = {}
local MaxVisible, NotificationSpacing, BaseY = 4, 12, -20

function Silicon:Notify(tbl)
	task.spawn(function()
		local TitleText = tbl.Title or "Notification"
		local ContentText = tbl.Content or "Message"

		local gui = Instance.new("ScreenGui")
		gui.Name = "SiliconNotifications"
		gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		local BG = Instance.new("Frame")
		BG.Parent = gui
		BG.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
		BG.BorderSizePixel = 0
		BG.AnchorPoint = Vector2.new(1, 1)
		BG.Size = UDim2.new(0, 320, 0, 96)
		BG.Position = UDim2.new(1, 340, 1, BaseY)
		BG.ClipsDescendants = true

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 12)
		Corner.Parent = BG

		local Shadow = Instance.new("ImageLabel")
		Shadow.Parent = BG
		Shadow.BackgroundTransparency = 1
		Shadow.Position = UDim2.new(0, -12, 0, -12)
		Shadow.Size = UDim2.new(1, 24, 1, 24)
		Shadow.Image = "rbxassetid://1316045217"
		Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		Shadow.ImageTransparency = 0.82
		Shadow.ScaleType = Enum.ScaleType.Slice
		Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
		Shadow.ZIndex = 0

		local IconWrap = Instance.new("Frame")
		IconWrap.Parent = BG
		IconWrap.BackgroundColor3 = Color3.fromRGB(26, 30, 36)
		IconWrap.Position = UDim2.new(0, 18, 0, 20)
		IconWrap.Size = UDim2.new(0, 44, 0, 44)

		local IconCorner = Instance.new("UICorner")
		IconCorner.CornerRadius = UDim.new(1, 0)
		IconCorner.Parent = IconWrap

		local IconStroke = Instance.new("UIStroke")
		IconStroke.Color = Color3.fromRGB(0,170,255)
		IconStroke.Transparency = 0
		IconStroke.Thickness = 1.4
		IconStroke.Parent = IconWrap

		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.Parent = IconWrap
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Size = UDim2.new(0, 26, 0, 26)
		ImageLabel.Position = UDim2.new(0.5, -13, 0.5, -13)
		ImageLabel.Image = "rbxassetid://124780615486303"
		ImageLabel.ImageTransparency = 0

		local Title = Instance.new("TextLabel")
		Title.Parent = BG
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, 78, 0, 22)
		Title.Size = UDim2.new(1, -120, 0, 28)
		Title.Font = Enum.Font.GothamBold
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextTransparency = 0.03
		Title.TextSize = 19
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.TextYAlignment = Enum.TextYAlignment.Top
		Title.TextWrapped = true
		Title.Text = TitleText

		local Description = Instance.new("TextLabel")
		Description.Parent = BG
		Description.BackgroundTransparency = 1
		Description.Position = UDim2.new(0, 78, 0, 48)
		Description.Size = UDim2.new(1, -120, 0, 40)
		Description.Font = Enum.Font.Gotham
		Description.TextColor3 = Color3.fromRGB(210, 210, 210)
		Description.TextTransparency = 0.08
		Description.TextSize = 13
		Description.TextXAlignment = Enum.TextXAlignment.Left
		Description.TextYAlignment = Enum.TextYAlignment.Top
		Description.TextWrapped = true
		Description.Text = ContentText

		local BarBG = Instance.new("Frame")
		BarBG.Parent = BG
		BarBG.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
		BarBG.BorderSizePixel = 0
		BarBG.Position = UDim2.new(0, 14, 1, -8)
		BarBG.Size = UDim2.new(1, -28, 0, 3)
		BarBG.ZIndex = 3

		local BarBGCorner = Instance.new("UICorner")
		BarBGCorner.CornerRadius = UDim.new(0, 3)
		BarBGCorner.Parent = BarBG

		local Bar = Instance.new("Frame")
		Bar.Parent = BarBG
		Bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		Bar.BorderSizePixel = 0
		Bar.Position = UDim2.new(0, 0, 0, 0)
		Bar.Size = UDim2.new(0, 0, 1, 0)
		Bar.ZIndex = 4

		local BarCorner = Instance.new("UICorner")
		BarCorner.CornerRadius = UDim.new(0, 3)
		BarCorner.Parent = Bar

		local CloseWrap = Instance.new("Frame")
		CloseWrap.Parent = BG
		CloseWrap.BackgroundTransparency = 1
		CloseWrap.Position = UDim2.new(1, -28, 0, 12)
		CloseWrap.Size = UDim2.new(0, 16, 0, 16)
		CloseWrap.ZIndex = 6

		local LineA = Instance.new("Frame")
		LineA.Parent = CloseWrap
		LineA.AnchorPoint = Vector2.new(0.5,0.5)
		LineA.Position = UDim2.new(0.5,0,0.5,0)
		LineA.Size = UDim2.new(1, 0, 0, 2)
		LineA.BackgroundColor3 = Color3.fromRGB(185,185,190)
		LineA.BorderSizePixel = 0
		LineA.Rotation = 45

		local LineB = LineA:Clone()
		LineB.Parent = CloseWrap
		LineB.Rotation = -45

		local CloseHit = Instance.new("TextButton")
		CloseHit.Parent = CloseWrap
		CloseHit.BackgroundTransparency = 1
		CloseHit.Text = ""
		CloseHit.Size = UDim2.new(1,0,1,0)
		CloseHit.ZIndex = 7

		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://1788243907"
		s.Volume = 1
		s.PlayOnRemove = true
		s.Parent = SoundService
		s:Destroy()

		table.insert(Notifications, 1, { Gui = gui, BG = BG })

		for i, note in ipairs(Notifications) do
			local offsetY = BaseY - ((i - 1) * (BG.Size.Y.Offset + NotificationSpacing))
			TweenService:Create(note.BG, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(1, -20, 1, offsetY) }):Play()
			if i > MaxVisible then
				table.remove(Notifications, i)
				note.Gui:Destroy()
			end
		end

		TweenService:Create(BG, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -20, 1, BaseY), BackgroundTransparency = 0}):Play()
		TweenService:Create(Bar, TweenInfo.new(3.2, Enum.EasingStyle.Linear), { Size = UDim2.new(1, 0, 1, 0) }):Play()

		local hovering = false
		CloseHit.MouseEnter:Connect(function()
			if not hovering then
				hovering = true
				TweenService:Create(LineA, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
				TweenService:Create(LineB, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
			end
		end)

		CloseHit.MouseLeave:Connect(function()
			if hovering then
				hovering = false
				TweenService:Create(LineA, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(185,185,190)}):Play()
				TweenService:Create(LineB, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(185,185,190)}):Play()
			end
		end)

		local dismissed = false
		local function dismiss()
			if dismissed then return end
			dismissed = true
			local t1 = TweenService:Create(BG, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 340, 1, BaseY)})
			t1:Play()
			t1.Completed:Wait()
			for i, note in ipairs(Notifications) do
				if note.Gui == gui then
					table.remove(Notifications, i)
					break
				end
			end
			gui:Destroy()
			for i, note in ipairs(Notifications) do
				local offsetY = BaseY - ((i - 1) * (note.BG.Size.Y.Offset + NotificationSpacing))
				TweenService:Create(note.BG, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(1, -20, 1, offsetY) }):Play()
			end
		end

		CloseHit.MouseButton1Click:Connect(dismiss)
		task.delay(3.6, dismiss)
	end)
end

return Silicon
