-- LOAD FLUENT
local Fluent = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"
))()

-- SERVICES
local TweenService = game:GetService("TweenService")

-- WINDOW
local Window = Fluent:CreateWindow({
    Title = "Olios Hub | Blox Fruits By Hải Anh",
    SubTitle = "Hub Premium lifetime",
    Theme = "Dark",
    Size = UDim2.fromOffset(500, 320),
    MinimizeKey = Enum.KeyCode.RightControl
})

-- TABS
local Tabs = {
    Main = Window:AddTab({ Title = "Main" }),
    Farm = Window:AddTab({ Title = "Farm" }),
    Setting = Window:AddTab({ Title = "Setting" })
}

-- HUB STATE
getgenv().Hub = {
    Toggles = {
        AutoFarm = false
    }
}
local Hub = getgenv().Hub

--------------------------------------------------
-- TOGGLE (TRÒN – BẬT/TẮT)
--------------------------------------------------
local function CreateToggle(parent, title, default, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.fromOffset(260, 40)
    Toggle.BackgroundTransparency = 1
    Toggle.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.fromScale(0.6, 1)
    Label.BackgroundTransparency = 1
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.Parent = Toggle
local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.fromOffset(20, 20)
Icon.Position = UDim2.fromOffset(0, 10)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://ID_ICON" -- đổi ID ở đây
Icon.Parent = Toggle

-- Đẩy chữ sang phải cho khỏi đè icon
Label.Position = UDim2.fromOffset(26, 0)
Label.Size = UDim2.fromScale(0.5, 1)
    local Button = Instance.new("Frame")
    Button.Size = UDim2.fromOffset(44, 22)
    Button.Position = UDim2.fromScale(1, 0.5)
    Button.AnchorPoint = Vector2.new(1, 0.5)
    Button.BackgroundColor3 = Color3.fromRGB(70,70,70)
    Button.Parent = Toggle
    Instance.new("UICorner", Button).CornerRadius = UDim.new(1,0)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.fromOffset(18,18)
    Circle.Position = UDim2.fromOffset(2,2)
    Circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Circle.Parent = Button
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

    local state = default

local function refresh()
    TweenService:Create(
        Button,
        TweenInfo.new(0.2),
        {BackgroundColor3 = state and Color3.fromRGB(0,170,255) or Color3.fromRGB(70,70,70)}
    ):Play()

    TweenService:Create(
        Circle,
        TweenInfo.new(0.2),
        {Position = state and UDim2.fromOffset(24,2) or UDim2.fromOffset(2,2)}
    ):Play()

    -- ICON đổi màu theo toggle (style riêng)
    Icon.ImageColor3 = state
        and Color3.fromRGB(255,255,255)
        or Color3.fromRGB(150,150,150)

    if callback then
        callback(state)
    end
end

--------------------------------------------------
-- FARM UI
--------------------------------------------------
local FarmSection = Tabs.Farm:AddSection("Auto Farm")

CreateToggle(
    FarmSection,
    "Auto Farm",
    false,
    function(v)
        Hub.Toggles.AutoFarm = v
    end
)

--------------------------------------------------
-- DEBUG LOOP (CHƯA FARM THẬT)
--------------------------------------------------
task.spawn(function()
    while task.wait(1) do
        if Hub.Toggles.AutoFarm then
            print("[AUTO FARM] ON")
        else
            print("[AUTO FARM] OFF")
        end
    end
end)