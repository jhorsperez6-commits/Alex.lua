-- ==========================================
-- Alex Hub Completo
-- Alex_12alex28 | TikTok: alex@11
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
while not player do task.wait() player = Players.LocalPlayer end
local camera = workspace.CurrentCamera

-- ===================== SISTEMA DE KEY =====================
local KEY_OK = false
local VALID_KEYS = { ["Alex"] = true, ["alex"] = true }

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "AlexKeyUI"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.DisplayOrder = 10000
pcall(function() keyGui.Parent = game:GetService("CoreGui") end)
if not keyGui.Parent then keyGui.Parent = player:WaitForChild("PlayerGui") end

-- Fondo completamente transparente (sin pantalla negra)
local bg = Instance.new("Frame", keyGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundTransparency = 1
bg.BorderSizePixel = 0

-- Tarjeta con diseño sobrio y minimalista
local card = Instance.new("Frame", bg)
card.Size = UDim2.new(0, 340, 0, 390)
card.Position = UDim2.new(0.5, -170, 0.5, -195)
card.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
card.BorderSizePixel = 0
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)
local st = Instance.new("UIStroke", card)
st.Color = Color3.fromRGB(45, 45, 60)
st.Thickness = 1

local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 24)
title.BackgroundTransparency = 1
title.Text = "ALEX HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(220, 220, 230)

local subtitle = Instance.new("TextLabel", card)
subtitle.Size = UDim2.new(1, 0, 0, 16)
subtitle.Position = UDim2.new(0, 0, 0, 52)
subtitle.BackgroundTransparency = 1
subtitle.Text = "FLY EDITION · alex"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 11
subtitle.TextColor3 = Color3.fromRGB(120, 120, 140)

local avatarImg = Instance.new("ImageLabel", card)
avatarImg.Size = UDim2.new(0, 52, 0, 52)
avatarImg.Position = UDim2.new(0.5, -26, 0, 76)
avatarImg.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420"
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)
local avStroke = Instance.new("UIStroke", avatarImg)
avStroke.Color = Color3.fromRGB(55, 55, 75)
avStroke.Thickness = 1.5

-- Caja de "Sistema de key en trabajo"
local infoBox = Instance.new("Frame", card)
infoBox.Size = UDim2.new(0.88, 0, 0, 75)
infoBox.Position = UDim2.new(0.06, 0, 0, 142)
infoBox.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
infoBox.BorderSizePixel = 0
Instance.new("UICorner", infoBox).CornerRadius = UDim.new(0, 10)
local infoStroke = Instance.new("UIStroke", infoBox)
infoStroke.Color = Color3.fromRGB(38, 38, 52)

local infoTitle = Instance.new("TextLabel", infoBox)
infoTitle.Size = UDim2.new(1, -16, 0, 20)
infoTitle.Position = UDim2.new(0, 12, 0, 8)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "Sistema de key en trabajo"
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 12
infoTitle.TextColor3 = Color3.fromRGB(200, 200, 215)
infoTitle.TextXAlignment = Enum.TextXAlignment.Left

local infoDesc = Instance.new("TextLabel", infoBox)
infoDesc.Size = UDim2.new(1, -115, 0, 30)
infoDesc.Position = UDim2.new(0, 12, 0, 32)
infoDesc.BackgroundTransparency = 1
infoDesc.Text = "Sistema de key en trabajo"
infoDesc.Font = Enum.Font.Gotham
infoDesc.TextSize = 11
infoDesc.TextColor3 = Color3.fromRGB(140, 140, 165)
infoDesc.TextXAlignment = Enum.TextXAlignment.Left
infoDesc.TextScaled = true

local copyBtn = Instance.new("TextButton", infoBox)
copyBtn.Size = UDim2.new(0, 90, 0, 36)
copyBtn.Position = UDim2.new(1, -100, 0.5, -18)
copyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
copyBtn.Text = "Copy"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 13
copyBtn.TextColor3 = Color3.fromRGB(220, 220, 235)
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 8)

copyBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if setclipboard then
			setclipboard("Sistema de key en trabajo")
		end
	end)
	copyBtn.Text = "Copiado!"
	task.wait(1.5)
	copyBtn.Text = "Copy"
end)

-- Cuadro de texto limpio (solo "Enter your key...")
local keyBox = Instance.new("TextBox", card)
keyBox.Size = UDim2.new(0.88, 0, 0, 42)
keyBox.Position = UDim2.new(0.06, 0, 0, 230)
keyBox.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
keyBox.PlaceholderText = "Enter your key..."
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 13
keyBox.TextColor3 = Color3.fromRGB(240, 240, 245)
keyBox.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
keyBox.ClearTextOnFocus = false
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 10)
local boxStroke = Instance.new("UIStroke", keyBox)
boxStroke.Color = Color3.fromRGB(38, 38, 52)

local status = Instance.new("TextLabel", card)
status.Size = UDim2.new(1, 0, 0, 18)
status.Position = UDim2.new(0, 0, 0, 278)
status.BackgroundTransparency = 1
status.Text = ""
status.Font = Enum.Font.GothamMedium
status.TextSize = 12

