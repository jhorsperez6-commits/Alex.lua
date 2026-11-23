-- ==========================================
-- Alex Hub Completo
-- Alex_12alex28 | TikTok: alex@11
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local workspace = game:GetService("Workspace")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
while not player do task.wait() player = Players.LocalPlayer end
local camera = workspace.CurrentCamera

-- ===================== SISTEMA DE KEY PRINCIPAL =====================
local KEY_OK = false
local VALID_KEYS = { ["Alex"] = true, ["alex"] = true }

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "AlexKeyUI"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.DisplayOrder = 10000
pcall(function() keyGui.Parent = game:GetService("CoreGui") end)
if not keyGui.Parent then keyGui.Parent = player:WaitForChild("PlayerGui") end

local bg = Instance.new("Frame", keyGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 7, 11)
bg.BackgroundTransparency = 0.45
bg.BorderSizePixel = 0

local card = Instance.new("Frame", bg)
card.Size = UDim2.new(0, 344, 0, 404)
card.Position = UDim2.new(0.5, -172, 0.5, -202)
card.BackgroundColor3 = Color3.fromRGB(14, 17, 24)
card.BorderSizePixel = 0
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)

local cardGrad = Instance.new("UIGradient", card)
cardGrad.Rotation = 135
cardGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 27, 38)),
	ColorSequenceKeypoint.new(0.55, Color3.fromRGB(14, 17, 24)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 18))
})

local st = Instance.new("UIStroke", card)
st.Color = Color3.fromRGB(46, 56, 76)
st.Thickness = 1.2

local topAccent = Instance.new("Frame", card)
topAccent.Size = UDim2.new(0.42, 0, 0, 3)
topAccent.Position = UDim2.new(0.29, 0, 0, 10)
topAccent.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
topAccent.BorderSizePixel = 0
Instance.new("UICorner", topAccent).CornerRadius = UDim.new(1, 0)

local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 22)
title.BackgroundTransparency = 1
title.Text = "ALEX HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 21
title.TextColor3 = Color3.fromRGB(236, 242, 250)

local subtitle = Instance.new("TextLabel", card)
subtitle.Size = UDim2.new(1, 0, 0, 16)
subtitle.Position = UDim2.new(0, 0, 0, 50)
subtitle.BackgroundTransparency = 1
subtitle.Text = "FLY EDITION · alex@11"
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 11
subtitle.TextColor3 = Color3.fromRGB(122, 136, 162)

local avatarFrame = Instance.new("Frame", card)
avatarFrame.Size = UDim2.new(0, 58, 0, 58)
avatarFrame.Position = UDim2.new(0.5, -29, 0, 76)
avatarFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 36)
avatarFrame.BorderSizePixel = 0
Instance.new("UICorner", avatarFrame).CornerRadius = UDim.new(1, 0)
local avOuterStroke = Instance.new("UIStroke", avatarFrame)
avOuterStroke.Color = Color3.fromRGB(56, 189, 248)
avOuterStroke.Thickness = 1.5
avOuterStroke.Transparency = 0.35

local avatarImg = Instance.new("ImageLabel", avatarFrame)
avatarImg.Size = UDim2.new(1, -4, 1, -4)
avatarImg.Position = UDim2.new(0, 2, 0, 2)
avatarImg.BackgroundColor3 = Color3.fromRGB(24, 29, 41)
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420"
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)

local infoBox = Instance.new("Frame", card)
infoBox.Size = UDim2.new(0.88, 0, 0, 78)
infoBox.Position = UDim2.new(0.06, 0, 0, 148)
infoBox.BackgroundColor3 = Color3.fromRGB(19, 23, 33)
infoBox.BorderSizePixel = 0
Instance.new("UICorner", infoBox).CornerRadius = UDim.new(0, 12)

local infoGrad = Instance.new("UIGradient", infoBox)
infoGrad.Rotation = 90
infoGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 30, 43)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 20, 29))
})

local infoStroke = Instance.new("UIStroke", infoBox)
infoStroke.Color = Color3.fromRGB(40, 49, 68)
infoStroke.Thickness = 1

local infoTitle = Instance.new("TextLabel", infoBox)
infoTitle.Size = UDim2.new(1, -112, 0, 20)
infoTitle.Position = UDim2.new(0, 12, 0, 10)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "Sistema de acceso"
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 12
infoTitle.TextColor3 = Color3.fromRGB(218, 226, 238)
infoTitle.TextXAlignment = Enum.TextXAlignment.Left

local infoDesc = Instance.new("TextLabel", infoBox)
infoDesc.Size = UDim2.new(1, -114, 0, 32)
infoDesc.Position = UDim2.new(0, 12, 0, 34)
infoDesc.BackgroundTransparency = 1
infoDesc.Text = "Ingresa tu clave para abrir el panel"
infoDesc.Font = Enum.Font.Gotham
infoDesc.TextSize = 11
infoDesc.TextColor3 = Color3.fromRGB(134, 148, 174)
infoDesc.TextXAlignment = Enum.TextXAlignment.Left
infoDesc.TextWrapped = true

