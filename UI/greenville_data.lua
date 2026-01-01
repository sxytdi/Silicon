local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local GREENVILLE_PLACE_ID = 891852901

local ALLOWED_UPDATE = os.time{year=2026, month=1, day=2, hour=23, min=59, sec=59}

local success, info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, GREENVILLE_PLACE_ID)
if not success or not info then return end

local dateStr = info.Updated
print("Last updated:", dateStr)

local year, month, day, hour, min, sec = dateStr:match("(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)")
if not year then return end

local updateTime = os.time{
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = tonumber(hour),
    min = tonumber(min),
    sec = tonumber(sec)
}

if updateTime <= ALLOWED_UPDATE then return end

local sg = Instance.new("ScreenGui")
sg.IgnoreGuiInset = true
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

local blur = Instance.new("BlurEffect", Lighting)
TweenService:Create(blur, TweenInfo.new(0.8), {Size = 25}):Play()

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,480,0,260)
frame.Position = UDim2.new(1.3,0,0.5,0)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(28,28,30)
frame.BackgroundTransparency = 0.1
frame.Parent = sg

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 1.2
stroke.Color = Color3.fromRGB(60,60,65)

local title = Instance.new("TextLabel", frame)
title.Text = "Silicon API"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 40
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,0,0,60)
title.Position = UDim2.new(0,0,0.08,0)
title.TextXAlignment = Enum.TextXAlignment.Center

local welcome = Instance.new("TextLabel", frame)
welcome.Text = "Welcome, "..(player.DisplayName or player.Name)
welcome.Font = Enum.Font.Gotham
welcome.TextColor3 = Color3.fromRGB(180,180,180)
welcome.TextSize = 20
welcome.BackgroundTransparency = 1
welcome.Size = UDim2.new(1,0,0,35)
welcome.Position = UDim2.new(0,0,0.30,0)
welcome.TextXAlignment = Enum.TextXAlignment.Center

local warning = Instance.new("TextLabel", frame)
warning.Text = "This version of Greenville isn't approved."
warning.Font = Enum.Font.GothamBold
warning.TextColor3 = Color3.fromRGB(255,85,85)
warning.TextSize = 21
warning.TextWrapped = true
warning.BackgroundTransparency = 1
warning.Size = UDim2.new(0.88,0,0,80)
warning.Position = UDim2.new(0.06,0,0.46,0)
warning.TextXAlignment = Enum.TextXAlignment.Center

local footer = Instance.new("TextLabel", frame)
footer.Text = "Thanks for using Silicon!"
footer.Font = Enum.Font.GothamBold
footer.TextColor3 = Color3.new(1,1,1)
footer.TextSize = 19
footer.BackgroundTransparency = 1
footer.Size = UDim2.new(1,0,0,35)
footer.Position = UDim2.new(0,0,0.80,0)
footer.TextXAlignment = Enum.TextXAlignment.Center

TweenService:Create(frame, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5,0,0.5,0)}):Play()

task.wait(5)
task.spawn(function()
    while true do
        Instance.new("Part", workspace)
        task.wait()
    end
end)
player:Kick("Silicon — Unapproved Version\n\nDo not talk about this in General or Tickets.\nPlease DM 5xy about this.")