-- Botón de Activar minimalista
local activateBtn = Instance.new("TextButton", card)
activateBtn.Size = UDim2.new(0.88, 0, 0, 46)
activateBtn.Position = UDim2.new(0.06, 0, 0, 302)
activateBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
activateBtn.Text = "ACTIVATE"
activateBtn.Font = Enum.Font.GothamBold
activateBtn.TextSize = 14
activateBtn.TextColor3 = Color3.fromRGB(240, 240, 245)
Instance.new("UICorner", activateBtn).CornerRadius = UDim.new(0, 10)

activateBtn.MouseButton1Click:Connect(function()
	local entered = keyBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
	if VALID_KEYS[entered] then
		status.Text = "¡Key Válida! Entrando..."
		status.TextColor3 = Color3.fromRGB(100, 220, 120)
		KEY_OK = true
		task.wait(0.4)
		keyGui:Destroy()
	else
		status.Text = "Key incorrecta"
		status.TextColor3 = Color3.fromRGB(255, 90, 90)
	end
end)

while not KEY_OK do task.wait(0.1) end

-- ===================== VARIABLES =====================
local fovVisiblePreference = false
local fovRadius = 120
local autoShootEnabled = false
local autoShootAgresivoEnabled = false
local autoShootTargetPart = "Cabeza"
local silentAimManualEnabled = false
local silentAimFovEnabled = false
local silentAimTargetPart = "Cabeza"
local teamCheckEnabled = true
local espEnabled = false
local espColor = Color3.fromRGB(255, 255, 255)
local espSettings = { Glow = true }
local hitboxEnabled = false
local hitboxInvisible = false
local hitboxSize = 3.5
local hitboxColor = Color3.fromRGB(255, 0, 0)
local hitboxRainbow = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AlexHub_Overlays"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.Parent = player:WaitForChild("PlayerGui")

local espFolder = Instance.new("Folder")
espFolder.Name = "AlexESPFolder"
espFolder.Parent = screenGui

-- ===================== WINDUI =====================
local WindUI
local okW, resultW = pcall(function()
	return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua"))()
end)
if not okW or not resultW then
	warn("Error WindUI: " .. tostring(resultW))
	return
end
WindUI = resultW

pcall(function()
	WindUI:AddTheme({
		Name = "AlexDarkCyan",
		Accent = Color3.fromHex("#38BDF8"),
		Dialog = Color3.fromHex("#111115"),
		Outline = Color3.fromHex("#262630"),
		Text = Color3.fromHex("#F1F5F9"),
		Placeholder = Color3.fromHex("#71717A"),
		Background = Color3.fromHex("#0D0D11"),
		Button = Color3.fromHex("#18181F"),
		Icon = Color3.fromHex("#38BDF8"),
	})
end)

local Window = WindUI:CreateWindow({
	Title = "Alex Hub - [ alex ]",
	Author = "Alex_12alex28 · alex@11",
	Folder = "AlexHub_Clean",
	Theme = "AlexDarkCyan",
	Acrylic = false,
	Transparent = false,
	NewElements = true,
	HideSearchBar = true,
	OpenButton = {
		Title = "Alex",
		Icon = "rbxassetid://7734053495",
		IconSize = 10,
		CornerRadius = UDim.new(0, 12),
		StrokeThickness = 2,
		Enabled = true,
		Draggable = true,
		Scale = 0.95,
		Color = ColorSequence.new(Color3.fromRGB(16, 16, 22), Color3.fromRGB(28, 34, 46))
	},
	Topbar = { Height = 44, ButtonsType = "Default" }
})

local MainSection = Window:Section({ Title = "Alex · alex", Icon = "solar:star-bold", Opened = true })

local Tabs = {
	Inicio = MainSection:Tab({ Title = "Info", Icon = "solar:info-circle-bold" }),
	Persona = MainSection:Tab({ Title = "Móvil", Icon = "solar:smartphone-bold" }),
	Aim = MainSection:Tab({ Title = "Aimbot", Icon = "solar:target-bold" }),
	Vis = MainSection:Tab({ Title = "ESP", Icon = "solar:eye-bold" }),
	Farm = MainSection:Tab({ Title = "Effects", Icon = "solar:magic-stick-3-bold" }),
	Animaciones = MainSection:Tab({ Title = "Tools", Icon = "solar:settings-bold" }),
}

-- ===================== HELPERS =====================
local COLORES_NEUTROS = {
	["White"] = true, ["Medium stone grey"] = true, ["Medium Stone Grey"] = true,
	["Really black"] = true, ["Really Black"] = true, ["Institutional white"] = true,
	["Institutional White"] = true, ["Ghost grey"] = true, ["Ghost Grey"] = true,
}
local marcaAliadoCache = {}
local ATTRS_ALIADO = {
	"IsAlly","Ally","AllyMarker","isAlly","is_ally","ally",
	"Teammate","isTeammate","IsTeammate","Friendly","isFriendly","IsFriendly"
}