local copyBtn = Instance.new("TextButton", infoBox)
copyBtn.Size = UDim2.new(0, 88, 0, 36)
copyBtn.Position = UDim2.new(1, -98, 0.5, -18)
copyBtn.BackgroundColor3 = Color3.fromRGB(30, 38, 54)
copyBtn.Text = "Copy"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 12
copyBtn.TextColor3 = Color3.fromRGB(215, 228, 245)
copyBtn.BorderSizePixel = 0
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 9)
local copyStroke = Instance.new("UIStroke", copyBtn)
copyStroke.Color = Color3.fromRGB(54, 68, 94)
copyStroke.Thickness = 1

copyBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if setclipboard then
			setclipboard("Alex_12alex28 · alex@11")
		end
	end)
	copyBtn.Text = "Copiado"
	copyBtn.TextColor3 = Color3.fromRGB(110, 231, 183)
	task.wait(1.4)
	copyBtn.Text = "Copy"
	copyBtn.TextColor3 = Color3.fromRGB(215, 228, 245)
end)

local keyBox = Instance.new("TextBox", card)
keyBox.Size = UDim2.new(0.88, 0, 0, 44)
keyBox.Position = UDim2.new(0.06, 0, 0, 240)
keyBox.BackgroundColor3 = Color3.fromRGB(18, 22, 31)
keyBox.PlaceholderText = "Enter your key..."
keyBox.Text = ""
keyBox.Font = Enum.Font.GothamMedium
keyBox.TextSize = 13
keyBox.TextColor3 = Color3.fromRGB(238, 244, 252)
keyBox.PlaceholderColor3 = Color3.fromRGB(112, 125, 150)
keyBox.ClearTextOnFocus = false
keyBox.BorderSizePixel = 0
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 11)
local boxStroke = Instance.new("UIStroke", keyBox)
boxStroke.Color = Color3.fromRGB(44, 54, 74)
boxStroke.Thickness = 1

keyBox.Focused:Connect(function()
	boxStroke.Color = Color3.fromRGB(56, 189, 248)
end)
keyBox.FocusLost:Connect(function()
	boxStroke.Color = Color3.fromRGB(44, 54, 74)
end)

local status = Instance.new("TextLabel", card)
status.Size = UDim2.new(1, 0, 0, 18)
status.Position = UDim2.new(0, 0, 0, 290)
status.BackgroundTransparency = 1
status.Text = ""
status.Font = Enum.Font.GothamMedium
status.TextSize = 12

local activateBtn = Instance.new("TextButton", card)
activateBtn.Size = UDim2.new(0.88, 0, 0, 48)
activateBtn.Position = UDim2.new(0.06, 0, 0, 316)
activateBtn.BackgroundColor3 = Color3.fromRGB(32, 48, 72)
activateBtn.Text = "ACTIVATE"
activateBtn.Font = Enum.Font.GothamBold
activateBtn.TextSize = 14
activateBtn.TextColor3 = Color3.fromRGB(240, 248, 255)
activateBtn.BorderSizePixel = 0
Instance.new("UICorner", activateBtn).CornerRadius = UDim.new(0, 11)

local actGrad = Instance.new("UIGradient", activateBtn)
actGrad.Rotation = 90
actGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(42, 72, 108)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 38, 58))
})

local actStroke = Instance.new("UIStroke", activateBtn)
actStroke.Color = Color3.fromRGB(56, 189, 248)
actStroke.Thickness = 1
actStroke.Transparency = 0.45

local footerLbl = Instance.new("TextLabel", card)
footerLbl.Size = UDim2.new(1, 0, 0, 14)
footerLbl.Position = UDim2.new(0, 0, 1, -22)
footerLbl.BackgroundTransparency = 1
footerLbl.Text = "Alex_12alex28"
footerLbl.Font = Enum.Font.Gotham
footerLbl.TextSize = 10
footerLbl.TextColor3 = Color3.fromRGB(96, 108, 132)

activateBtn.MouseButton1Click:Connect(function()
	local entered = keyBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
	if VALID_KEYS[entered] then
		status.Text = "Acceso concedido"
		status.TextColor3 = Color3.fromRGB(110, 231, 183)
		KEY_OK = true
		task.wait(0.35)
		keyGui:Destroy()
	else
		status.Text = "Key incorrecta"
		status.TextColor3 = Color3.fromRGB(248, 113, 113)
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
local espEnabled = false
local espColor = Color3.fromRGB(255, 255, 255)
local hitboxEnabled = false
local hitboxInvisible = false
local hitboxSize = 3.5
local hitboxColor = Color3.fromRGB(255, 0, 0)
local hitboxRainbow = false

-- Gráfico
local graphicsUnlocked = false
local graphicsTypedKey = ""
local cartonModeActive = false
local realismCharActive = false
local superUltraActive = false
local dayNightMode = "Día" -- "Día" o "Noche"
local autoDayNightCycle = false
local PHASE_DURATION = 300 -- 5 minutos exactos por fase (Día / Noche)

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
	Grafico = MainSection:Tab({ Title = "Gráfico", Icon = "solar:monitor-bold" }),
}

-- ===================== HELPERS (NO COMPAÑEROS) =====================
local COLORES_NEUTROS = {
	["White"] = true, ["Medium stone grey"] = true, ["Medium Stone Grey"] = true,
	["Really black"] = true, ["Really Black"] = true, ["Institutional white"] = true,
	["Institutional White"] = true, ["Ghost grey"] = true, ["Ghost Grey"] = true,
	["Black"] = true, ["Dark stone grey"] = true
}

