local allowed = {
    ["Solara"] = true,
    ["Swift"] = true,
    ["Velocity"] = true,
    ["Seliware"] = true,
    ["Wave"] = true,
    ["AWP"] = true,
    ["MacSploit"] = true,
    ["Hydrogen"] = true,
    ["Delta"] = true,
    ["Xeno"] = true,
    ["YuBX"] = true,
}

local exec = getexecutorname and getexecutorname() or "Unknown"
if not allowed[exec] then
    game.Players.LocalPlayer:Kick("Executor not whitelisted.")
    return
end

if game.PlaceId == 891852901 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sxyf82/Silicon/refs/heads/main/Greenville/main.lua", true))()
elseif game.PlaceId == 891852901 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sxyf82/Silicon/refs/heads/main/BladeBall/main.lua", true))()
end