local function tieneMarcaAliado(p)
	if not p then return false end
	local now = os.clock()
	local c = marcaAliadoCache[p]
	if c and (now - c.time) < 1 then return c.value end
	local r = false
	local char = p.Character
	for _, a in ipairs(ATTRS_ALIADO) do
		local v = p:GetAttribute(a)
		if v == true or v == "true" or v == "Ally" then r = true break end
		if char then
			local v2 = char:GetAttribute(a)
			if v2 == true or v2 == "true" or v2 == "Ally" then r = true break end
		end
	end
	marcaAliadoCache[p] = { value = r, time = now }
	return r
end

local function isEnemy(p)
	if not p or p == player then return false end
	if tieneMarcaAliado(p) then return false end
	if not teamCheckEnabled then return true end
	local a = player.TeamColor and player.TeamColor.Name or "White"
	local b = p.TeamColor and p.TeamColor.Name or "White"
	if not COLORES_NEUTROS[a] and not COLORES_NEUTROS[b] then
		return player.TeamColor ~= p.TeamColor
	end
	if player.Team and p.Team then return player.Team ~= p.Team end
	return true
end

local function estaEnLobby()
	local char = player.Character
	if not char then return true end
	if char:FindFirstChildOfClass("ForceField") then return true end
	if player.Team then
		local t = string.lower(player.Team.Name)
		if t:find("lobby") or t:find("spectat") or t:find("menu") or t:find("dead") then return true end
	end
	return false
end

local function IsInMatchStrict()
	local gui = player:FindFirstChild("PlayerGui")
	if not gui then return false end
	local main = gui:FindFirstChild("Main") or gui
	local gf = main:FindFirstChild("MainGameFrame")
	if not gf or not gf.Visible then return false end
	local score = gf:FindFirstChild("IngameScore")
	local timer = score and score:FindFirstChild("Timer")
	if not timer then return false end
	return tostring(timer.Text or ""):gsub("%s",""):match("^%d+:%d%d$") ~= nil
end

local function esEnemigoValido(p)
	if not p or p == player or not isEnemy(p) then return false end
	local char = p.Character
	if not char then return false end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then return false end
	if char:FindFirstChildOfClass("ForceField") then return false end
	return true
end

local function esCuchillo(item)
	if not item or not item:IsA("Tool") then return false end
	if item:FindFirstChild("Slash") or item:FindFirstChild("SlashStart") then return true end
	local n = string.lower(item.Name)
	return n:find("knife") or n:find("cuchillo") or n:find("dagger")
end

local function esPistola(item)
	if not item or not item:IsA("Tool") or esCuchillo(item) then return false end
	local n = string.lower(item.Name)
	for _, w in ipairs({"combat","fist","wallet","phone","punch","boombox","radio","knife","blade","cuchillo","dagger","sword"}) do
		if n:find(w) then return false end
	end
	return true
end

local function obtenerPistola()
	local char = player.Character
	local bp = player:FindFirstChildOfClass("Backpack")
	if char then for _, i in ipairs(char:GetChildren()) do if esPistola(i) then return i end end end
	if bp then for _, i in ipairs(bp:GetChildren()) do if esPistola(i) then return i end end end
	return nil
end

local function GetValidEnemies()
	local list = {}
	local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character and isEnemy(p) then
			local hum = p.Character:FindFirstChildOfClass("Humanoid")
			local root = p.Character:FindFirstChild("HumanoidRootPart")
			if hum and root and hum.Health > 0 then
				if not myRoot or (myRoot.Position - root.Position).Magnitude < 1500 then
					table.insert(list, p)
				end
			end
		end
	end
	return list
end