local marcaAliadoCache = {}
local ATTRS_ALIADO = {
	"IsAlly","Ally","AllyMarker","isAlly","is_ally","ally",
	"Teammate","isTeammate","IsTeammate","Friendly","isFriendly","IsFriendly",
	"Team","Side","Role","Faction","Party","Squad","Group"
}

local function getTeamKey(p)
	if not p then return nil end
	if p.Team and p.Team.Name then
		local n = string.lower(p.Team.Name)
		if not (n:find("lobby") or n:find("spectat") or n:find("menu") or n:find("dead") or n == "neutral" or n == "none") then
			return "team:" .. n
		end
	end
	if p.TeamColor then
		local c = p.TeamColor.Name
		if not COLORES_NEUTROS[c] then return "color:" .. c end
	end
	for _, a in ipairs({"Team","Side","Role","Faction","Party","Squad","Group"}) do
		local v = p:GetAttribute(a)
		if v ~= nil and tostring(v) ~= "" and tostring(v) ~= "nil" then
			return "attr:" .. a .. ":" .. string.lower(tostring(v))
		end
		if p.Character then
			local v2 = p.Character:GetAttribute(a)
			if v2 ~= nil and tostring(v2) ~= "" and tostring(v2) ~= "nil" then
				return "attr:" .. a .. ":" .. string.lower(tostring(v2))
			end
		end
	end
	return nil
end

local function tieneMarcaAliado(p)
	if not p then return false end
	local now = os.clock()
	local c = marcaAliadoCache[p]
	if c and (now - c.time) < 0.4 then return c.value end
	local r = false
	local char = p.Character
	for _, a in ipairs(ATTRS_ALIADO) do
		local v1 = p:GetAttribute(a)
		if v1 == true or v1 == "true" or v1 == "Ally" or v1 == "ally" or v1 == "Teammate" then
			r = true break
		end
		if char then
			local v2 = char:GetAttribute(a)
			if v2 == true or v2 == "true" or v2 == "Ally" or v2 == "ally" or v2 == "Teammate" then
				r = true break
			end
		end
	end
	marcaAliadoCache[p] = { value = r, time = now }
	return r
end

local function esAmigoRoblox(p)
	if not p or p == player then return true end
	local ok, isFriend = pcall(function() return player:IsFriendsWith(p.UserId) end)
	return ok and isFriend == true
end

local function esAmigoOAliado(p)
	if not p or p == player then return true end
	if esAmigoRoblox(p) then return true end
	if tieneMarcaAliado(p) then return true end
	local myKey = getTeamKey(player)
	local otKey = getTeamKey(p)
	if myKey and otKey and myKey == otKey then return true end
	if player.Team and p.Team and player.Team == p.Team then return true end
	local myC = player.TeamColor and player.TeamColor.Name or "White"
	local otC = p.TeamColor and p.TeamColor.Name or "White"
	if not COLORES_NEUTROS[myC] and not COLORES_NEUTROS[otC] and player.TeamColor == p.TeamColor then
		return true
	end
	return false
end

local function isEnemy(p)
	if not p or p == player then return false end
	if esAmigoOAliado(p) then return false end
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
	if not p or p == player then return false end
	if esAmigoOAliado(p) then return false end
	if not isEnemy(p) then return false end
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
	return n:find("knife") or n:find("cuchillo") or n:find("dagger") or n:find("blade")
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
		if esEnemigoValido(p) and p.Character then
			local root = p.Character:FindFirstChild("HumanoidRootPart")
			local hum = p.Character:FindFirstChildOfClass("Humanoid")
			if root and hum and hum.Health > 0 then
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
	return char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart")
end

