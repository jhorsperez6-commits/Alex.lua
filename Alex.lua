local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("FullDeviceBlockGui") then
	playerGui.FullDeviceBlockGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FullDeviceBlockGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999
screenGui.Parent = playerGui

-- Fondo oscuro a pantalla completa que bloquea toques detrás
local backdrop = Instance.new("TextButton")
backdrop.Size = UDim2.new(1, 0, 1, 0)
backdrop.Position = UDim2.new(0, 0, 0, 0)
backdrop.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
backdrop.BackgroundTransparency = 0
backdrop.Text = ""
backdrop.AutoButtonColor = false
backdrop.Active = true
backdrop.Parent = screenGui

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 320, 0, 130)
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.Position = UDim2.new(0.5, 0, 0.5, 0)
box.BackgroundColor3 = Color3.fromRGB(24, 24, 29)
box.BorderSizePixel = 0
box.Parent = backdrop

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = box

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(58, 58, 66)
stroke.Thickness = 1
stroke.Parent = box

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -24, 0, 26)
title.Position = UDim2.new(0, 12, 0, 14)
title.BackgroundTransparency = 1
title.Text = "REQUISITO DE DISPOSITIVO"
title.TextColor3 = Color3.fromRGB(225, 225, 232)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = box

local message = Instance.new("TextLabel")
message.Size = UDim2.new(1, -28, 0, 56)
message.Position = UDim2.new(0, 14, 0, 46)
message.BackgroundTransparency = 1
message.Text = "Solo para iPhone 13 para arriba"
message.TextColor3 = Color3.fromRGB(185, 185, 194)
message.Font = Enum.Font.Gotham
message.TextSize = 14
message.TextWrapped = true
message.Parent = box
