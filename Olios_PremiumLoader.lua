--[[ 
    OLIOS PREMIUM HUB
    Premium Loader + Verify
]]

-- ===== BOOT =====
repeat task.wait() until game:IsLoaded()

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer

-- ===== CONFIG =====
local API_BASE = "https://oliosbkit.onrender.com"
local KEY = getgenv().Key

if not KEY then
    LocalPlayer:Kick("Missing Key")
    return
end

-- ===== HWID =====
local HWID = "UNKNOWN"
pcall(function()
    HWID = game:GetService("RbxAnalyticsService"):GetClientId()
end)

-- ===== VERIFY =====
local function VerifyKey()
    local url =
        API_BASE ..
        "/api/verify?key=" ..
        HttpService:UrlEncode(KEY) ..
        "&hwid=" ..
        HttpService:UrlEncode(HWID)

    for i = 1, 3 do
        local ok, body = pcall(function()
            return game:HttpGet(url)
        end)

        if ok and body then
            local success, data = pcall(function()
                return HttpService:JSONDecode(body)
            end)

            if success and data then
                if data.success then
                    return true
                else
                    LocalPlayer:Kick(data.message or "Key Invalid")
                    return false
                end
            end
        end

        task.wait(2)
    end

    LocalPlayer:Kick("API Error (Timeout)")
    return false
end

-- ===== RUN =====
if not VerifyKey() then
    return
end

-- ===== LOAD UI =====
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "OLIOS PREMIUM HUB",
    SubTitle = "By Olios",
    TabWidth = 160,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 320),
    MinimizeKey = Enum.KeyCode.End
})

Window:AddTab({ Title = "Home" })
Window:AddTab({ Title = "Main" })
Window:AddTab({ Title = "Setting" })