local function IsInFOV(worldPos, radius)
	local screenPos, onScreen = camera:WorldToViewportPoint(worldPos)
	if not onScreen then return false end
	local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
	return (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude <= radius
end

-- ===================== INFO =====================
Tabs.Inicio:Section({ Title = "DASHBOARD", Icon = "solar:home-bold" })

local execName = "Desconocido"
pcall(function() execName = (identifyexecutor and identifyexecutor()) or "Desconocido" end)

local gameNameStr = "Desconocido"
pcall(function()
	gameNameStr = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

Tabs.Inicio:Paragraph({
	Title = "Jugador",
	Desc = "User de Roblox: @" .. player.Name .. "\nDisplay: " .. player.DisplayName,
	Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420",
	ImageSize = 70
})

Tabs.Inicio:Space()
Tabs.Inicio:Paragraph({
	Title = "Juego Actual",
	Desc = gameNameStr .. "\nPlaceId: " .. tostring(game.PlaceId)
})

Tabs.Inicio:Space()
Tabs.Inicio:Divider()
Tabs.Inicio:Space()

Tabs.Inicio:Paragraph({
	Title = "Creador",
	Desc = "User de Roblox: Alex_12alex28\nTikTok: alex@11\nEjecutor: " .. execName
})

Tabs.Inicio:Paragraph({
	Title = "Info Extra",
	Desc = "Silent + No compañeros\nModos gráficos disponibles en Gráfico"
})

-- ===================== MÓVIL =====================
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
Tabs.Persona:Paragraph({ Title = "Servidor / Enemigos", Desc = "Solo cuenta enemigos reales." })

local function UpdatePersona()
	ServerLabel.Text = "Servidor: " .. #Players:GetPlayers()
	EnemyLabel.Text = IsInMatchStrict() and ("Enemigos: " .. #GetValidEnemies()) or "Enemigos: 0"
end

-- ===================== AIMBOT =====================
Tabs.Aim:Section({ Title = "Auto Shoot", Icon = "solar:target-bold" })
Tabs.Aim:Toggle({
	Title = "Auto Shoot (Normal)",
	Desc = "Solo si hay enemigo visible enfrente.",
	Callback = function(Value)
		autoShootEnabled = Value
		if not Value and not autoShootAgresivoEnabled and not silentAimManualEnabled then
			getgenv().AlexTargetPart = nil
		end
	end
})
Tabs.Aim:Toggle({
	Title = "Auto Shoot (Agresivo)",
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
			if esEnemigoValido(p) and p.Character then
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
	Desc = "Prioriza enfrente + visible. No compañeros.",
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
Tabs.Aim:Toggle({ Title = "Silent Aim (FOV)", Callback = function(Value) silentAimFovEnabled = Value end })
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
		if not hitboxEnabled or not IsInMatchStrict() then
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
			local c = p.Character
			if not c then continue end
			if not esEnemigoValido(p) then
				local h = c:FindFirstChild("GhostHitbox")
				if h then h:Destroy() end
				continue
			end
			local root = c:FindFirstChild("HumanoidRootPart")
			local hum = c:FindFirstChildOfClass("Humanoid")
			if root and hum and hum.Health > 0 then
				local hb = c:FindFirstChild("GhostHitbox")
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
					hb.Parent = c
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

-- SILENT AIM
task.spawn(function()
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	while task.wait(0.03) do
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
		local char = player.Character
		local myRoot = char and char:FindFirstChild("HumanoidRootPart")
		local myHead = char and char:FindFirstChild("Head")
		if not myRoot then
			getgenv().AlexTargetPart = nil
			continue
		end
		local camCF = camera.CFrame
		local origin = myHead and myHead.Position or myRoot.Position
		local bestPart, bestScore = nil, -math.huge

		for _, p in pairs(Players:GetPlayers()) do
			if not esEnemigoValido(p) or not p.Character then continue end
			local part = GetTargetPartFromChar(p.Character, silentAimTargetPart)
			if not part or not part:IsA("BasePart") then continue end
			local dist = (part.Position - myRoot.Position).Magnitude
			if dist > 2000 then continue end

			local dir = (part.Position - camCF.Position)
			if dir.Magnitude < 0.1 then continue end
			local dot = camCF.LookVector:Dot(dir.Unit)
			if dot < 0.2 then continue end

			if silentAimFovEnabled and not IsInFOV(part.Position, fovRadius) then continue end

			rayParams.FilterDescendantsInstances = { char, p.Character }
			local blocked = workspace:Raycast(origin, part.Position - origin, rayParams)

			local score = dot * 100
			if not blocked then score = score + 60 else score = score - 40 end
			score = score - (dist / 40)

			if score > bestScore then
				bestScore = score
				bestPart = part
			end
		end
		getgenv().AlexTargetPart = bestPart
	end
end)

-- AUTO SHOOT
task.spawn(function()
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	while task.wait(0.08) do
		if not (autoShootEnabled or autoShootAgresivoEnabled) then
			if not silentAimManualEnabled then getgenv().AlexTargetPart = nil end
			continue
		end
		if estaEnLobby() or not IsInMatchStrict() then
			if not silentAimManualEnabled then getgenv().AlexTargetPart = nil end
			continue
		end
		local char = player.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
		local arma = char:FindFirstChildOfClass("Tool")
		if not arma or not arma:FindFirstChild("Handle") or esCuchillo(arma) then
			if not silentAimManualEnabled then getgenv().AlexTargetPart = nil end
			continue
		end

		local closest, bestScore = nil, -math.huge
		local myPos = char.HumanoidRootPart.Position
		local headPos = char:FindFirstChild("Head") and char.Head.Position or myPos
		local camCF = camera.CFrame

		for _, p in pairs(Players:GetPlayers()) do
			if not esEnemigoValido(p) or not p.Character then continue end
			local enemyHum = p.Character:FindFirstChild("Humanoid")
			if not enemyHum or enemyHum.Health <= 0 then continue end
			params.FilterDescendantsInstances = { char, p.Character }

			local function tryPart(part)
				if not part or not part:IsA("BasePart") then return end
				local dist = (part.Position - myPos).Magnitude
				local dir = (part.Position - camCF.Position)
				if dir.Magnitude < 0.1 then return end
				local dot = camCF.LookVector:Dot(dir.Unit)
				if dot < 0.15 then return end
				local size = part.Size
				local offsets = { Vector3.zero, Vector3.new(0, size.Y/2.1, 0), Vector3.new(0, -size.Y/2.1, 0) }
				local visible = false
				for _, o in ipairs(offsets) do
					if not workspace:Raycast(headPos, (part.CFrame * o) - headPos, params) then
						visible = true
						break
					end
				end
				if not visible then return end
				local score = dot * 100 - dist / 40
				if score > bestScore then
					bestScore = score
					closest = part
				end
			end

			if autoShootAgresivoEnabled then
				for _, part in ipairs(p.Character:GetChildren()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then tryPart(part) end
				end
			elseif autoShootTargetPart == "Cabeza" then
				tryPart(p.Character:FindFirstChild("Head"))
			elseif autoShootTargetPart == "Torso" then
				tryPart(p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("HumanoidRootPart"))
			else
				for _, part in ipairs(p.Character:GetChildren()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then tryPart(part) end
				end
			end
		end

		if not closest then
			if not silentAimManualEnabled then getgenv().AlexTargetPart = nil end
			continue
		end

		if not silentAimManualEnabled then getgenv().AlexTargetPart = closest end
		pcall(function()
			arma:Activate()
			task.delay(0.04, function() if arma.Parent == char then arma:Deactivate() end end)
		end)
		task.wait(0.15)
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

local activeESPs = {}
local function cleanESP(p)
	if activeESPs[p] then
		if activeESPs[p].Highlight then activeESPs[p].Highlight:Destroy() end
		activeESPs[p] = nil
	end
end

task.spawn(function()
	while task.wait(0.35) do
		if espEnabled and IsInMatchStrict() then
			local myHead = player.Character and player.Character:FindFirstChild("Head")
			local myPos = myHead and myHead.Position
			for _, p in pairs(Players:GetPlayers()) do
				if esEnemigoValido(p) and p.Character and p.Character:FindFirstChild("Head") then
					local dist = myPos and (p.Character.Head.Position - myPos).Magnitude or 0
					if dist <= 1500 then
						if activeESPs[p] and activeESPs[p].Char ~= p.Character then cleanESP(p) end
						if not activeESPs[p] then
							local h = Instance.new("Highlight")
							h.FillTransparency = 1
							h.OutlineTransparency = 0.35
							h.OutlineColor = espColor
							h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							h.Adornee = p.Character
							h.Parent = espFolder
							activeESPs[p] = { Highlight = h, Char = p.Character }
						elseif activeESPs[p].Highlight then
							activeESPs[p].Highlight.OutlineColor = espColor
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
	if not esEnemigoValido(plr) then return end
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
			line.Thickness = 2.4
			line.Transparency = 0.05
			table.insert(DrawingLines, line)
			local conn
			conn = RunService.RenderStepped:Connect(function()
				if not ESP_Lines or not IsInMatchStrict() or not esEnemigoValido(plr) or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
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
				else
					line.Visible = false
				end
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
	if not IsInMatchStrict() then return end
	if not (ESP_Names or ESP_Lines or ESP_Boxes) then return end
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
		POVCircleUI.Visible = v and IsInMatchStrict()
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

-- ===================== EFFECTS =====================
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

-- ===================== TOOLS =====================
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

-- ===================== GRÁFICO =====================
local originalLighting = {
	Technology = Lighting.Technology,
	Brightness = Lighting.Brightness,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	GlobalShadows = Lighting.GlobalShadows,
	FogEnd = Lighting.FogEnd,
	FogStart = Lighting.FogStart,
	ColorShift_Top = Lighting.ColorShift_Top,
	ColorShift_Bottom = Lighting.ColorShift_Bottom,
	ShadowSoftness = Lighting.ShadowSoftness,
	EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
	EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
	ExposureCompensation = Lighting.ExposureCompensation,
	ClockTime = Lighting.ClockTime,
	GeographicLatitude = Lighting.GeographicLatitude,
}

local function limpiarEfectos()
	for _, v in pairs(Lighting:GetChildren()) do
		if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect")
			or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("Atmosphere")
			or v:IsA("PostEffect") then
			v:Destroy()
		end
	end
end

local function mejorarPersonaje(character)
	if not character then return end
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CastShadow = true
			if part.Name ~= "HumanoidRootPart" then
				part.Material = Enum.Material.SmoothPlastic
				part.Reflectance = 0.08
			end
		end
		if part:IsA("ParticleEmitter") or part:IsA("Fire") or part:IsA("Smoke") or part:IsA("Sparkles") then
			part.Enabled = false
		end
	end
	local head = character:FindFirstChild("Head")
	if head then
		head.Material = Enum.Material.SmoothPlastic
		head.Reflectance = 0.05
	end
end

local function aplicarTexturasRealistasMapa()
	local char = player.Character
	local origin = char and char:GetPivot().Position or camera.CFrame.Position
	pcall(function()
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and not (char and obj:IsDescendantOf(char)) then
				if (obj.Position - origin).Magnitude <= 320 then
					obj.CastShadow = true
					if obj.Material == Enum.Material.Plastic or obj.Material == Enum.Material.SmoothPlastic then
						local n = string.lower(obj.Name)
						if n:find("wood") or n:find("plank") or n:find("deck") or n:find("crate") then
							obj.Material = Enum.Material.WoodPlanks
							obj.Reflectance = 0.04
						elseif n:find("brick") or n:find("wall") then
							obj.Material = Enum.Material.Brick
							obj.Reflectance = 0.03
						elseif n:find("metal") or n:find("steel") or n:find("iron") or n:find("rail") then
							obj.Material = Enum.Material.Metal
							obj.Reflectance = 0.18
						elseif n:find("grass") or n:find("lawn") or n:find("yard") then
							obj.Material = Enum.Material.Grass
							obj.Reflectance = 0.02
						elseif obj.Size.Y <= 1.1 and (obj.Size.X > 6 or obj.Size.Z > 6) then
							obj.Material = Enum.Material.Cobblestone
							obj.Reflectance = 0.06
						elseif obj.Size.Y > obj.Size.X and obj.Size.Y > obj.Size.Z then
							obj.Material = Enum.Material.Concrete
							obj.Reflectance = 0.05
						else
							obj.Material = Enum.Material.Slate
							obj.Reflectance = 0.08
						end
					end
				end
			end
		end
	end)
end

-- factor: 0 = Día pleno, 1 = Noche plena (permite transición suave durante los 5 minutos)
local function aplicarIluminacionConFactor(factor)
	factor = math.clamp(factor or 0, 0, 1)

	local atm = Lighting:FindFirstChildOfClass("Atmosphere")
	if not atm then
		atm = Instance.new("Atmosphere")
		atm.Name = "AlexAtmosphere"
		atm.Parent = Lighting
	end

	local cc = Lighting:FindFirstChild("AlexUltraCC")
	if not cc then
		cc = Instance.new("ColorCorrectionEffect")
		cc.Name = "AlexUltraCC"
		cc.Parent = Lighting
	end

	local bloom = Lighting:FindFirstChild("AlexUltraBloom")
	if not bloom then
		bloom = Instance.new("BloomEffect")
		bloom.Name = "AlexUltraBloom"
		bloom.Parent = Lighting
	end

	local sunRays = Lighting:FindFirstChild("AlexUltraSunRays")
	if not sunRays then
		sunRays = Instance.new("SunRaysEffect")
		sunRays.Name = "AlexUltraSunRays"
		sunRays.Parent = Lighting
	end

	local dof = Lighting:FindFirstChild("AlexUltraDOF")
	if not dof then
		dof = Instance.new("DepthOfFieldEffect")
		dof.Name = "AlexUltraDOF"
		dof.FarIntensity = 0.12
		dof.FocusDistance = 65
		dof.InFocusRadius = 90
		dof.NearIntensity = 0.02
		dof.Parent = Lighting
	end

	local dayClock, nightClock = 14.2, 0.5
	local clockVal = dayClock + (nightClock - dayClock) * factor
	if factor > 0.5 then
		-- cruzar medianoche de forma limpia
		clockVal = (dayClock * (1 - factor) + 24.5 * factor) % 24
	end

	Lighting.ClockTime = clockVal
	Lighting.Brightness = 2.35 * (1 - factor) + 0.65 * factor
	Lighting.ExposureCompensation = 0.14 * (1 - factor) + 0.24 * factor
	Lighting.FogStart = 40 * (1 - factor) + 18 * factor
	Lighting.FogEnd = 900 * (1 - factor) + 420 * factor

	Lighting.Ambient = Color3.fromRGB(68, 76, 90):Lerp(Color3.fromRGB(28, 36, 54), factor)
	Lighting.OutdoorAmbient = Color3.fromRGB(134, 144, 158):Lerp(Color3.fromRGB(44, 56, 82), factor)
	Lighting.ColorShift_Top = Color3.fromRGB(255, 246, 232):Lerp(Color3.fromRGB(76, 102, 152), factor)
	Lighting.ColorShift_Bottom = Color3.fromRGB(36, 42, 52):Lerp(Color3.fromRGB(14, 18, 28), factor)

	atm.Density = 0.22 * (1 - factor) + 0.34 * factor
	atm.Offset = 0.12 * (1 - factor) + 0.18 * factor
	atm.Color = Color3.fromRGB(198, 218, 244):Lerp(Color3.fromRGB(46, 62, 94), factor)
	atm.Decay = Color3.fromRGB(116, 136, 164):Lerp(Color3.fromRGB(18, 24, 38), factor)
	atm.Glare = 0.14 * (1 - factor) + 0.05 * factor
	atm.Haze = 1.15 * (1 - factor) + 1.45 * factor

	cc.Brightness = 0.02 * (1 - factor) - 0.02 * factor
	cc.Contrast = 0.12 * (1 - factor) + 0.15 * factor
	cc.Saturation = 0.06 * (1 - factor) - 0.06 * factor
	cc.TintColor = Color3.fromRGB(254, 249, 242):Lerp(Color3.fromRGB(196, 214, 245), factor)

	bloom.Intensity = 0.32 * (1 - factor) + 0.36 * factor
	bloom.Size = 18
	bloom.Threshold = 1.0

	sunRays.Intensity = 0.1 * (1 - factor) + 0.02 * factor
	sunRays.Spread = 0.42
end

local function aplicarIluminacionHora(hora)
	if hora == "Noche" then
		dayNightMode = "Noche"
		aplicarIluminacionConFactor(1)
	else
		dayNightMode = "Día"
		aplicarIluminacionConFactor(0)
	end
end

local function resetGraficos()
	limpiarEfectos()
	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
	end)
	Lighting.Technology = originalLighting.Technology
	Lighting.Brightness = originalLighting.Brightness
	Lighting.Ambient = originalLighting.Ambient
	Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
	Lighting.GlobalShadows = originalLighting.GlobalShadows
	Lighting.FogEnd = originalLighting.FogEnd
	Lighting.FogStart = originalLighting.FogStart
	Lighting.ColorShift_Top = originalLighting.ColorShift_Top
	Lighting.ColorShift_Bottom = originalLighting.ColorShift_Bottom
	Lighting.ShadowSoftness = originalLighting.ShadowSoftness
	Lighting.EnvironmentDiffuseScale = originalLighting.EnvironmentDiffuseScale
	Lighting.EnvironmentSpecularScale = originalLighting.EnvironmentSpecularScale
	Lighting.ExposureCompensation = originalLighting.ExposureCompensation
	Lighting.ClockTime = originalLighting.ClockTime
	Lighting.GeographicLatitude = originalLighting.GeographicLatitude
end

local function aplicarGraficoCartonFPS()
	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level04
	end)
	Lighting.GlobalShadows = false
	Lighting.Technology = Enum.Technology.Compatibility
	Lighting.FogEnd = 700
	Lighting.FogStart = 50
	limpiarEfectos()

	local char = player.Character
	if char then
		local pos = char:GetPivot().Position
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then
				if (obj.Position - pos).Magnitude < 160 then
					pcall(function()
						obj.Material = Enum.Material.Cardboard
					end)
				end
			end
		end
	end

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
			obj.Enabled = false
		end
	end
end

local function aplicarGraficoRealistaCharacter()
	limpiarEfectos()
	local cc = Instance.new("ColorCorrectionEffect")
	cc.Name = "AlexCC"
	cc.Brightness = 0.02
	cc.Contrast = -0.04
	cc.Saturation = -0.15
	cc.TintColor = Color3.fromRGB(255, 248, 235)
	cc.Parent = Lighting

	if player.Character then
		mejorarPersonaje(player.Character)
	end
end

local function aplicarGraficoSuperReal()
	pcall(function()
		Lighting.Technology = Enum.Technology.Future
	end)

	Lighting.GlobalShadows = true
	Lighting.ShadowSoftness = 0.14
	Lighting.EnvironmentDiffuseScale = 1.2
	Lighting.EnvironmentSpecularScale = 1.4
	Lighting.GeographicLatitude = 28

	pcall(function()
		local Render = settings().Rendering
		Render.QualityLevel = Enum.QualityLevel.Level21
		Render.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
		Render.EditQualityLevel = Enum.QualityLevel.Level21
		Render.EagerBulkExecution = true
	end)

	if Terrain then
		pcall(function()
			Terrain.WaterWaveSize = 0.15
			Terrain.WaterWaveSpeed = 12
			Terrain.WaterReflectance = 0.58
			Terrain.WaterTransparency = 0.28
			Terrain.Decoration = true
		end)
	end

	limpiarEfectos()
	aplicarTexturasRealistasMapa()
	aplicarIluminacionHora(dayNightMode)

	if player.Character then
		mejorarPersonaje(player.Character)
	end

	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Gráfico Super Ultra",
			Text = "Activo · " .. dayNightMode,
			Duration = 4
		})
	end)
end

Tabs.Grafico:Section({ Title = "Gráficos Libres", Icon = "solar:monitor-bold" })

local cartonBtn
local realismBtn
local superUltraBtn

cartonBtn = Tabs.Grafico:Button({
	Title = "Gráfico Cartón / FPS",
	Callback = function()
		cartonModeActive = not cartonModeActive
		if cartonModeActive then
			realismCharActive = false
			superUltraActive = false
			autoDayNightCycle = false
			if realismBtn then pcall(function() realismBtn:SetTitle("Gráfico Realismo Character") end) end
			if superUltraBtn then pcall(function() superUltraBtn:SetTitle(graphicsUnlocked and "Gráfico Super Ultra" or "Gráfico Super Ultra (Bloqueado)") end) end
			aplicarGraficoCartonFPS()
			cartonBtn:SetTitle("Gráfico Cartón / FPS ✓")
		else
			resetGraficos()
			cartonBtn:SetTitle("Gráfico Cartón / FPS")
		end
	end
})

realismBtn = Tabs.Grafico:Button({
	Title = "Gráfico Realismo Character",
	Callback = function()
		realismCharActive = not realismCharActive
		if realismCharActive then
			cartonModeActive = false
			superUltraActive = false
			autoDayNightCycle = false
			if cartonBtn then pcall(function() cartonBtn:SetTitle("Gráfico Cartón / FPS") end) end
			if superUltraBtn then pcall(function() superUltraBtn:SetTitle(graphicsUnlocked and "Gráfico Super Ultra" or "Gráfico Super Ultra (Bloqueado)") end) end
			aplicarGraficoRealistaCharacter()
			realismBtn:SetTitle("Gráfico Realismo Character ✓")
		else
			resetGraficos()
			realismBtn:SetTitle("Gráfico Realismo Character")
		end
	end
})

Tabs.Grafico:Space()
Tabs.Grafico:Divider()
Tabs.Grafico:Section({ Title = "Gráfico Super Ultra & Clima", Icon = "solar:key-bold" })

local graphicsKeyInput = Tabs.Grafico:Input({
	Title = "Ingresar Key",
	Placeholder = "Escribe aquí...",
	Callback = function(text)
		graphicsTypedKey = tostring(text or "")
	end
})

local graphicsStatus = Tabs.Grafico:Paragraph({
	Title = "Estado",
	Desc = "Esperando validación"
})

Tabs.Grafico:Button({
	Title = "Validar Key",
	Callback = function()
		local raw = graphicsTypedKey
		if (raw == "" or raw == nil) and graphicsKeyInput and graphicsKeyInput.Get then
			pcall(function() raw = tostring(graphicsKeyInput:Get() or "") end)
		end
		local cleaned = raw:gsub("^%s+", ""):gsub("%s+$", "")
		if cleaned == "alexgrafico" then
			graphicsUnlocked = true
			graphicsStatus:SetDesc("Desbloqueado ✓")
			if superUltraBtn then
				pcall(function() superUltraBtn:SetTitle("Gráfico Super Ultra") end)
			end
			WindUI:Notify({
				Title = "Gráfico",
				Content = "Acceso concedido",
				Duration = 3
			})
		else
			graphicsStatus:SetDesc("Key incorrecta")
			WindUI:Notify({
				Title = "Gráfico",
				Content = "Key incorrecta",
				Duration = 2
			})
		end
	end
})

superUltraBtn = Tabs.Grafico:Button({
	Title = "Gráfico Super Ultra (Bloqueado)",
	Callback = function()
		if not graphicsUnlocked then
			WindUI:Notify({
				Title = "Gráfico",
				Content = "Valida la key primero",
				Duration = 3
			})
			return
		end

		superUltraActive = not superUltraActive
		if superUltraActive then
			cartonModeActive = false
			realismCharActive = false
			if cartonBtn then pcall(function() cartonBtn:SetTitle("Gráfico Cartón / FPS") end) end
			if realismBtn then pcall(function() realismBtn:SetTitle("Gráfico Realismo Character") end) end
			aplicarGraficoSuperReal()
			superUltraBtn:SetTitle("Gráfico Super Ultra ✓")
		else
			autoDayNightCycle = false
			resetGraficos()
			superUltraBtn:SetTitle("Gráfico Super Ultra")
		end
	end
})

Tabs.Grafico:Dropdown({
	Title = "Ambiente Día / Noche",
	Values = { "Día", "Noche" },
	Value = "Día",
	Callback = function(v)
		dayNightMode = v
		if superUltraActive then
			aplicarIluminacionHora(dayNightMode)
		end
	end
})

Tabs.Grafico:Button({
	Title = "Alternar Día / Noche",
	Callback = function()
		dayNightMode = (dayNightMode == "Día") and "Noche" or "Día"
		if superUltraActive then
			aplicarIluminacionHora(dayNightMode)
		end
		WindUI:Notify({
			Title = "Ambiente",
			Content = "Horario: " .. dayNightMode,
			Duration = 2
		})
	end
})

Tabs.Grafico:Toggle({
	Title = "Ciclo Día / Noche (5m c/u)",
	Value = false,
	Callback = function(v)
		autoDayNightCycle = v
	end
})

-- Ciclo continuo: 5 minutos (300s) de Día y 5 minutos (300s) de Noche
task.spawn(function()
	local phaseElapsed = 0
	local isNightPhase = (dayNightMode == "Noche")
	local lastTick = os.clock()

	while task.wait(1) do
		local now = os.clock()
		local dt = now - lastTick
		lastTick = now

		if autoDayNightCycle and superUltraActive then
			phaseElapsed = phaseElapsed + dt
			if phaseElapsed >= PHASE_DURATION then
				phaseElapsed = phaseElapsed - PHASE_DURATION
				isNightPhase = not isNightPhase
				dayNightMode = isNightPhase and "Noche" or "Día"
			end

			local progress = math.clamp(phaseElapsed / PHASE_DURATION, 0, 1)
			-- Transición suave en los primeros/últimos 15 segundos de cada tramo de 5 minutos
			local blendWindow = 15 / PHASE_DURATION
			local factor
			if not isNightPhase then
				-- Fase Día (5 min): empieza en 0 y al final transiciona hacia noche
				if progress > (1 - blendWindow) then
					factor = (progress - (1 - blendWindow)) / blendWindow
				else
					factor = 0
				end
			else
				-- Fase Noche (5 min): empieza en 1 y al final transiciona hacia día
				if progress > (1 - blendWindow) then
					factor = 1 - ((progress - (1 - blendWindow)) / blendWindow)
				else
					factor = 1
				end
			end

			aplicarIluminacionConFactor(factor)
		else
			phaseElapsed = 0
			isNightPhase = (dayNightMode == "Noche")
		end
	end
end)

player.CharacterAdded:Connect(function(character)
	task.wait(0.6)
	if realismCharActive or superUltraActive then
		mejorarPersonaje(character)
	end
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
		if ESP_POV then
			POVCircleUI.Visible = IsInMatchStrict()
			UpdatePOV()
		else
			POVCircleUI.Visible = false
		end
	end
end)

Players.PlayerRemoving:Connect(function()
	ClearExtraESP()
	task.wait(0.1)
	UpdatePersona()
end)

print("Alex Hub Completo | alex@11")