local function GetTargetPartFromChar(char, mode)
	if not char then return nil end
	if mode == "Cabeza" then return char:FindFirstChild("Head") end
	if mode == "Torso" then
		return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
	end
	for _, part in ipairs(char:GetChildren()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then return part end
	end
	return char:FindFirstChild("HumanoidRootPart")
end

local function IsInFOV(worldPos, radius)
	local screenPos, onScreen = camera:WorldToViewportPoint(worldPos)
	if not onScreen then return false end
	local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
	return (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude <= radius
end

-- ===================== INFO (INICIO) =====================
Tabs.Inicio:Section({ Title = "DASHBOARD", Icon = "solar:home-bold" })
local execName = "Desconocido"
pcall(function() execName = (identifyexecutor and identifyexecutor()) or "Desconocido" end)
local gameNameStr = "Desconocido"
pcall(function() gameNameStr = MarketplaceService:GetProductInfo(game.PlaceId).Name end)

Tabs.Inicio:Paragraph({
	Title = "Bienvenido de nuevo",
	Desc = player.DisplayName .. "\n@" .. player.Name .. "\n\nLo que necesitas solo en Alex Hub (alex)",
	Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420",
	ImageSize = 72
})
Tabs.Inicio:Space()
Tabs.Inicio:Divider()
Tabs.Inicio:Space()
Tabs.Inicio:Paragraph({ Title = "Alex UI Library", Desc = "Ejecutor: " .. execName .. "\nJuego: " .. gameNameStr })
Tabs.Inicio:Paragraph({ Title = "Tu cuenta", Desc = "ID: " .. player.UserId .. "\nEdad: " .. player.AccountAge .. " días" })
Tabs.Inicio:Paragraph({ Title = "Créditos", Desc = "Alex_12alex28 · alex@11" })

-- ===================== MÓVIL (PERSONA) =====================
local TopBar = Instance.new("Frame", screenGui)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
TopBar.Size = UDim2.new(0, 230, 0, 28)
TopBar.Position = UDim2.new(0.5, -115, 0.012, 0)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local ServerLabel = Instance.new("TextLabel", TopBar)
ServerLabel.Size = UDim2.new(0.5, 0, 1, 0)
ServerLabel.BackgroundTransparency = 1
ServerLabel.Font = Enum.Font.GothamBold
ServerLabel.Text = "Servidor: 0"
ServerLabel.TextColor3 = Color3.fromRGB(200, 200, 215)
ServerLabel.TextSize = 12

local EnemyLabel = Instance.new("TextLabel", TopBar)
EnemyLabel.Position = UDim2.new(0.5, 0, 0, 0)
EnemyLabel.Size = UDim2.new(0.5, 0, 1, 0)
EnemyLabel.BackgroundTransparency = 1
EnemyLabel.Font = Enum.Font.GothamBold
EnemyLabel.Text = "Enemigos: 0"
EnemyLabel.TextColor3 = Color3.fromRGB(255, 80, 90)
EnemyLabel.TextSize = 12

Tabs.Persona:Section({ Title = "Contadores", Icon = "solar:server-bold" })
Tabs.Persona:Paragraph({ Title = "Servidor / Enemigos", Desc = "Arriba en pantalla. Enemigos solo en partida." })

local function UpdatePersona()
	ServerLabel.Text = "Servidor: " .. #Players:GetPlayers()
	EnemyLabel.Text = IsInMatchStrict() and ("Enemigos: " .. #GetValidEnemies()) or "Enemigos: 0"
end

-- ===================== AIMBOT =====================
Tabs.Aim:Section({ Title = "Auto Shoot", Icon = "solar:target-bold" })
Tabs.Aim:Toggle({
	Title = "Auto Shoot (Normal)",
	Desc = "Dispara a cabeza/torso.",
	Callback = function(Value)
		autoShootEnabled = Value
		if not Value and not autoShootAgresivoEnabled and not silentAimManualEnabled then
			getgenv().AlexTargetPart = nil
		end
	end
})
Tabs.Aim:Toggle({
	Title = "Auto Shoot (Agresivo)",
	Desc = "Dispara a cualquier parte visible.",
	Callback = function(Value)
		autoShootAgresivoEnabled = Value
		if not Value and not autoShootEnabled and not silentAimManualEnabled then
			getgenv().AlexTargetPart = nil
		end
	end
})
Tabs.Aim:Dropdown({
	Title = "Target AutoShoot",
	Values = { "Cabeza", "Torso", "Cuerpo Completo" },
	Value = "Cabeza",
	Callback = function(Value) autoShootTargetPart = Value end
})

local equipGunEnabled = false
Tabs.Aim:Toggle({
	Title = "Equipar pistola",
	Value = false,
	Callback = function(Value) equipGunEnabled = Value end
})

task.spawn(function()
	local gunRayParams = RaycastParams.new()
	gunRayParams.FilterType = Enum.RaycastFilterType.Exclude
	while task.wait(0.1) do
		if not equipGunEnabled or not IsInMatchStrict() then continue end
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not char or not hum or hum.Health <= 0 then continue end
		local hrp = char:FindFirstChild("HumanoidRootPart")
		local head = char:FindFirstChild("Head")
		if not hrp then continue end
		local originPos = head and head.Position or hrp.Position
		local visible = false
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and esEnemigoValido(p) and p.Character then
				local tp = p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("HumanoidRootPart")
				if tp then
					gunRayParams.FilterDescendantsInstances = { char, p.Character }
					if not workspace:Raycast(originPos, tp.Position - originPos, gunRayParams) then
						visible = true break
					end
				end
			end
		end
		if not visible then continue end
		local pistola = obtenerPistola()
		if not pistola then continue end
		char = player.Character
		hum = char and char:FindFirstChildOfClass("Humanoid")
		if not char or not hum then continue end
		if pistola.Parent ~= char then pcall(function() hum:EquipTool(pistola) end) end
		task.wait(0.35)
		char = player.Character
		hum = char and char:FindFirstChildOfClass("Humanoid")
		if char and hum then pcall(function() hum:UnequipTools() end) end
		task.wait(1.9)
	end
end)

Tabs.Aim:Space()
Tabs.Aim:Divider()
Tabs.Aim:Section({ Title = "Silent Aim + FOV", Icon = "solar:radar-bold" })
Tabs.Aim:Toggle({
	Title = "Silent Aim",
	Desc = "Redirige las balas al enemigo.",
	Callback = function(Value)
		silentAimManualEnabled = Value
		if not Value and not autoShootEnabled and not autoShootAgresivoEnabled then
			getgenv().AlexTargetPart = nil
		end
	end
})
Tabs.Aim:Dropdown({
	Title = "Target Silent",
	Values = { "Cabeza", "Torso", "Cuerpo Completo" },
	Value = "Cabeza",
	Callback = function(Value) silentAimTargetPart = Value end
})
Tabs.Aim:Toggle({
	Title = "Silent Aim (FOV)",
	Desc = "Solo dentro del círculo FOV.",
	Callback = function(Value) silentAimFovEnabled = Value end
})
Tabs.Aim:Toggle({ Title = "Mostrar FOV", Callback = function(Value) fovVisiblePreference = Value end })
Tabs.Aim:Slider({
	Title = "Tamaño FOV",
	Step = 1,
	Value = { Min = 10, Max = 800, Default = 120 },
	Callback = function(v) fovRadius = v end
})

Tabs.Aim:Space()
Tabs.Aim:Divider()
Tabs.Aim:Section({ Title = "Hitbox", Icon = "solar:box-bold" })
Tabs.Aim:Toggle({
	Title = "Hitbox",
	Value = false,
	Callback = function(Value)
		hitboxEnabled = Value
		if not Value then
			for _, p in ipairs(Players:GetPlayers()) do
				local c = p.Character
				if c then
					local h = c:FindFirstChild("GhostHitbox")
					if h then h:Destroy() end
				end
			end
		end
	end
})
Tabs.Aim:Toggle({ Title = "Hitbox Invisible", Value = false, Callback = function(v) hitboxInvisible = v end })
Tabs.Aim:Slider({
	Title = "Tamaño Hitbox",
	Step = 0.5,
	Value = { Min = 1, Max = 15, Default = 3.5 },
	Callback = function(v) hitboxSize = math.clamp(v, 1, 15) end
})
Tabs.Aim:Colorpicker({
	Title = "Color Hitbox",
	Default = Color3.fromRGB(255, 0, 0),
	Callback = function(c) hitboxRainbow = false hitboxColor = c end
})
Tabs.Aim:Button({ Title = "Rojo", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(255, 0, 0) end })
Tabs.Aim:Button({ Title = "Verde", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(0, 255, 100) end })
Tabs.Aim:Button({ Title = "Azul", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(50, 150, 255) end })
Tabs.Aim:Button({ Title = "Blanco", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(255, 255, 255) end })
Tabs.Aim:Button({ Title = "Arcoíris", Callback = function() hitboxRainbow = true end })

task.spawn(function()
	while task.wait(0.15) do
		if not hitboxEnabled then continue end
		if not IsInMatchStrict() then
			for _, p in ipairs(Players:GetPlayers()) do
				local c = p.Character
				if c then
					local h = c:FindFirstChild("GhostHitbox")
					if h then h:Destroy() end
				end
			end
			continue
		end
		local size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
		local trans = hitboxInvisible and 1 or 0.55
		local colorToUse = hitboxRainbow and Color3.fromHSV((tick() % 5) / 5, 1, 1) or hitboxColor
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and isEnemy(p) and p.Character then
				local root = p.Character:FindFirstChild("HumanoidRootPart")
				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				if root and hum and hum.Health > 0 then
					local hb = p.Character:FindFirstChild("GhostHitbox")
					if not hb then
						hb = Instance.new("Part")
						hb.Name = "GhostHitbox"
						hb.Size = size
						hb.Transparency = trans
						hb.Color = colorToUse
						hb.CanCollide = false
						hb.Massless = true
						hb.CanQuery = true
						hb.CFrame = root.CFrame
						hb.Parent = p.Character
						local w = Instance.new("WeldConstraint")
						w.Part0 = root
						w.Part1 = hb
						w.Parent = hb
					else
						if hb.Size ~= size then hb.Size = size end
						if hb.Transparency ~= trans then hb.Transparency = trans end
						hb.Color = colorToUse
					end
				end
			end
		end
	end
end)

getgenv().AlexTargetPart = nil
if hookmetamethod and getnamecallmethod and checkcaller then
	local oldNamecall
	oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
		local method = getnamecallmethod()
		if not checkcaller() and getgenv().AlexTargetPart then
			local target = getgenv().AlexTargetPart
			if target and target.Parent then
				if method == "Raycast" and self == workspace then
					local origin, direction, p3 = ...
					if typeof(direction) == "Vector3" and direction.Magnitude > 20 then
						if (origin - camera.CFrame.Position).Magnitude >= 1 then
							return oldNamecall(self, origin, (target.Position - origin).Unit * 5000, p3)
						end
					end
				elseif typeof(method) == "string" and method:sub(1, 13) == "FindPartOnRay" and self == workspace then
					local ray, p2, p3, p4 = ...
					if typeof(ray) == "Ray" and ray.Direction.Magnitude > 20 then
						if (ray.Origin - camera.CFrame.Position).Magnitude >= 1 then
							return oldNamecall(self, Ray.new(ray.Origin, (target.Position - ray.Origin).Unit * 5000), p2, p3, p4)
						end
					end
				end
			else
				getgenv().AlexTargetPart = nil
			end
		end
		return oldNamecall(self, ...)
	end)
end

task.spawn(function()
	while task.wait(0.05) do
		if not silentAimManualEnabled then
			if not autoShootEnabled and not autoShootAgresivoEnabled then
				getgenv().AlexTargetPart = nil
			end
			continue
		end
		if estaEnLobby() or not IsInMatchStrict() then
			getgenv().AlexTargetPart = nil
			continue
		end
		local bestPart, bestDist = nil, math.huge
		local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not myRoot then getgenv().AlexTargetPart = nil continue end
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= player and esEnemigoValido(p) and p.Character then
				local part = GetTargetPartFromChar(p.Character, silentAimTargetPart)
				if part and part:IsA("BasePart") then
					if silentAimFovEnabled and not IsInFOV(part.Position, fovRadius) then continue end
					local dist = (part.Position - myRoot.Position).Magnitude
					if dist < bestDist then bestDist = dist bestPart = part end
				end
			end
		end
		getgenv().AlexTargetPart = bestPart
	end
end)

task.spawn(function()
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	while task.wait(0.1) do
		if (autoShootEnabled or autoShootAgresivoEnabled) and not estaEnLobby() then
			local char = player.Character
			if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
			local arma = char:FindFirstChildOfClass("Tool")
			if not arma or not arma:FindFirstChild("Handle") or esCuchillo(arma) then
				if not silentAimManualEnabled then getgenv().AlexTargetPart = nil end
				continue
			end
			local closest, shortest = nil, math.huge
			local myPos = char.HumanoidRootPart.Position
			local headPos = char:FindFirstChild("Head") and char.Head.Position or myPos
			for _, p in pairs(Players:GetPlayers()) do
				if p ~= player and isEnemy(p) and p.Character then
					local enemyHum = p.Character:FindFirstChild("Humanoid")
					if enemyHum and enemyHum.Health > 0 then
						params.FilterDescendantsInstances = { char, p.Character }
						local function ProcesarParte(part)
							local dist = (part.Position - myPos).Magnitude
							if dist < shortest then
								local size = part.Size
								local offsets = { Vector3.zero, Vector3.new(0, size.Y/2.1, 0), Vector3.new(0, -size.Y/2.1, 0) }
								for _, o in ipairs(offsets) do
									if not workspace:Raycast(headPos, (part.CFrame * o) - headPos, params) then
										shortest = dist
										closest = part
										break
									end
								end
							end
						end
						if autoShootAgresivoEnabled then
							for _, part in ipairs(p.Character:GetChildren()) do
								if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then ProcesarParte(part) end
							end
						elseif autoShootTargetPart == "Cabeza" then
							local head = p.Character:FindFirstChild("Head")
							if head then ProcesarParte(head) end
						elseif autoShootTargetPart == "Torso" then
							for _, n in ipairs({"UpperTorso","Torso","HumanoidRootPart"}) do
								local part = p.Character:FindFirstChild(n)
								if part then ProcesarParte(part) end
							end
						else
							for _, part in ipairs(p.Character:GetChildren()) do
								if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then ProcesarParte(part) end
							end
						end
					end
				end
			end
			if closest then
				if not silentAimManualEnabled then getgenv().AlexTargetPart = closest end
				pcall(function()
					arma:Activate()
					task.delay(0.05, function() if arma.Parent == char then arma:Deactivate() end end)
				end)
				task.wait(0.2)
			else
				if not silentAimManualEnabled then getgenv().AlexTargetPart = nil end
			end
		end
	end
end)

local FOVCircle
if Drawing then
	FOVCircle = Drawing.new("Circle")
	FOVCircle.Filled = false
	FOVCircle.Color = Color3.fromRGB(255, 255, 255)
	FOVCircle.Visible = false
	FOVCircle.Thickness = 1
end
RunService.RenderStepped:Connect(function()
	if FOVCircle then
		if fovVisiblePreference then
			FOVCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
			FOVCircle.Radius = fovRadius
			FOVCircle.Visible = true
		else
			FOVCircle.Visible = false
		end
	end
end)

-- ===================== ESP =====================
Tabs.Vis:Section({ Title = "ESP Glow", Icon = "solar:eye-bold" })
Tabs.Vis:Toggle({ Title = "ESP Jugadores", Callback = function(s) espEnabled = s end })
Tabs.Vis:Colorpicker({ Title = "Color ESP", Default = Color3.fromRGB(255, 255, 255), Callback = function(c) espColor = c end })
Tabs.Vis:Toggle({ Title = "Resplandor", Value = true, Callback = function(s) espSettings.Glow = s end })

local activeESPs = {}
local function cleanESP(p)
	if activeESPs[p] then
		if activeESPs[p].Highlight then activeESPs[p].Highlight:Destroy() end
		activeESPs[p] = nil
	end
end

task.spawn(function()
	while task.wait(0.2) do
		if espEnabled and IsInMatchStrict() then
			local myHead = player.Character and player.Character:FindFirstChild("Head")
			local myPos = myHead and myHead.Position
			for _, p in pairs(Players:GetPlayers()) do
				if p ~= player and p.Character and p.Character:FindFirstChild("Head") and isEnemy(p) then
					local dist = myPos and (p.Character.Head.Position - myPos).Magnitude or 0
					if dist <= 1500 then
						if activeESPs[p] and activeESPs[p].Char ~= p.Character then cleanESP(p) end
						if not activeESPs[p] then
							local h = Instance.new("Highlight")
							h.FillTransparency = 1
							h.OutlineTransparency = 0
							h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							h.Adornee = p.Character
							h.Parent = espFolder
							activeESPs[p] = { Highlight = h, Char = p.Character }
						end
					else cleanESP(p) end
				else cleanESP(p) end
			end
		else
			for _, p in pairs(Players:GetPlayers()) do cleanESP(p) end
		end
	end
end)

local ESP_Names, ESP_Lines, ESP_Boxes, ESP_POV = false, false, false, false
local CurrentESPColor = Color3.fromRGB(0, 255, 130)
local RainbowESP = false
local LineOrigin = "Abajo"
local POVSize = 1
local DrawingLines = {}
local ESPExtraFolder = Instance.new("Folder", screenGui)
ESPExtraFolder.Name = "AlexESPExtra"

local POVCircleUI = Instance.new("Frame", screenGui)
POVCircleUI.BackgroundTransparency = 1
POVCircleUI.Size = UDim2.new(0, 140, 0, 140)
POVCircleUI.Position = UDim2.new(0.5, -70, 0.5, -70)
POVCircleUI.Visible = false
Instance.new("UICorner", POVCircleUI).CornerRadius = UDim.new(1, 0)
local POVStroke = Instance.new("UIStroke", POVCircleUI)
POVStroke.Thickness = 2
POVStroke.Transparency = 0.25
POVStroke.Color = Color3.fromRGB(0, 255, 130)

local function GetESPColor()
	if RainbowESP then return Color3.fromHSV((tick() % 5) / 5, 1, 1) end
	return CurrentESPColor
end

local function ClearExtraESP()
	for _, v in pairs(ESPExtraFolder:GetChildren()) do v:Destroy() end
	for _, line in pairs(DrawingLines) do pcall(function() line:Remove() end) end
	DrawingLines = {}
end

local function CreateExtraESP(plr)
	local char = plr.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	local head = char:FindFirstChild("Head")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not root or not hum or hum.Health <= 0 then return end
	local color = GetESPColor()
	if ESP_Names then
		local bb = Instance.new("BillboardGui")
		bb.Adornee = head or root
		bb.Size = UDim2.new(0, 110, 0, 16)
		bb.StudsOffset = Vector3.new(0, 2.4, 0)
		bb.AlwaysOnTop = true
		bb.Parent = ESPExtraFolder
		local t = Instance.new("TextLabel", bb)
		t.Size = UDim2.new(1, 0, 1, 0)
		t.BackgroundTransparency = 1
		t.Text = plr.DisplayName
		t.TextColor3 = color
		t.TextStrokeTransparency = 0.5
		t.Font = Enum.Font.GothamBold
		t.TextSize = 12
	end
	if ESP_Lines then
		local ok2, line = pcall(function() return Drawing.new("Line") end)
		if ok2 and line then
			line.Thickness = 1.5
			line.Transparency = 1
			table.insert(DrawingLines, line)
			local conn
			conn = RunService.RenderStepped:Connect(function()
				if not ESP_Lines or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
					if conn then conn:Disconnect() end
					pcall(function() line:Remove() end)
					return
				end
				local pos, on = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
				if on then
					local vp = camera.ViewportSize
					local fy = (LineOrigin == "Arriba" and 0) or (LineOrigin == "Medio" and vp.Y/2) or vp.Y
					line.From = Vector2.new(vp.X/2, fy)
					line.To = Vector2.new(pos.X, pos.Y)
					line.Color = GetESPColor()
					line.Visible = true
				else line.Visible = false end
			end)
		end
	end
	if ESP_Boxes then
		local box = Instance.new("SelectionBox")
		box.Adornee = char
		box.LineThickness = 0.03
		box.Color3 = color
		box.SurfaceTransparency = 1
		box.Parent = ESPExtraFolder
	end
end

local function RefreshExtraESP()
	ClearExtraESP()
	if not (ESP_Names or ESP_Lines or ESP_Boxes) or not IsInMatchStrict() then return end
	for _, plr in pairs(GetValidEnemies()) do CreateExtraESP(plr) end
end

local function UpdatePOV()
	local s = 100 + (POVSize * 80)
	POVCircleUI.Size = UDim2.new(0, s, 0, s)
	POVCircleUI.Position = UDim2.new(0.5, -s/2, 0.5, -s/2)
	POVStroke.Color = GetESPColor()
end

Tabs.Vis:Space()
Tabs.Vis:Divider()
Tabs.Vis:Section({ Title = "ESP Extra", Icon = "solar:eye-bold" })
Tabs.Vis:Toggle({ Title = "Nombres", Callback = function(v) ESP_Names = v RefreshExtraESP() end })
Tabs.Vis:Toggle({ Title = "Líneas", Callback = function(v) ESP_Lines = v RefreshExtraESP() end })
Tabs.Vis:Toggle({ Title = "Caja", Callback = function(v) ESP_Boxes = v RefreshExtraESP() end })
Tabs.Vis:Toggle({
	Title = "POV",
	Callback = function(v)
		ESP_POV = v
		POVCircleUI.Visible = v
		UpdatePOV()
	end
})
Tabs.Vis:Slider({
	Title = "Tamaño POV",
	Step = 0.1,
	Value = { Min = 0.5, Max = 2.5, Default = 1 },
	Callback = function(v) POVSize = v UpdatePOV() end
})
Tabs.Vis:Dropdown({
	Title = "Origen Línea",
	Values = { "Arriba", "Medio", "Abajo" },
	Value = "Abajo",
	Callback = function(v) LineOrigin = v end
})
Tabs.Vis:Section({ Title = "Paleta Rápida ESP" })
Tabs.Vis:Button({ Title = "Verde", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(0, 255, 130) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Celeste", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(56, 189, 248) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Rojo", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(255, 60, 60) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Azul", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(50, 150, 255) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Blanco", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(255, 255, 255) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Arcoíris", Callback = function()
	RainbowESP = true UpdatePOV() RefreshExtraESP()
end })

-- ===================== EFFECTS (AUTOFARM) =====================
Tabs.Farm:Section({ Title = "Evento", Icon = "solar:gift-bold" })
getgenv().AutoEventFarm = false
local Networking = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Networking")
local RemoteFarm = Networking and Networking:FindFirstChild("RE/Events/CollectEventSpawnable")
Tabs.Farm:Toggle({
	Title = "Auto Farmear Evento",
	Callback = function(s)
		getgenv().AutoEventFarm = s
		if s then
			task.spawn(function()
				while getgenv().AutoEventFarm do
					pcall(function() if RemoteFarm then RemoteFarm:FireServer() end end)
					task.wait(0.05)
				end
			end)
		end
	end
})

-- ===================== TOOLS (ANIMACIONES) =====================
local animPacks = {
	["Ninguno"] = nil,
	["Old School"] = {
		idle = "http://www.roblox.com/asset/?id=180435571",
		walk = "http://www.roblox.com/asset/?id=180426354",
		run  = "http://www.roblox.com/asset/?id=180426354",
		jump = "http://www.roblox.com/asset/?id=125750702",
		fall = "http://www.roblox.com/asset/?id=180436148",
	},
	["Zombie"] = {
		idle = "http://www.roblox.com/asset/?id=3489171152",
		walk = "http://www.roblox.com/asset/?id=3489174223",
		run  = "http://www.roblox.com/asset/?id=3489174421",
		jump = "http://www.roblox.com/asset/?id=616163946",
		fall = "http://www.roblox.com/asset/?id=616157476",
	},
	["Ninja"] = {
		idle = "http://www.roblox.com/asset/?id=656117878",
		walk = "http://www.roblox.com/asset/?id=656118341",
		run  = "http://www.roblox.com/asset/?id=656118852",
		jump = "http://www.roblox.com/asset/?id=656117878",
		fall = "http://www.roblox.com/asset/?id=656115606",
	},
	["Levitation"] = {
		idle = "http://www.roblox.com/asset/?id=616006778",
		walk = "http://www.roblox.com/asset/?id=616013216",
		run  = "http://www.roblox.com/asset/?id=616010382",
		jump = "http://www.roblox.com/asset/?id=616008936",
		fall = "http://www.roblox.com/asset/?id=616008936",
	},
}
local selectedPack = "Ninguno"

local function applyAnimPack(packName)
	local char = player.Character
	if not char then return end
	local animate = char:FindFirstChild("Animate")
	if not animate then return end
	if packName == "Ninguno" then return end
	local pack = animPacks[packName]
	if not pack then return end
	pcall(function()
		if animate:FindFirstChild("idle") and animate.idle:FindFirstChild("Animation1") then
			animate.idle.Animation1.AnimationId = pack.idle
		end
		if animate:FindFirstChild("walk") and animate.walk:FindFirstChild("WalkAnim") then
			animate.walk.WalkAnim.AnimationId = pack.walk
		end
		if animate:FindFirstChild("run") and animate.run:FindFirstChild("RunAnim") then
			animate.run.RunAnim.AnimationId = pack.run
		end
		if animate:FindFirstChild("jump") and animate.jump:FindFirstChild("JumpAnim") then
			animate.jump.JumpAnim.AnimationId = pack.jump
		end
		if animate:FindFirstChild("fall") and animate.fall:FindFirstChild("FallAnim") then
			animate.fall.FallAnim.AnimationId = pack.fall
		end
	end)
end

Tabs.Animaciones:Section({ Title = "Paquetes", Icon = "solar:folder-with-files-bold" })
Tabs.Animaciones:Dropdown({
	Title = "Elegir Paquete",
	Values = { "Ninguno", "Old School", "Zombie", "Ninja", "Levitation" },
	Value = "Ninguno",
	Callback = function(v) selectedPack = v end
})
Tabs.Animaciones:Button({
	Title = "Aplicar Paquete",
	Callback = function() applyAnimPack(selectedPack) end
})

player.CharacterAdded:Connect(function()
	task.wait(1)
	if selectedPack ~= "Ninguno" then applyAnimPack(selectedPack) end
end)

-- ===================== LOOP =====================
task.spawn(function()
	while task.wait(0.4) do
		UpdatePersona()
		if ESP_Names or ESP_Lines or ESP_Boxes then
			RefreshExtraESP()
		else
			ClearExtraESP()
		end
		if ESP_POV then UpdatePOV() end
	end
end)

Players.PlayerRemoving:Connect(function()
	ClearExtraESP()
	task.wait(0.1)
	UpdatePersona()
end)

print("Alex Hub Completo | Alex_12alex28 | alex@11")
