-- Nigga Lib v1 (simple, clean, draggable, with close button)

local NiggaLib = {}
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NiggaLib"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -60, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "nigga lib"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 18
titleText.Parent = titleBar

-- Close button (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -40, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Parent = titleBar

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

closeButton.MouseEnter:Connect(function()
	closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	closeButton.BackgroundTransparency = 0.8
end)

closeButton.MouseLeave:Connect(function()
	closeButton.BackgroundTransparency = 1
end)

-- Content area (you put your tabs/buttons here)
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -50)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.Parent = mainFrame

-- Example tab system
local TabHandler = {}
local tabButtons = Instance.new("Frame")
tabButtons.Size = UDim2.new(1, 0, 0, 35)
tabButtons.BackgroundTransparency = 1
tabButtons.Parent = content

local tabContent = Instance.new("Frame")
tabContent.Size = UDim2.new(1, 0, 1, -40)
tabContent.Position = UDim2.new(0, 0, 0, 40)
tabContent.BackgroundTransparency = 1
tabContent.Parent = content

function NiggaLib:CreateTab(name)
	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(0, 100, 1, 0)
	tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	tabBtn.Text = name
	tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabBtn.Font = Enum.Font.Gotham
	tabBtn.Parent = tabButtons
	tabBtn.AutoButtonColor = false

	local tabFrame = Instance.new("Frame")
	tabFrame.Size = UDim2.new(1, 0, 1, 0)
	tabFrame.BackgroundTransparency = 1
	tabFrame.Visible = false
	tabFrame.Parent = tabContent

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = tabFrame

	tabBtn.MouseButton1Click:Connect(function()
		for _, v in ipairs(tabContent:GetChildren()) do
			if v:IsA("Frame") then v.Visible = false end
		end
		tabFrame.Visible = true
	end)

	if #tabButtons:GetChildren() == 1 then
		tabFrame.Visible = true
	end

	return setmetatable({
		AddButton = function(self, text, callback)
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 35)
			btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			btn.Text = text
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.Font = Enum.Font.Gotham
			btn.Parent = tabFrame

			btn.MouseButton1Click:Connect(callback or function() end)
		end,
		AddToggle = function(self, text, callback)
			local toggleFrame = Instance.new("Frame")
			toggleFrame.Size = UDim2.new(1, 0, 0, 35)
			toggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			toggleFrame.Parent = tabFrame

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -60, 1, 0)
			label.BackgroundTransparency = 1
			label.Text = text
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Font = Enum.Font.Gotham
			label.Parent = toggleFrame

			local toggle = Instance.new("TextButton")
			toggle.Size = UDim2.new(0, 40, 0, 20)
			toggle.Position = UDim2.new(1, -50, 0.5, -10)
			toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			toggle.Text = ""
			toggle.Parent = toggleFrame

			local corner = Instance.new("UICorner", toggle)
			corner.CornerRadius = UDim.new(0, 10)

			local state = false
			toggle.MouseButton1Click:Connect(function()
				state = not state
				toggle.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
				if callback then callback(state) end
			end)
		end
	}, {__index = TabHandler})
end

return NiggaLib
