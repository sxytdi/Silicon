local Remote = Instance.new("RemoteEvent")
Remote.Name = "BanMe"
Remote.Parent = game:GetService("ReplicatedStorage")

Remote.OnServerEvent:Connect(function(player)
    warn("[ANTI-EXPLOIT] "..player.Name.." ("..player.UserId..") tried to fire BanMe")
    player:Kick("\n\nBYPASSING DETECTED\n\nYou have been permanently banned for attempting to exploit.\nReason: Fired protected remote 'BanMe'\n\nAppeal at: nowhere lmao")
end)

print("BanMe trap loaded - exploiters = rekt")
