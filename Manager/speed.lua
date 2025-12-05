local VenyxLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Documantation12/Universal-Vehicle-Script/main/Library.lua"))()
local Venyx = VenyxLibrary.new("Silicon | Speed Modifier")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Theme = {
	Background = Color3.fromRGB(15, 15, 15), 
	Glow = Color3.fromRGB(0, 0, 0), 
	Accent = Color3.fromRGB(18, 18, 18), 
	LightContrast = Color3.fromRGB(18, 18, 18), 
	DarkContrast = Color3.fromRGB(20, 20, 20),  
	TextColor = Color3.fromRGB(230, 230, 230)
}

for index, value in pairs(Theme) do
	pcall(Venyx.setTheme, Venyx, index, value)
end

local function GetVehicleFromDescendant(Descendant)
    return Descendant:FindFirstAncestor(LocalPlayer.Name .. "\'s Car") or
           (Descendant:FindFirstAncestor("Body") and Descendant:FindFirstAncestor("Body").Parent) or
           (Descendant:FindFirstAncestor("Misc") and Descendant:FindFirstAncestor("Misc").Parent) or
           Descendant:FindFirstAncestorWhichIsA("Model")
end

local function TeleportVehicle(CoordinateFrame: CFrame)
	local Parent = LocalPlayer.Character.Parent
	local Vehicle = GetVehicleFromDescendant(LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").SeatPart)
	LocalPlayer.Character.Parent = Vehicle
	local success, response = pcall(function()
		return Vehicle:SetPrimaryPartCFrame(CoordinateFrame)
	end)
	if not success then
		return Vehicle:MoveTo(CoordinateFrame.Position)
	end
end


local vehiclePage = Venyx:addPage("Vehicle", 8356815386)
local usageSection = vehiclePage:addSection("Usage")
local velocityEnabled = true;
usageSection:addToggle("Keybinds Active", velocityEnabled, function(v) velocityEnabled = v end)
local flightSection = vehiclePage:addSection("Flight")
local flightEnabled = false
local flightSpeed = 1
flightSection:addToggle("Enabled", false, function(v) flightEnabled = v end)
flightSection:addSlider("Speed", 100, 0, 800, function(v) flightSpeed = v / 100 end)
local defaultCharacterParent 
RunService.Stepped:Connect(function()
	local Character = LocalPlayer.Character
	if flightEnabled == true then
		if Character and typeof(Character) == "Instance" then
			local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
			if Humanoid and typeof(Humanoid) == "Instance" then
				local SeatPart = Humanoid.SeatPart
				if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
					local Vehicle = GetVehicleFromDescendant(SeatPart)
					if Vehicle and Vehicle:IsA("Model") then
						Character.Parent = Vehicle
						if not Vehicle.PrimaryPart then
							if SeatPart.Parent == Vehicle then
								Vehicle.PrimaryPart = SeatPart
							else
								Vehicle.PrimaryPart = Vehicle:FindFirstChildWhichIsA("BasePart")
							end
						end
						local PrimaryPartCFrame = Vehicle:GetPrimaryPartCFrame()
						local move = Vector3.new(
							(UserInputService:IsKeyDown(Enum.KeyCode.D) and flightSpeed) or (UserInputService:IsKeyDown(Enum.KeyCode.A) and -flightSpeed) or 0,
							(UserInputService:IsKeyDown(Enum.KeyCode.E) and flightSpeed / 2) or (UserInputService:IsKeyDown(Enum.KeyCode.Q) and -flightSpeed / 2) or 0,
							(UserInputService:IsKeyDown(Enum.KeyCode.S) and flightSpeed) or (UserInputService:IsKeyDown(Enum.KeyCode.W) and -flightSpeed) or 0
						)

						local finalCF = CFrame.new(PrimaryPartCFrame.Position, PrimaryPartCFrame.Position + workspace.CurrentCamera.CFrame.LookVector) *
							(UserInputService:GetFocusedTextBox() and CFrame.new(0,0,0) or CFrame.new(move.X, move.Y, move.Z))

						Vehicle:SetPrimaryPartCFrame(finalCF)
						SeatPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						SeatPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					end
				end
			end
		end
	else
		if Character and typeof(Character) == "Instance" then
			Character.Parent = defaultCharacterParent or Character.Parent
			defaultCharacterParent = Character.Parent
		end
	end
end)
local speedSection = vehiclePage:addSection("Acceleration")
local velocityMult = 0.025;
speedSection:addSlider("Multiplier (Thousandths)", 25, 0, 50, function(v) velocityMult = v / 1000; end)
local velocityEnabledKeyCode = Enum.KeyCode.W;
speedSection:addKeybind("Velocity Enabled", velocityEnabledKeyCode, function()
	if not velocityEnabled then
		return
	end
	while UserInputService:IsKeyDown(velocityEnabledKeyCode) do
		task.wait(0)
		local Character = LocalPlayer.Character
		if Character and typeof(Character) == "Instance" then
			local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
			if Humanoid and typeof(Humanoid) == "Instance" then
				local SeatPart = Humanoid.SeatPart
				if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
					SeatPart.AssemblyLinearVelocity *= Vector3.new(1 + velocityMult, 1, 1 + velocityMult)
				end
			end
		end
		if not velocityEnabled then
			break
		end
	end
end, function(v) velocityEnabledKeyCode = v.KeyCode end)
local decelerateSelection = vehiclePage:addSection("Deceleration")
local qbEnabledKeyCode = Enum.KeyCode.S
local velocityMult2 = 150e-3
decelerateSelection:addSlider("Brake Force (Thousandths)", velocityMult2*1e3, 0, 300, function(v) velocityMult2 = v / 1000; end)
decelerateSelection:addKeybind("Quick Brake Enabled", qbEnabledKeyCode, function()
	if not velocityEnabled then
		return
	end
	while UserInputService:IsKeyDown(qbEnabledKeyCode) do
		task.wait(0)
		local Character = LocalPlayer.Character
		if Character and typeof(Character) == "Instance" then
			local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
			if Humanoid and typeof(Humanoid) == "Instance" then
				local SeatPart = Humanoid.SeatPart
				if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
					SeatPart.AssemblyLinearVelocity *= Vector3.new(1 - velocityMult2, 1, 1 - velocityMult2)
				end
			end
		end
		if not velocityEnabled then
			break
		end
	end
end, function(v) qbEnabledKeyCode = v.KeyCode end)
decelerateSelection:addKeybind("Stop the Vehicle", Enum.KeyCode.P, function(v)
	if not velocityEnabled then
		return
	end
	local Character = LocalPlayer.Character
	if Character and typeof(Character) == "Instance" then
		local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
		if Humanoid and typeof(Humanoid) == "Instance" then
			local SeatPart = Humanoid.SeatPart
			if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
				SeatPart.AssemblyLinearVelocity *= Vector3.new(0, 0, 0)
				SeatPart.AssemblyAngularVelocity *= Vector3.new(0, 0, 0)
			end
		end
	end
end)

local infoPage = Venyx:addPage("Information", 8356778308)
local toggleSection = infoPage:addSection("Menu Toggle")
toggleSection:addToggle("Show/Hide Menu with CTRL", true, function(v)
    if v then
        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
            if input.KeyCode == Enum.KeyCode.LeftControl and not gameProcessedEvent then
                Venyx:toggle()
            end
        end)
    end
end)  

local function CloseGUI()
    Venyx:toggle()
end
