-- SiliconLib v1.1 - Clean, Blue UI with improved tabs

local SiliconLib = {}

local BLUE = Color3.fromRGB(0, 151, 215)
local DARK_BG = Color3.fromRGB(22, 22, 26)
local TAB_BG = Color3.fromRGB(35, 35, 40)
local TAB_HOVER = Color3.fromRGB(45, 45, 50)
local BTN_BG = Color3.fromRGB(40, 40, 48)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SiliconLib"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 420)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 10)

-- Drop shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = MainFrame.Size + UDim2.new(0, 40, 0, 40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = BLUE
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 10)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SiliconLib"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.Parent = TitleBar

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 45, 0, 45)
CloseButton.Position = UDim2.new(1, -45, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 26
CloseButton.Parent = TitleBar

CloseButton.MouseEnter:Connect(function()
	CloseButton.BackgroundTransparency = 0
	CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
end)

CloseButton.MouseLeave:Connect(function()
	CloseButton.BackgroundTransparency = 1
end)

CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Content container
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -60)
Content.Position = UDim2.new(0, 10, 0, 55)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Tabs
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, 0, 0, 40)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = Content

local TabLayout = Instance.new("UIListLayout", TabButtons)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 8)

local TabContent = Instance.new("Frame")
TabContent.Size = UDim2.new(1, 0, 1, -45)
TabContent.Position = UDim2.new(0, 0, 0, 45)
TabContent.BackgroundTransparency = 1
TabContent.Parent = Content

local CurrentTab = nil

function SiliconLib:CreateTab(name)
	local TabButton = Instance.new("TextButton")
	TabButton.Size = UDim2.new(0, 130, 1, 0)
	TabButton.BackgroundColor3 = TAB_BG
	TabButton.Text = name
	TabButton.TextColor3 = Color3.fromRGB(220, 220, 220)
	TabButton.Font = Enum.Font.GothamBold
	TabButton.TextSize = 15
	TabButton.AutoButtonColor = false
	TabButton.Parent = TabButtons

	local TabCorner = Instance.new("UICorner", TabButton)
	TabCorner.CornerRadius = UDim.new(0, 8)

	-- Hover effect
	TabButton.MouseEnter:Connect(function()
		if CurrentTab ~= TabButton.AssignedTab then
			TabButton.BackgroundColor3 = TAB_HOVER
		end
	end)

	TabButton.MouseLeave:Connect(function()
		if CurrentTab ~= TabButton.AssignedTab then
			TabButton.BackgroundColor3 = TAB_BG
		end
	end)

	local TabFrame = Instance.new("ScrollingFrame")
	TabFrame.Size = UDim2.new(1, 0, 1, 0)
	TabFrame.BackgroundTransparency = 1
	TabFrame.ScrollBarThickness = 4
	TabFrame.Visible = false
	TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabFrame.Parent = TabContent

	local Layout = Instance.new("UIListLayout", TabFrame)
	Layout.Padding = UDim.new(0, 8)
	Layout.SortOrder = Enum.SortOrder.LayoutOrder

	TabButton.AssignedTab = TabFrame

	TabButton.MouseButton1Click:Connect(function()
		if CurrentTab then
			CurrentTab.Visible = false
		end

		TabFrame.Visible = true
		CurrentTab = TabFrame

		-- Reset all tabs
		for _, btn in ipairs(TabButtons:GetChildren()) do
			if btn:IsA("TextButton") then
				btn.BackgroundColor3 = TAB_BG
				btn.TextColor3 = Color3.fromRGB(220, 220, 220)
			end
		end

		-- Selected tab
		TabButton.BackgroundColor3 = BLUE
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	-- Auto-select first tab
	if not CurrentTab then
		TabButton.BackgroundColor3 = BLUE
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabFrame.Visible = true
		CurrentTab = TabFrame
	end

	return {
		AddButton = function(_, text, callback)
			local Button = Instance.new("TextButton")
			Button.Size = UDim2.new(1, 0, 0, 42)
			Button.BackgroundColor3 = BTN_BG
			Button.Text = text
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.Font = Enum.Font.Gotham
			Button.TextSize = 16
			Button.Parent = TabFrame

			local BtnCorner = Instance.new("UICorner", Button)
			BtnCorner.CornerRadius = UDim.new(0, 8)

			Button.MouseEnter:Connect(function()
				Button.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
			end)
			Button.MouseLeave:Connect(function()
				Button.BackgroundColor3 = BTN_BG
			end)

			Button.MouseButton1Click:Connect(callback or function() end)
		end,

		AddToggle = function(_, text, default, callback)
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Size = UDim2.new(1, 0, 0, 42)
			ToggleFrame.BackgroundColor3 = BTN_BG
			ToggleFrame.Parent = TabFrame

			local ToggleCorner = Instance.new("UICorner", ToggleFrame)
			ToggleCorner.CornerRadius = UDim.new(0, 8)

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -70, 1, 0)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 16
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.Parent = ToggleFrame

			local Toggle = Instance.new("TextButton")
			Toggle.Size = UDim2.new(0, 50, 0, 25)
			Toggle.Position = UDim2.new(1, -62, 0.5, -12.5)
			Toggle.BackgroundColor3 = default and BLUE or Color3.fromRGB(70, 70, 80)
			Toggle.Text = ""
			Toggle.Parent = ToggleFrame

			local ToggleCorner2 = Instance.new("UICorner", Toggle)
			ToggleCorner2.CornerRadius = UDim.new(0, 12)

			local state = default or false

			Toggle.MouseButton1Click:Connect(function()
				state = not state
				Toggle.BackgroundColor3 = state and BLUE or Color3.fromRGB(70, 70, 80)
				if callback then callback(state) end
			end)
		end
	}
end

return SiliconLib
