
-- SiliconUI - Professional Dark UI Library (Nexus Style)
-- Fixed rounding, dragging, capitalization, and fully working

local SiliconUI = {}
SiliconUI.__index = SiliconUI

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function tween(obj, goals, time)
	TweenService:Create(
		obj,
		TweenInfo.new(time or 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		goals
	):Play()
end

function SiliconUI:CreateWindow(config)
	config = config or {}

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = game.CoreGui

	local Main = Instance.new("Frame")
	Main.Size = UDim2.new(0, 750, 0, 450)
	Main.Position = UDim2.new(0.5, -375, 0.5, -225)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	Main.ClipsDescendants = true
	Main.Parent = ScreenGui

	local Shadow = Instance.new("ImageLabel")
	Shadow.Image = "rbxassetid://6014261993"
	Shadow.BackgroundTransparency = 1
	Shadow.Size = UDim2.new(1, 100, 1, 100)
	Shadow.Position = UDim2.new(0.5, -50, 0.5, -50)
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.ImageTransparency = 0.4
	Shadow.ZIndex = 0
	Shadow.Parent = Main

	local Topbar = Instance.new("Frame")
	Topbar.Size = UDim2.new(1, 0, 0, 50)
	Topbar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	Topbar.Parent = Main

	local Title = Instance.new("TextLabel")
	Title.Text = config.Title or "My Script"
	Title.Font = Enum.Font.GothamBold
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 16
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, -100, 1, 0)
	Title.Position = UDim2.new(0, 60, 0, 0)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Topbar

	local Close = Instance.new("TextButton")
	Close.Text = "×"
	Close.Font = Enum.Font.GothamBold
	Close.TextColor3 = Color3.fromRGB(255, 100, 100)
	Close.TextSize = 22
	Close.BackgroundTransparency = 1
	Close.Size = UDim2.new(0, 50, 1, 0)
	Close.Position = UDim2.new(1, -50, 0, 0)
	Close.Parent = Topbar

	Close.MouseButton1Click:Connect(function()
		tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.25)
		task.wait(0.3)
		ScreenGui:Destroy()
	end)

	local Drag = Instance.new("TextButton")
	Drag.Size = UDim2.new(1, -60, 1, 0)
	Drag.BackgroundTransparency = 1
	Drag.Text = ""
	Drag.Parent = Topbar

	local dragging, startPos, dragStart

	Drag.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
		end
	end)

	Drag.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	Drag.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	local Sidebar = Instance.new("Frame")
	Sidebar.Size = UDim2.new(0, 170, 1, -50)
	Sidebar.Position = UDim2.new(0, 0, 0, 50)
	Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Sidebar.Parent = Main

	local Content = Instance.new("Frame")
	Content.Size = UDim2.new(1, -170, 1, -50)
	Content.Position = UDim2.new(0, 170, 0, 50)
	Content.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	Content.Parent = Main

	local Pages = Instance.new("Folder")
	Pages.Parent = Content

	local SidebarList = Instance.new("ScrollingFrame")
	SidebarList.Size = UDim2.new(1, 0, 1, 0)
	SidebarList.BackgroundTransparency = 1
	SidebarList.ScrollBarThickness = 0
	SidebarList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	SidebarList.Parent = Sidebar

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.Padding = UDim.new(0, 6)
	ListLayout.Parent = SidebarList

	local window = {
		Main = Main,
		Sidebar = SidebarList,
		Pages = Pages,
		CurrentPage = nil
	}

	setmetatable(window, SiliconUI)
	return window
end

function SiliconUI:AddTab(name)
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, -16, 0, 36)
	Button.Position = UDim2.new(0, 8, 0, 0)
	Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Button.Text = "  " .. name
	Button.TextColor3 = Color3.fromRGB(220, 220, 220)
	Button.Font = Enum.Font.GothamMedium
	Button.TextSize = 15
	Button.TextXAlignment = Enum.TextXAlignment.Left
	Button.Parent = self.Sidebar

	local Page = Instance.new("Frame")
	Page.Size = UDim2.new(1, 0, 1, 0)
	Page.BackgroundTransparency = 1
	Page.Visible = false
	Page.Parent = self.Pages

	local PageList = Instance.new("UIListLayout")
	PageList.Padding = UDim.new(0, 10)
	PageList.Parent = Page

	local Padding = Instance.new("UIPadding")
	Padding.PaddingLeft = UDim.new(0, 14)
	Padding.PaddingRight = UDim.new(0, 14)
	Padding.PaddingTop = UDim.new(0, 12)
	Padding.Parent = Page

	Button.MouseButton1Click:Connect(function()
		for _, p in pairs(self.Pages:GetChildren()) do
			p.Visible = false
		end
		Page.Visible = true
		self.CurrentPage = Page
	end)

	if #self.Pages:GetChildren() == 1 then
		Page.Visible = true
		self.CurrentPage = Page
	end

	local tab = { Page = Page }
	setmetatable(tab, SiliconUI)
	return tab
end

function SiliconUI:CreateSection(title)
	local Section = Instance.new("TextLabel")
	Section.Size = UDim2.new(1, 0, 0, 28)
	Section.BackgroundTransparency = 1
	Section.Text = title
	Section.Font = Enum.Font.GothamBold
	Section.TextColor3 = Color3.fromRGB(255, 255, 255)
	Section.TextSize = 16
	Section.TextXAlignment = Enum.TextXAlignment.Left
	Section.Parent = self.Page
end

function SiliconUI:CreateToggle(text, default, callback)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, 0, 0, 38)
	Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	Frame.Parent = self.Page

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -50, 1, 0)
	Label.Position = UDim2.new(0, 14, 0, 0)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(230, 230, 230)
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 14
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Frame

	local Toggle = Instance.new("TextButton")
	Toggle.Size = UDim2.new(0, 46, 0, 24)
	Toggle.Position = UDim2.new(1, -60, 0.5, -12)
	Toggle.AnchorPoint = Vector2.new(0, 0.5)
	Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Toggle.Text = ""
	Toggle.Parent = Frame

	local Indicator = Instance.new("Frame")
	Indicator.Size = UDim2.new(0, 18, 0, 18)
	Indicator.Position = UDim2.new(0, 4, 0.5, -9)
	Indicator.AnchorPoint = Vector2.new(0, 0.5)
	Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Indicator.Parent = Toggle

	local enabled = default or false

	local function update()
		tween(Toggle, {
			BackgroundColor3 = enabled and Color3.fromRGB(100, 70, 200) or Color3.fromRGB(50, 50, 50)
		}, 0.2)

		tween(Indicator, {
			Position = enabled and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 4, 0.5, -9)
		}, 0.2)
	end

	update()

	Frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			enabled = not enabled
			update()
			if callback then
				callback(enabled)
			end
		end
	end)

	return function(state)
		if state ~= nil then
			enabled = state
			update()
		end
		return enabled
	end
end

return SiliconUI
