local Players = game:GetService("Players")
local player = Players.LocalPlayer
while not player do
	task.wait()
	player = Players.LocalPlayer
end

local gui = Instance.new("ScreenGui")
gui.Name = "IPhoneNoCompatibleUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999

local parentOk = pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)
if not parentOk or not gui.Parent then
	gui.Parent = player:WaitForChild("PlayerGui")
end

local fondo = Instance.new("Frame")
fondo.Name = "FondoCompleto"
fondo.Size = UDim2.new(1, 0, 1, 0)
fondo.Position = UDim2.new(0, 0, 0, 0)
fondo.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
fondo.BackgroundTransparency = 0
fondo.BorderSizePixel = 0
fondo.ZIndex = 1000
fondo.Parent = gui

local tarjeta = Instance.new("Frame")
tarjeta.Name = "TarjetaAviso"
tarjeta.Size = UDim2.new(0.84, 0, 0, 150)
tarjeta.Position = UDim2.new(0.5, 0, 0.5, 0)
tarjeta.AnchorPoint = Vector2.new(0.5, 0.5)
tarjeta.BackgroundColor3 = Color3.fromRGB(18, 22, 29)
tarjeta.BorderSizePixel = 0
tarjeta.ZIndex = 1001
tarjeta.Parent = fondo

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = tarjeta

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(52, 62, 78)
stroke.Thickness = 1.2
stroke.Parent = tarjeta

local titulo = Instance.new("TextLabel")
titulo.Name = "MensajePrincipal"
titulo.Size = UDim2.new(1, -28, 0, 44)
titulo.Position = UDim2.new(0.5, 0, 0.42, 0)
titulo.AnchorPoint = Vector2.new(0.5, 0.5)
titulo.BackgroundTransparency = 1
titulo.Text = "iPhone no compatible"
titulo.Font = Enum.Font.GothamBold
titulo.TextSize = 22
titulo.TextColor3 = Color3.fromRGB(235, 240, 248)
titulo.TextScaled = false
titulo.ZIndex = 1002
titulo.Parent = tarjeta

local subtexto = Instance.new("TextLabel")
subtexto.Name = "Subtexto"
subtexto.Size = UDim2.new(1, -28, 0, 24)
subtexto.Position = UDim2.new(0.5, 0, 0.68, 0)
subtexto.AnchorPoint = Vector2.new(0.5, 0.5)
subtexto.BackgroundTransparency = 1
subtexto.Text = "Este script no es compatible con tu dispositivo"
subtexto.Font = Enum.Font.Gotham
subtexto.TextSize = 13
subtexto.TextColor3 = Color3.fromRGB(145, 156, 174)
subtexto.ZIndex = 1002
subtexto.Parent = tarjeta
