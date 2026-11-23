-- ==========================================
-- Alex Hub Completo · Todos los iPhone 12 + Key + 60s Hacker + Full UI
-- Alex_12alex28 | TikTok: alex@11
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local player = Players.LocalPlayer
while not player do task.wait() player = Players.LocalPlayer end
local camera = workspace.CurrentCamera

-- Pon en true si quieres probar el flujo de iPhone 12 en otro equipo/emulador
local MODO_PRUEBA_IPHONE12 = false

local function montarGui(gui)
	local ok = pcall(function()
		gui.Parent = game:GetService("CoreGui")
	end)
	if not ok or not gui.Parent then
		gui.Parent = player:WaitForChild("PlayerGui")
	end
end

-- ===================== DETECCIÓN PARA TODOS LOS iPHONE 12 =====================
-- Cubre iPhone 12 mini (~812x375), iPhone 12 / 12 Pro (~844x390) y iPhone 12 Pro Max (~926x428)
local function detectarIPhone12()
	if MODO_PRUEBA_IPHONE12 then
		return true, "iPhone 12 Family (Modo prueba activo)"
	end

	local okPlat, plat = pcall(function() return UserInputService:GetPlatform() end)
	local platform = okPlat and plat or Enum.Platform.None
	local vp = camera and camera.ViewportSize or Vector2.new(0, 0)
	local w = math.max(vp.X, vp.Y)
	local h = math.min(vp.X, vp.Y)
	local ratio = (h > 0) and (w / h) or 0
	local isTouch = UserInputService.TouchEnabled

	local esIOS = (platform == Enum.Platform.IOS)
	local rangoAncho12 = (w >= 790 and w <= 955)
	local rangoAlto12 = (h >= 355 and h <= 450)
	local ratioOLED12 = (ratio >= 2.02 and ratio <= 2.30)

	if esIOS and isTouch and rangoAncho12 and rangoAlto12 and ratioOLED12 then
		local modeloEstimado = "iPhone 12 / 12 Pro"
		if w <= 822 then
			modeloEstimado = "iPhone 12 mini"
		elseif w >= 905 then
			modeloEstimado = "iPhone 12 Pro Max"
		end
		return true, modeloEstimado .. " detectado (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")"
	end

	return false, "No coincide con ningún iPhone 12 (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")"
end

-- ===================== DETECCIÓN GENERAL DE DISPOSITIVO (PESTAÑA GRÁFICO) =====================
local function detectarDispositivo()
	local okPlat, plat = pcall(function() return UserInputService:GetPlatform() end)
	local platform = okPlat and plat or Enum.Platform.None
	local vp = camera and camera.ViewportSize or Vector2.new(1280, 720)
	local w = math.max(vp.X, vp.Y)
	local h = math.min(vp.X, vp.Y)
	local ratio = (h > 0) and (w / h) or 1.77
	local isTouch = UserInputService.TouchEnabled
	local isKeyboard = UserInputService.KeyboardEnabled
	local isMouse = UserInputService.MouseEnabled

	if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux
		or (not isTouch and isKeyboard and isMouse) then
		return {
			nombre = "PC (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
			categoria = "PC",
			compatible = true,
			detalle = "Equipo de escritorio admitido"
		}
	end

	if platform == Enum.Platform.IOS then
		if ratio <= 1.52 then
			return {
				nombre = "iPad (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
				categoria = "iPad",
				compatible = true,
				detalle = "Pantalla iPad admitida"
			}
		end

		if w >= 790 then
			return {
				nombre = "iPhone 12 o superior (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
				categoria = "iPhone 12+",
				compatible = true,
				detalle = "Modelo iPhone compatible"
			}
		else
			return {
				nombre = "iPhone anterior a iPhone 12 (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
				categoria = "iPhone antiguo",
				compatible = false,
				detalle = "Solo iPhone 12 o superior"
			}
		end
	end

	if platform == Enum.Platform.Android or isTouch then
		if ratio <= 1.72 and w >= 900 then
			return {
				nombre = "Tablet Samsung (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
				categoria = "Tablet Samsung",
				compatible = true,
				detalle = "Tablet admitida"
			}
		else
			return {
				nombre = "Dispositivo móvil no tablet (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
				categoria = "No admitido",
				compatible = false,
				detalle = "Solo Tablet Samsung, iPad, iPhone 12+ o PC"
			}
		end
	end

	return {
		nombre = "Dispositivo (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
		categoria = "No admitido",
		compatible = false,
		detalle = "Dispositivo no admitido"
	}
end

-- ===================== PANTALLA COMPLETA INICIAL + BOTÓN ABAJO =====================
local gateGui = Instance.new("ScreenGui")
gateGui.Name = "AlexIPhone12GateUI"
gateGui.ResetOnSpawn = false
gateGui.IgnoreGuiInset = true
gateGui.DisplayOrder = 999999
montarGui(gateGui)

local fullScreen = Instance.new("Frame")
fullScreen.Name = "FullScreenGate"
fullScreen.Size = UDim2.new(1, 0, 1, 0)
fullScreen.Position = UDim2.new(0, 0, 0, 0)
fullScreen.BackgroundColor3 = Color3.fromRGB(9, 11, 15)
fullScreen.BackgroundTransparency = 0
fullScreen.BorderSizePixel = 0
fullScreen.ZIndex = 100
fullScreen.Parent = gateGui

local centerCard = Instance.new("Frame")
centerCard.Size = UDim2.new(0.86, 0, 0, 175)
centerCard.Position = UDim2.new(0.5, 0, 0.42, 0)
centerCard.AnchorPoint = Vector2.new(0.5, 0.5)
centerCard.BackgroundColor3 = Color3.fromRGB(16, 20, 27)
centerCard.BorderSizePixel = 0
centerCard.ZIndex = 101
centerCard.Parent = fullScreen
Instance.new("UICorner", centerCard).CornerRadius = UDim.new(0, 14)

local cardStroke = Instance.new("UIStroke")
cardStroke.Color = Color3.fromRGB(46, 56, 72)
cardStroke.Thickness = 1.2
cardStroke.Parent = centerCard

local mainMsg = Instance.new("TextLabel")
mainMsg.Size = UDim2.new(1, -24, 0, 44)
mainMsg.Position = UDim2.new(0.5, 0, 0.36, 0)
mainMsg.AnchorPoint = Vector2.new(0.5, 0.5)
mainMsg.BackgroundTransparency = 1
mainMsg.Text = "iPhone no compatible"
mainMsg.Font = Enum.Font.GothamBold
mainMsg.TextSize = 22
mainMsg.TextColor3 = Color3.fromRGB(232, 238, 246)
mainMsg.ZIndex = 102
mainMsg.Parent = centerCard

local subMsg = Instance.new("TextLabel")
subMsg.Size = UDim2.new(1, -24, 0, 40)
subMsg.Position = UDim2.new(0.5, 0, 0.68, 0)
subMsg.AnchorPoint = Vector2.new(0.5, 0.5)
subMsg.BackgroundTransparency = 1
subMsg.Text = "Usa el botón inferior para verificar si tu equipo es de la serie iPhone 12"
subMsg.Font = Enum.Font.Gotham
subMsg.TextSize = 12
subMsg.TextColor3 = Color3.fromRGB(145, 156, 174)
subMsg.TextWrapped = true
subMsg.ZIndex = 102
subMsg.Parent = centerCard

local checkDeviceBtn = Instance.new("TextButton")
checkDeviceBtn.Name = "VerificarDispositivoBtn"
checkDeviceBtn.Size = UDim2.new(0.86, 0, 0, 48)
checkDeviceBtn.Position = UDim2.new(0.5, 0, 0.90, 0)
checkDeviceBtn.AnchorPoint = Vector2.new(0.5, 0.5)
checkDeviceBtn.BackgroundColor3 = Color3.fromRGB(27, 37, 50)
checkDeviceBtn.Text = "Verificar dispositivo"
checkDeviceBtn.Font = Enum.Font.GothamBold
checkDeviceBtn.TextSize = 14
checkDeviceBtn.TextColor3 = Color3.fromRGB(228, 236, 246)
checkDeviceBtn.BorderSizePixel = 0
checkDeviceBtn.ZIndex = 103
checkDeviceBtn.Parent = fullScreen
Instance.new("UICorner", checkDeviceBtn).CornerRadius = UDim.new(0, 12)

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(125, 162, 196)
btnStroke.Thickness = 1.2
btnStroke.Parent = checkDeviceBtn

-- ===================== SISTEMA DE KEY (TODOS LOS iPHONE 12) =====================
local KEY_VALIDATED = false
local SCRIPT_VERIFIED = false
local isRunningHacker60s = false

local VALID_KEYS = {
	["alex"] = true,
	["alex11"] = true,
}

local failedAttempts = 0
local cooldownUntil = 0

local function normalizarKey(raw)
	local s = tostring(raw or "")
	s = s:gsub("^%s+", ""):gsub("%s+$", "")
	return string.lower(s)
end

local function esKeyValida(raw)
	local k = normalizarKey(raw)
	if k == "" then return false end
	return VALID_KEYS[k] == true
end

local keyPanel = Instance.new("Frame")
keyPanel.Name = "IPhone12KeyPanel"
keyPanel.Size = UDim2.new(0, 336, 0, 396)
keyPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
keyPanel.AnchorPoint = Vector2.new(0.5, 0.5)
keyPanel.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
keyPanel.BorderSizePixel = 0
keyPanel.Visible = false
keyPanel.ZIndex = 150
keyPanel.Parent = fullScreen
Instance.new("UICorner", keyPanel).CornerRadius = UDim.new(0, 15)

local kpStroke = Instance.new("UIStroke")
kpStroke.Color = Color3.fromRGB(48, 58, 74)
kpStroke.Thickness = 1.2
kpStroke.Parent = keyPanel

local kpTitle = Instance.new("TextLabel")
kpTitle.Size = UDim2.new(1, -24, 0, 28)
kpTitle.Position = UDim2.new(0.5, 0, 0, 18)
kpTitle.AnchorPoint = Vector2.new(0.5, 0)
kpTitle.BackgroundTransparency = 1
kpTitle.Text = "IPHONE 12 SERIES · KEY ACCESS"
kpTitle.Font = Enum.Font.GothamBold
kpTitle.TextSize = 16
kpTitle.TextColor3 = Color3.fromRGB(228, 236, 246)
kpTitle.ZIndex = 151
kpTitle.Parent = keyPanel

local kpSub = Instance.new("TextLabel")
kpSub.Size = UDim2.new(1, -24, 0, 20)
kpSub.Position = UDim2.new(0.5, 0, 0, 44)
kpSub.AnchorPoint = Vector2.new(0.5, 0)
kpSub.BackgroundTransparency = 1
kpSub.Text = "Dispositivo confirmado · Ingresa tu clave"
kpSub.Font = Enum.Font.GothamMedium
kpSub.TextSize = 11
kpSub.TextColor3 = Color3.fromRGB(135, 198, 168)
kpSub.ZIndex = 151
kpSub.Parent = keyPanel

local infoBox = Instance.new("Frame")
infoBox.Size = UDim2.new(0.88, 0, 0, 64)
infoBox.Position = UDim2.new(0.5, 0, 0, 76)
infoBox.AnchorPoint = Vector2.new(0.5, 0)
infoBox.BackgroundColor3 = Color3.fromRGB(20, 24, 32)
infoBox.BorderSizePixel = 0
infoBox.ZIndex = 151
infoBox.Parent = keyPanel
Instance.new("UICorner", infoBox).CornerRadius = UDim.new(0, 10)

local infoLbl = Instance.new("TextLabel")
infoLbl.Size = UDim2.new(1, -96, 1, -12)
infoLbl.Position = UDim2.new(0, 12, 0, 6)
infoLbl.BackgroundTransparency = 1
infoLbl.Text = "Clave válida: alex\nLuego pulsa VERIFICAR (60s)"
infoLbl.Font = Enum.Font.Gotham
infoLbl.TextSize = 11
infoLbl.TextColor3 = Color3.fromRGB(170, 180, 196)
infoLbl.TextXAlignment = Enum.TextXAlignment.Left
infoLbl.TextWrapped = true
infoLbl.ZIndex = 152
infoLbl.Parent = infoBox

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 74, 0, 30)
copyBtn.Position = UDim2.new(1, -84, 0.5, 0)
copyBtn.AnchorPoint = Vector2.new(0, 0.5)
copyBtn.BackgroundColor3 = Color3.fromRGB(28, 35, 46)
copyBtn.Text = "Copy"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 11
copyBtn.TextColor3 = Color3.fromRGB(210, 220, 234)
copyBtn.BorderSizePixel = 0
copyBtn.ZIndex = 152
copyBtn.Parent = infoBox
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 8)

copyBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if setclipboard then setclipboard("alex") end
	end)
	copyBtn.Text = "Copiado"
	task.wait(1.1)
	copyBtn.Text = "Copy"
end)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.88, 0, 0, 42)
keyInput.Position = UDim2.new(0.5, 0, 0, 154)
keyInput.AnchorPoint = Vector2.new(0.5, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(19, 23, 31)
keyInput.PlaceholderText = "Escribe tu key..."
keyInput.Text = ""
keyInput.Font = Enum.Font.GothamMedium
keyInput.TextSize = 13
keyInput.TextColor3 = Color3.fromRGB(230, 236, 244)
keyInput.PlaceholderColor3 = Color3.fromRGB(115, 125, 142)
keyInput.ClearTextOnFocus = false
keyInput.BorderSizePixel = 0
keyInput.ZIndex = 151
keyInput.Parent = keyPanel
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 10)

local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(0.88, 0, 0, 22)
keyStatus.Position = UDim2.new(0.5, 0, 0, 204)
keyStatus.AnchorPoint = Vector2.new(0.5, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.Text = "Esperando clave..."
keyStatus.Font = Enum.Font.GothamMedium
keyStatus.TextSize = 11
keyStatus.TextColor3 = Color3.fromRGB(145, 156, 174)
keyStatus.ZIndex = 151
keyStatus.Parent = keyPanel

local validateKeyBtn = Instance.new("TextButton")
validateKeyBtn.Size = UDim2.new(0.88, 0, 0, 42)
validateKeyBtn.Position = UDim2.new(0.5, 0, 0, 234)
validateKeyBtn.AnchorPoint = Vector2.new(0.5, 0)
validateKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 54)
validateKeyBtn.Text = "VALIDAR KEY"
validateKeyBtn.Font = Enum.Font.GothamBold
validateKeyBtn.TextSize = 12
validateKeyBtn.TextColor3 = Color3.fromRGB(230, 238, 248)
validateKeyBtn.BorderSizePixel = 0
validateKeyBtn.ZIndex = 151
validateKeyBtn.Parent = keyPanel
Instance.new("UICorner", validateKeyBtn).CornerRadius = UDim.new(0, 10)

local verify60Btn = Instance.new("TextButton")
verify60Btn.Size = UDim2.new(0.88, 0, 0, 46)
verify60Btn.Position = UDim2.new(0.5, 0, 0, 288)
verify60Btn.AnchorPoint = Vector2.new(0.5, 0)
verify60Btn.BackgroundColor3 = Color3.fromRGB(24, 52, 46)
verify60Btn.Text = "VERIFICAR (60s)"
verify60Btn.Font = Enum.Font.GothamBold
verify60Btn.TextSize = 13
verify60Btn.TextColor3 = Color3.fromRGB(145, 225, 185)
verify60Btn.BorderSizePixel = 0
verify60Btn.Visible = false
verify60Btn.ZIndex = 151
verify60Btn.Parent = keyPanel
Instance.new("UICorner", verify60Btn).CornerRadius = UDim.new(0, 10)
local v60Stroke = Instance.new("UIStroke")
v60Stroke.Color = Color3.fromRGB(115, 205, 165)
v60Stroke.Thickness = 1.2
v60Stroke.Parent = verify60Btn

-- ===================== VERIFICACIÓN HACKER DE 60 SEGUNDOS (1 MINUTO) =====================
local function hexRandom(len)
	local chars = "0123456789ABCDEF"
	local t = {}
	for i = 1, len do
		local idx = math.random(1, #chars)
		t[i] = chars:sub(idx, idx)
	end
	return table.concat(t)
end

local function ejecutarVerificacionHacker60s(onComplete)
	if isRunningHacker60s then return end
	isRunningHacker60s = true

	local hackScreen = Instance.new("Frame")
	hackScreen.Name = "HackerAudit60s"
	hackScreen.Size = UDim2.new(1, 0, 1, 0)
	hackScreen.Position = UDim2.new(0, 0, 0, 0)
	hackScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	hackScreen.BackgroundTransparency = 0
	hackScreen.BorderSizePixel = 0
	hackScreen.ZIndex = 600
	hackScreen.Parent = gateGui

	local term = Instance.new("Frame")
	term.Size = UDim2.new(0.92, 0, 0, 360)
	term.Position = UDim2.new(0.5, 0, 0.5, 0)
	term.AnchorPoint = Vector2.new(0.5, 0.5)
	term.BackgroundColor3 = Color3.fromRGB(4, 7, 6)
	term.BorderSizePixel = 0
	term.ZIndex = 601
	term.Parent = hackScreen
	Instance.new("UICorner", term).CornerRadius = UDim.new(0, 12)

	local tStroke = Instance.new("UIStroke")
	tStroke.Color = Color3.fromRGB(45, 130, 85)
	tStroke.Thickness = 1.2
	tStroke.Parent = term

	local topBar = Instance.new("TextLabel")
	topBar.Size = UDim2.new(1, -24, 0, 26)
	topBar.Position = UDim2.new(0, 12, 0, 12)
	topBar.BackgroundTransparency = 1
	topBar.Text = "ROOT@IPHONE12-SERIES:~# ALEX-HACKER-AUDIT [60s]"
	topBar.Font = Enum.Font.Code
	topBar.TextSize = 12
	topBar.TextColor3 = Color3.fromRGB(110, 235, 155)
	topBar.TextXAlignment = Enum.TextXAlignment.Left
	topBar.ZIndex = 602
	topBar.Parent = term

	local l1 = Instance.new("TextLabel")
	l1.Size = UDim2.new(1, -24, 0, 22)
	l1.Position = UDim2.new(0, 12, 0, 46)
	l1.BackgroundTransparency = 1
	l1.Text = "> pipipín, qué tal · abriendo túnel de diagnóstico..."
	l1.Font = Enum.Font.Code
	l1.TextSize = 12
	l1.TextColor3 = Color3.fromRGB(145, 240, 175)
	l1.TextXAlignment = Enum.TextXAlignment.Left
	l1.ZIndex = 602
	l1.Parent = term

	local l2 = Instance.new("TextLabel")
	l2.Size = UDim2.new(1, -24, 0, 22)
	l2.Position = UDim2.new(0, 12, 0, 74)
	l2.BackgroundTransparency = 1
	l2.Text = ""
	l2.Font = Enum.Font.Code
	l2.TextSize = 12
	l2.TextColor3 = Color3.fromRGB(120, 200, 235)
	l2.TextXAlignment = Enum.TextXAlignment.Left
	l2.ZIndex = 602
	l2.Parent = term

	local l3 = Instance.new("TextLabel")
	l3.Size = UDim2.new(1, -24, 0, 22)
	l3.Position = UDim2.new(0, 12, 0, 102)
	l3.BackgroundTransparency = 1
	l3.Text = ""
	l3.Font = Enum.Font.Code
	l3.TextSize = 12
	l3.TextColor3 = Color3.fromRGB(185, 220, 195)
	l3.TextXAlignment = Enum.TextXAlignment.Left
	l3.ZIndex = 602
	l3.Parent = term

	local hexDump = Instance.new("TextLabel")
	hexDump.Size = UDim2.new(1, -24, 0, 44)
	hexDump.Position = UDim2.new(0, 12, 0, 134)
	hexDump.BackgroundTransparency = 1
	hexDump.Text = ""
	hexDump.Font = Enum.Font.Code
	hexDump.TextSize = 11
	hexDump.TextColor3 = Color3.fromRGB(95, 185, 130)
	hexDump.TextXAlignment = Enum.TextXAlignment.Left
	hexDump.TextWrapped = true
	hexDump.ZIndex = 602
	hexDump.Parent = term

	local countLbl = Instance.new("TextLabel")
	countLbl.Size = UDim2.new(1, -24, 0, 24)
	countLbl.Position = UDim2.new(0, 12, 0, 192)
	countLbl.BackgroundTransparency = 1
	countLbl.Text = "0% · 60s restantes"
	countLbl.Font = Enum.Font.Code
	countLbl.TextSize = 14
	countLbl.TextColor3 = Color3.fromRGB(220, 245, 230)
	countLbl.TextXAlignment = Enum.TextXAlignment.Left
	countLbl.ZIndex = 602
	countLbl.Parent = term

	local barTrack = Instance.new("Frame")
	barTrack.Size = UDim2.new(1, -24, 0, 14)
	barTrack.Position = UDim2.new(0, 12, 0, 224)
	barTrack.BackgroundColor3 = Color3.fromRGB(16, 26, 22)
	barTrack.BorderSizePixel = 0
	barTrack.ZIndex = 602
	barTrack.Parent = term
	Instance.new("UICorner", barTrack).CornerRadius = UDim.new(1, 0)

	local barFill = Instance.new("Frame")
	barFill.Size = UDim2.new(0, 0, 1, 0)
	barFill.BackgroundColor3 = Color3.fromRGB(95, 220, 145)
	barFill.BorderSizePixel = 0
	barFill.ZIndex = 603
	barFill.Parent = barTrack
	Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

	local footerState = Instance.new("TextLabel")
	footerState.Size = UDim2.new(1, -24, 0, 74)
	footerState.Position = UDim2.new(0, 12, 0, 254)
	footerState.BackgroundTransparency = 1
	footerState.Text = "Iniciando escaneo profundo del script..."
	footerState.Font = Enum.Font.Code
	footerState.TextSize = 12
	footerState.TextColor3 = Color3.fromRGB(140, 210, 165)
	footerState.TextWrapped = true
	footerState.ZIndex = 602
	footerState.Parent = term

	task.spawn(function()
		local duration = 60
		local elapsed = 0
		local spin = { "|", "/", "-", "\\" }
		local tickCount = 0

		while elapsed < duration do
			local dt = task.wait(0.1)
			elapsed = math.min(duration, elapsed + dt)
			tickCount += 1

			local frac = elapsed / duration
			local pct = math.floor(frac * 100)
			local rem = math.max(0, math.ceil(duration - elapsed))
			local sp = spin[(tickCount % #spin) + 1]

			barFill.Size = UDim2.new(frac, 0, 1, 0)
			countLbl.Text = tostring(pct) .. "% · " .. tostring(rem) .. "s restantes [" .. sp .. "]"

			if tickCount % 2 == 0 then
				hexDump.Text = string.format(
					"0x%s  0x%s  0x%s\nMEM_CHECK::%s  SOCKET::%s",
					hexRandom(8), hexRandom(8), hexRandom(8), hexRandom(6), hexRandom(6)
				)
			end

			if frac < 0.20 then
				l2.Text = "> [SYS-01] inyectando sonda de integridad en memoria " .. sp
				l3.Text = "> verificando Players, Workspace, Lighting y RunService..."
				footerState.Text = "FASE 1/5 · Mapeando servicios y entorno del juego..."
			elseif frac < 0.40 then
				l2.Text = "> [NET-02] auditando remotes, filtros de equipo y objetivos " .. sp
				l3.Text = "> comprobando exclusión de aliados y validación de vida..."
				footerState.Text = "FASE 2/5 · Verificando filtros de combate y detección..."
			elseif frac < 0.60 then
				l2.Text = "> [GFX-03] inspeccionando shaders, materiales y paquetes " .. sp
				l3.Text = "> validando renderizado, iluminación y animaciones..."
				footerState.Text = "FASE 3/5 · Auditando módulos visuales y paquetes..."
			elseif frac < 0.80 then
				l2.Text = "> [UI-04] comprobando ventanas, paneles y controles activos " .. sp
				l3.Text = "> verificando ausencia de fallos en interfaz y loops..."
				footerState.Text = "FASE 4/5 · Probando estabilidad de módulos y UI..."
			else
				l2.Text = "> [LOCK-05] sellando firma de ejecución para iPhone 12 " .. sp
				l3.Text = "> todo el script verificado sin errores críticos..."
				footerState.Text = "FASE 5/5 · Finalizando auditoría de 60 segundos..."
			end
		end

		local allSystemsHealthy = (Players ~= nil and Lighting ~= nil and RunService ~= nil and workspace ~= nil)
		SCRIPT_VERIFIED = allSystemsHealthy

		l2.Text = "> [OK-200] AUDITORÍA COMPLETA · 0 ERRORES DETECTADOS"
		l3.Text = "> ACCESO CONCEDIDO AL MENÚ PRINCIPAL"
		footerState.Text = "VERIFICACIÓN DE 1 MINUTO COMPLETADA ✓\nCargando interfaz..."
		footerState.TextColor3 = Color3.fromRGB(135, 245, 175)

		task.wait(1.4)
		if hackScreen and hackScreen.Parent then
			hackScreen:Destroy()
		end
		isRunningHacker60s = false
		if onComplete then onComplete(true) end
	end)
end

checkDeviceBtn.MouseButton1Click:Connect(function()
	checkDeviceBtn.Text = "Verificando serie iPhone 12..."
	task.wait(0.35)
	local is12, infoText = detectarIPhone12()
	if is12 then
		mainMsg.Visible = false
		subMsg.Visible = false
		centerCard.Visible = false
		checkDeviceBtn.Visible = false
		keyPanel.Visible = true
		keyStatus.Text = infoText
		keyStatus.TextColor3 = Color3.fromRGB(135, 205, 170)
	else
		mainMsg.Text = "iPhone no compatible"
		subMsg.Text = infoText .. "\nSolo disponible para modelos iPhone 12"
		subMsg.TextColor3 = Color3.fromRGB(214, 125, 125)
		checkDeviceBtn.Text = "Verificar dispositivo"
	end
end)

local function intentarValidarKey()
	if KEY_VALIDATED then return end
	local now = os.clock()
	if now < cooldownUntil then
		keyStatus.Text = "Espera " .. tostring(math.ceil(cooldownUntil - now)) .. "s"
		keyStatus.TextColor3 = Color3.fromRGB(214, 155, 115)
		return
	end

	local raw = keyInput.Text or ""
	if normalizarKey(raw) == "" then
		keyStatus.Text = "Escribe una clave primero"
		keyStatus.TextColor3 = Color3.fromRGB(214, 155, 115)
		return
	end

	if esKeyValida(raw) then
		KEY_VALIDATED = true
		failedAttempts = 0
		validateKeyBtn.Text = "KEY VÁLIDA ✓"
		validateKeyBtn.TextColor3 = Color3.fromRGB(135, 215, 175)
		keyStatus.Text = "Key aprobada · Pulsa VERIFICAR (60s)"
		keyStatus.TextColor3 = Color3.fromRGB(135, 215, 175)
		verify60Btn.Visible = true
	else
		failedAttempts += 1
		if failedAttempts >= 4 then
			cooldownUntil = os.clock() + 5
			failedAttempts = 0
			keyStatus.Text = "Demasiados intentos · Espera 5s"
		else
			keyStatus.Text = "Key incorrecta (" .. tostring(failedAttempts) .. "/4)"
		end
		keyStatus.TextColor3 = Color3.fromRGB(214, 125, 125)
	end
end

validateKeyBtn.MouseButton1Click:Connect(intentarValidarKey)
keyInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then intentarValidarKey() end
end)

verify60Btn.MouseButton1Click:Connect(function()
	if not KEY_VALIDATED or isRunningHacker60s then return end
	verify60Btn.Text = "INICIANDO..."
	ejecutarVerificacionHacker60s(function()
		if gateGui and gateGui.Parent then
			gateGui:Destroy()
		end
	end)
end)

while not SCRIPT_VERIFIED do task.wait(0.05) end

-- ===================== VARIABLES DEL MENÚ COMPLETO =====================
local fovVisiblePreference = false
local fovRadius = 120
local autoShootEnabled = false
local autoShootAgresivoEnabled = false
local autoShootTargetPart = "Cabeza"
local silentAimManualEnabled = false
local silentAimFovEnabled = false
local silentAimTargetPart = "Cabeza"
local espEnabled = false
local espColor = Color3.fromRGB(220, 228, 238)
local hitboxEnabled = false
local hitboxInvisible = false
local hitboxSize = 3.5
local hitboxColor = Color3.fromRGB(190, 95, 95)
local hitboxRainbow = false

local deviceAnalyzed = false
local deviceAllowed = false
local detectedDeviceInfo = nil
local graphicsUnlocked = false
local graphicsTypedKey = ""
local cartonModeActive = false
local realismCharActive = false
local superUltraActive = false
local dayNightMode = "Día"
local autoDayNightCycle = false
local PHASE_DURATION = 300
local isScanningDevice = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AlexHub_Overlays"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.Parent = player:WaitForChild("PlayerGui")

local espFolder = Instance.new("Folder")
espFolder.Name = "AlexESPFolder"
espFolder.Parent = screenGui

-- ===================== SECUENCIA DE VERIFICACION (PESTAÑA GRÁFICO) =====================
local function ejecutarSecuenciaVerificacion(onComplete)
	if isScanningDevice then return end
	isScanningDevice = true

	local blackScreen1 = Instance.new("Frame", screenGui)
	blackScreen1.Name = "BlackTerminalStage"
	blackScreen1.Size = UDim2.new(1, 0, 1, 0)
	blackScreen1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	blackScreen1.BackgroundTransparency = 0
	blackScreen1.BorderSizePixel = 0
	blackScreen1.ZIndex = 200

	local termBox = Instance.new("Frame", blackScreen1)
	termBox.Size = UDim2.new(0.88, 0, 0, 220)
	termBox.Position = UDim2.new(0.06, 0, 0.5, -110)
	termBox.BackgroundColor3 = Color3.fromRGB(6, 8, 10)
	termBox.BackgroundTransparency = 0.1
	termBox.BorderSizePixel = 0
	termBox.ZIndex = 201
	Instance.new("UICorner", termBox).CornerRadius = UDim.new(0, 10)
	local tStroke = Instance.new("UIStroke", termBox)
	tStroke.Color = Color3.fromRGB(36, 48, 42)
	tStroke.Thickness = 1

	local line1 = Instance.new("TextLabel", termBox)
	line1.Size = UDim2.new(1, -24, 0, 28)
	line1.Position = UDim2.new(0, 12, 0, 18)
	line1.BackgroundTransparency = 1
	line1.Text = "> pipipín, qué tal"
	line1.Font = Enum.Font.Code
	line1.TextSize = 16
	line1.TextColor3 = Color3.fromRGB(130, 215, 165)
	line1.TextXAlignment = Enum.TextXAlignment.Left
	line1.ZIndex = 202

	local line2 = Instance.new("TextLabel", termBox)
	line2.Size = UDim2.new(1, -24, 0, 24)
	line2.Position = UDim2.new(0, 12, 0, 56)
	line2.BackgroundTransparency = 1
	line2.Text = ""
	line2.Font = Enum.Font.Code
	line2.TextSize = 13
	line2.TextColor3 = Color3.fromRGB(165, 185, 175)
	line2.TextXAlignment = Enum.TextXAlignment.Left
	line2.ZIndex = 202

	local line3 = Instance.new("TextLabel", termBox)
	line3.Size = UDim2.new(1, -24, 0, 24)
	line3.Position = UDim2.new(0, 12, 0, 88)
	line3.BackgroundTransparency = 1
	line3.Text = ""
	line3.Font = Enum.Font.Code
	line3.TextSize = 13
	line3.TextColor3 = Color3.fromRGB(140, 175, 205)
	line3.TextXAlignment = Enum.TextXAlignment.Left
	line3.ZIndex = 202

	local line4 = Instance.new("TextLabel", termBox)
	line4.Size = UDim2.new(1, -24, 0, 24)
	line4.Position = UDim2.new(0, 12, 0, 120)
	line4.BackgroundTransparency = 1
	line4.Text = ""
	line4.Font = Enum.Font.Code
	line4.TextSize = 13
	line4.TextColor3 = Color3.fromRGB(190, 200, 210)
	line4.TextXAlignment = Enum.TextXAlignment.Left
	line4.ZIndex = 202

	task.spawn(function()
		local pulseChars = { "|", "/", "-", "\\" }
		for i = 1, 14 do
			line2.Text = "> inyectando sonda de lectura " .. pulseChars[(i % #pulseChars) + 1]
			task.wait(0.14)
		end
		line2.Text = "> sonda conectada · leyendo arquitectura..."
		task.wait(0.8)
		line3.Text = "> escaneando panel, resolución y bus gráfico..."
		task.wait(0.9)
		line4.Text = "> cerrando terminal y pasando a carga..."
		task.wait(0.8)

		if blackScreen1 and blackScreen1.Parent then
			blackScreen1:Destroy()
		end

		local blackScreen2 = Instance.new("Frame", screenGui)
		blackScreen2.Name = "FullScanProgressScreen"
		blackScreen2.Size = UDim2.new(1, 0, 1, 0)
		blackScreen2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		blackScreen2.BackgroundTransparency = 0
		blackScreen2.BorderSizePixel = 0
		blackScreen2.ZIndex = 210

		local centerPanel = Instance.new("Frame", blackScreen2)
		centerPanel.Size = UDim2.new(0.86, 0, 0, 240)
		centerPanel.Position = UDim2.new(0.07, 0, 0.5, -120)
		centerPanel.BackgroundColor3 = Color3.fromRGB(11, 13, 17)
		centerPanel.BorderSizePixel = 0
		centerPanel.ZIndex = 211
		Instance.new("UICorner", centerPanel).CornerRadius = UDim.new(0, 14)
		local cStroke = Instance.new("UIStroke", centerPanel)
		cStroke.Color = Color3.fromRGB(44, 54, 68)
		cStroke.Thickness = 1

		local scanHeader = Instance.new("TextLabel", centerPanel)
		scanHeader.Size = UDim2.new(1, -24, 0, 26)
		scanHeader.Position = UDim2.new(0, 12, 0, 16)
		scanHeader.BackgroundTransparency = 1
		scanHeader.Text = "VERIFICACIÓN DISPOSITIVO"
		scanHeader.Font = Enum.Font.GothamBold
		scanHeader.TextSize = 16
		scanHeader.TextColor3 = Color3.fromRGB(224, 232, 242)
		scanHeader.ZIndex = 212

		local scanStatus = Instance.new("TextLabel", centerPanel)
		scanStatus.Size = UDim2.new(1, -24, 0, 22)
		scanStatus.Position = UDim2.new(0, 12, 0, 52)
		scanStatus.BackgroundTransparency = 1
		scanStatus.Text = "Verificando hardware..."
		scanStatus.Font = Enum.Font.GothamMedium
		scanStatus.TextSize = 12
		scanStatus.TextColor3 = Color3.fromRGB(145, 175, 205)
		scanStatus.ZIndex = 212

		local pctLabel = Instance.new("TextLabel", centerPanel)
		pctLabel.Size = UDim2.new(1, -24, 0, 20)
		pctLabel.Position = UDim2.new(0, 12, 0, 80)
		pctLabel.BackgroundTransparency = 1
		pctLabel.Text = "0% · 10s"
		pctLabel.Font = Enum.Font.Code
		pctLabel.TextSize = 12
		pctLabel.TextColor3 = Color3.fromRGB(170, 182, 198)
		pctLabel.ZIndex = 212

		local barOuter = Instance.new("Frame", centerPanel)
		barOuter.Size = UDim2.new(1, -36, 0, 10)
		barOuter.Position = UDim2.new(0, 18, 0, 108)
		barOuter.BackgroundColor3 = Color3.fromRGB(24, 29, 38)
		barOuter.BorderSizePixel = 0
		barOuter.ZIndex = 212
		Instance.new("UICorner", barOuter).CornerRadius = UDim.new(1, 0)

		local barInner = Instance.new("Frame", barOuter)
		barInner.Size = UDim2.new(0, 0, 1, 0)
		barInner.BackgroundColor3 = Color3.fromRGB(127, 166, 201)
		barInner.BorderSizePixel = 0
		barInner.ZIndex = 213
		Instance.new("UICorner", barInner).CornerRadius = UDim.new(1, 0)

		local resultLbl = Instance.new("TextLabel", centerPanel)
		resultLbl.Size = UDim2.new(1, -24, 0, 48)
		resultLbl.Position = UDim2.new(0, 12, 0, 132)
		resultLbl.BackgroundTransparency = 1
		resultLbl.Text = ""
		resultLbl.Font = Enum.Font.GothamBold
		resultLbl.TextSize = 12
		resultLbl.TextColor3 = Color3.fromRGB(220, 228, 238)
		resultLbl.TextWrapped = true
		resultLbl.ZIndex = 212

		local continueBtn = Instance.new("TextButton", centerPanel)
		continueBtn.Size = UDim2.new(0, 120, 0, 32)
		continueBtn.Position = UDim2.new(0.5, -60, 1, -42)
		continueBtn.BackgroundColor3 = Color3.fromRGB(32, 42, 56)
		continueBtn.Text = "Cerrar"
		continueBtn.Font = Enum.Font.GothamBold
		continueBtn.TextSize = 12
		continueBtn.TextColor3 = Color3.fromRGB(228, 236, 246)
		continueBtn.Visible = false
		continueBtn.ZIndex = 213
		Instance.new("UICorner", continueBtn).CornerRadius = UDim.new(0, 8)

		local totalDuration = 10
		local elapsed = 0
		while elapsed < totalDuration do
			local dt = task.wait(0.1)
			elapsed = math.min(totalDuration, elapsed + dt)
			local frac = elapsed / totalDuration
			local pct = math.floor(frac * 100)
			local rem = math.max(0, math.ceil(totalDuration - elapsed))
			barInner.Size = UDim2.new(frac, 0, 1, 0)
			pctLabel.Text = tostring(pct) .. "% · " .. tostring(rem) .. "s"

			if frac < 0.35 then
				scanStatus.Text = "Leyendo modelo y plataforma..."
			elseif frac < 0.7 then
				scanStatus.Text = "Comprobando compatibilidad gráfica..."
			else
				scanStatus.Text = "Finalizando diagnóstico..."
			end
		end

		local devInfo = detectarDispositivo()
		detectedDeviceInfo = devInfo
		deviceAnalyzed = true
		deviceAllowed = devInfo.compatible

		if devInfo.compatible then
			scanStatus.Text = "Verificación completada"
			resultLbl.Text = "Tu dispositivo: " .. devInfo.nombre .. "\nACCESO PERMITIDO · Habilitando opciones"
			resultLbl.TextColor3 = Color3.fromRGB(142, 206, 176)
			barInner.BackgroundColor3 = Color3.fromRGB(142, 206, 176)
			task.wait(1.6)
			if blackScreen2 and blackScreen2.Parent then
				blackScreen2:Destroy()
			end
			isScanningDevice = false
			if onComplete then onComplete(true, devInfo) end
		else
			scanStatus.Text = "Verificación completada"
			resultLbl.Text = "Tu dispositivo: " .. devInfo.nombre .. "\nACCESO DENEGADO · " .. devInfo.detalle
			resultLbl.TextColor3 = Color3.fromRGB(214, 125, 125)
			barInner.BackgroundColor3 = Color3.fromRGB(214, 125, 125)
			continueBtn.Visible = true
			continueBtn.MouseButton1Click:Connect(function()
				if blackScreen2 and blackScreen2.Parent then
					blackScreen2:Destroy()
				end
				isScanningDevice = false
				if onComplete then onComplete(false, devInfo) end
			end)
		end
	end)
end

-- ===================== WINDUI (MENÚ COMPLETO) =====================
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
		Name = "AlexCalmFull",
		Accent = Color3.fromHex("#7DA2C4"),
		Dialog = Color3.fromHex("#12161E"),
		Outline = Color3.fromHex("#283040"),
		Text = Color3.fromHex("#E2E8F0"),
		Placeholder = Color3.fromHex("#7A8596"),
		Background = Color3.fromHex("#0D1016"),
		Button = Color3.fromHex("#171C26"),
		Icon = Color3.fromHex("#8EB1D0"),
	})
end)

local Window = WindUI:CreateWindow({
	Title = "Alex Hub · Full",
	Author = "Alex_12alex28 · alex@11",
	Folder = "AlexHub_Full",
	Theme = "AlexCalmFull",
	Acrylic = false,
	Transparent = false,
	NewElements = true,
	HideSearchBar = true,
	OpenButton = {
		Title = "Alex",
		Icon = "rbxassetid://7734053495",
		IconSize = 10,
		CornerRadius = UDim.new(0, 12),
		StrokeThickness = 1.5,
		Enabled = true,
		Draggable = true,
		Scale = 0.90,
		Color = ColorSequence.new(Color3.fromRGB(18, 22, 30), Color3.fromRGB(29, 37, 49))
	},
	Topbar = { Height = 40, ButtonsType = "Default" }
})

local MainSection = Window:Section({ Title = "Alex · alex@11", Icon = "solar:star-bold", Opened = true })

local Tabs = {
	Inicio = MainSection:Tab({ Title = "Inicio", Icon = "solar:info-circle-bold" }),
	Radar = MainSection:Tab({ Title = "Radar", Icon = "solar:smartphone-bold" }),
	Combate = MainSection:Tab({ Title = "Combate", Icon = "solar:target-bold" }),
	Visuales = MainSection:Tab({ Title = "Visuales", Icon = "solar:eye-bold" }),
	Eventos = MainSection:Tab({ Title = "Eventos", Icon = "solar:magic-stick-3-bold" }),
	Estilo = MainSection:Tab({ Title = "Estilo", Icon = "solar:settings-bold" }),
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

-- ===================== INICIO =====================
Tabs.Inicio:Section({ Title = "PANEL PRINCIPAL", Icon = "solar:home-bold" })

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
	ImageSize = 66
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
	Title = "Creador & Estado",
	Desc = "Creador: Alex_12alex28 · alex@11\nEjecutor: " .. execName .. "\nAuditoría 60s: Completada ✓"
})

-- ===================== RADAR =====================
local TopBar = Instance.new("Frame", screenGui)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 19, 26)
TopBar.Size = UDim2.new(0, 220, 0, 26)
TopBar.Position = UDim2.new(0.5, -110, 0.012, 0)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)
local tbStroke = Instance.new("UIStroke", TopBar)
tbStroke.Color = Color3.fromRGB(42, 50, 64)
tbStroke.Thickness = 1

local ServerLabel = Instance.new("TextLabel", TopBar)
ServerLabel.Size = UDim2.new(0.5, 0, 1, 0)
ServerLabel.BackgroundTransparency = 1
ServerLabel.Font = Enum.Font.GothamBold
ServerLabel.Text = "Servidor: 0"
ServerLabel.TextColor3 = Color3.fromRGB(196, 204, 218)
ServerLabel.TextSize = 12

local EnemyLabel = Instance.new("TextLabel", TopBar)
EnemyLabel.Position = UDim2.new(0.5, 0, 0, 0)
EnemyLabel.Size = UDim2.new(0.5, 0, 1, 0)
EnemyLabel.BackgroundTransparency = 1
EnemyLabel.Font = Enum.Font.GothamBold
EnemyLabel.Text = "Enemigos: 0"
EnemyLabel.TextColor3 = Color3.fromRGB(205, 130, 130)
EnemyLabel.TextSize = 12

Tabs.Radar:Section({ Title = "Contadores en Vivo", Icon = "solar:server-bold" })
Tabs.Radar:Paragraph({ Title = "Servidor / Enemigos", Desc = "Muestra jugadores en servidor y enemigos válidos en partida." })

local function UpdatePersona()
	ServerLabel.Text = "Servidor: " .. #Players:GetPlayers()
	EnemyLabel.Text = IsInMatchStrict() and ("Enemigos: " .. #GetValidEnemies()) or "Enemigos: 0"
end

-- ===================== COMBATE =====================
Tabs.Combate:Section({ Title = "Auto Shoot", Icon = "solar:target-bold" })
Tabs.Combate:Toggle({
	Title = "Auto Shoot (Normal)",
	Desc = "Solo si hay enemigo visible enfrente.",
	Callback = function(Value)
		autoShootEnabled = Value
		if not Value and not autoShootAgresivoEnabled and not silentAimManualEnabled then
			getgenv().AlexTargetPart = nil
		end
	end
})
Tabs.Combate:Toggle({
	Title = "Auto Shoot (Agresivo)",
	Callback = function(Value)
		autoShootAgresivoEnabled = Value
		if not Value and not autoShootEnabled and not silentAimManualEnabled then
			getgenv().AlexTargetPart = nil
		end
	end
})
Tabs.Combate:Dropdown({
	Title = "Target AutoShoot",
	Values = { "Cabeza", "Torso", "Cuerpo Completo" },
	Value = "Cabeza",
	Callback = function(Value) autoShootTargetPart = Value end
})

local equipGunEnabled = false
Tabs.Combate:Toggle({
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

Tabs.Combate:Space()
Tabs.Combate:Divider()
Tabs.Combate:Section({ Title = "Silent Aim + FOV", Icon = "solar:radar-bold" })
Tabs.Combate:Toggle({
	Title = "Silent Aim",
	Desc = "Prioriza enfrente + visible. No compañeros.",
	Callback = function(Value)
		silentAimManualEnabled = Value
		if not Value and not autoShootEnabled and not autoShootAgresivoEnabled then
			getgenv().AlexTargetPart = nil
		end
	end
})
Tabs.Combate:Dropdown({
	Title = "Target Silent",
	Values = { "Cabeza", "Torso", "Cuerpo Completo" },
	Value = "Cabeza",
	Callback = function(Value) silentAimTargetPart = Value end
})
Tabs.Combate:Toggle({ Title = "Silent Aim (FOV)", Callback = function(Value) silentAimFovEnabled = Value end })
Tabs.Combate:Toggle({ Title = "Mostrar FOV", Callback = function(Value) fovVisiblePreference = Value end })
Tabs.Combate:Slider({
	Title = "Tamaño FOV",
	Step = 1,
	Value = { Min = 10, Max = 800, Default = 120 },
	Callback = function(v) fovRadius = v end
})

Tabs.Combate:Space()
Tabs.Combate:Divider()
Tabs.Combate:Section({ Title = "Hitbox", Icon = "solar:box-bold" })
Tabs.Combate:Toggle({
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
Tabs.Combate:Toggle({ Title = "Hitbox Invisible", Value = false, Callback = function(v) hitboxInvisible = v end })
Tabs.Combate:Slider({
	Title = "Tamaño Hitbox",
	Step = 0.5,
	Value = { Min = 1, Max = 15, Default = 3.5 },
	Callback = function(v) hitboxSize = math.clamp(v, 1, 15) end
})
Tabs.Combate:Colorpicker({
	Title = "Color Hitbox",
	Default = Color3.fromRGB(190, 95, 95),
	Callback = function(c) hitboxRainbow = false hitboxColor = c end
})
Tabs.Combate:Button({ Title = "Rojo Suave", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(190, 95, 95) end })
Tabs.Combate:Button({ Title = "Salvia", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(115, 175, 145) end })
Tabs.Combate:Button({ Title = "Azul Pizarra", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(115, 155, 195) end })
Tabs.Combate:Button({ Title = "Marfil", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(225, 228, 234) end })
Tabs.Combate:Button({ Title = "Arcoíris", Callback = function() hitboxRainbow = true end })

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
		local trans = hitboxInvisible and 1 or 0.58
		local colorToUse = hitboxRainbow and Color3.fromHSV((tick() % 5) / 5, 0.55, 0.9) or hitboxColor
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
	FOVCircle.Color = Color3.fromRGB(210, 220, 232)
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

-- ===================== VISUALES =====================
Tabs.Visuales:Section({ Title = "ESP Glow", Icon = "solar:eye-bold" })
Tabs.Visuales:Toggle({ Title = "ESP Jugadores", Callback = function(s) espEnabled = s end })
Tabs.Visuales:Colorpicker({ Title = "Color ESP", Default = Color3.fromRGB(220, 228, 238), Callback = function(c) espColor = c end })

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
local CurrentESPColor = Color3.fromRGB(130, 185, 160)
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
POVStroke.Thickness = 1.5
POVStroke.Transparency = 0.3
POVStroke.Color = Color3.fromRGB(130, 185, 160)

local function GetESPColor()
	if RainbowESP then return Color3.fromHSV((tick() % 5) / 5, 0.55, 0.9) end
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
			line.Thickness = 2
			line.Transparency = 0.12
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

Tabs.Visuales:Space()
Tabs.Visuales:Divider()
Tabs.Visuales:Section({ Title = "ESP Extra", Icon = "solar:eye-bold" })
Tabs.Visuales:Toggle({ Title = "Nombres", Callback = function(v) ESP_Names = v RefreshExtraESP() end })
Tabs.Visuales:Toggle({ Title = "Líneas", Callback = function(v) ESP_Lines = v RefreshExtraESP() end })
Tabs.Visuales:Toggle({ Title = "Caja", Callback = function(v) ESP_Boxes = v RefreshExtraESP() end })
Tabs.Visuales:Toggle({
	Title = "POV",
	Callback = function(v)
		ESP_POV = v
		POVCircleUI.Visible = v and IsInMatchStrict()
		UpdatePOV()
	end
})
Tabs.Visuales:Slider({
	Title = "Tamaño POV",
	Step = 0.1,
	Value = { Min = 0.5, Max = 2.5, Default = 1 },
	Callback = function(v) POVSize = v UpdatePOV() end
})
Tabs.Visuales:Dropdown({
	Title = "Origen Línea",
	Values = { "Arriba", "Medio", "Abajo" },
	Value = "Abajo",
	Callback = function(v) LineOrigin = v end
})
Tabs.Visuales:Section({ Title = "Paleta Suave ESP" })
Tabs.Visuales:Button({ Title = "Salvia", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(130, 185, 160) UpdatePOV() RefreshExtraESP()
end })
Tabs.Visuales:Button({ Title = "Azul Pizarra", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(127, 166, 201) UpdatePOV() RefreshExtraESP()
end })
Tabs.Visuales:Button({ Title = "Coral Suave", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(205, 120, 120) UpdatePOV() RefreshExtraESP()
end })
Tabs.Visuales:Button({ Title = "Marfil", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(226, 232, 240) UpdatePOV() RefreshExtraESP()
end })
Tabs.Visuales:Button({ Title = "Arcoíris", Callback = function()
	RainbowESP = true UpdatePOV() RefreshExtraESP()
end })

-- ===================== EVENTOS =====================
Tabs.Eventos:Section({ Title = "Evento", Icon = "solar:gift-bold" })
getgenv().AutoEventFarm = false
local Networking = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Networking")
local RemoteFarm = Networking and Networking:FindFirstChild("RE/Events/CollectEventSpawnable")
Tabs.Eventos:Toggle({
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

-- ===================== ESTILO =====================
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

Tabs.Estilo:Section({ Title = "Paquetes", Icon = "solar:folder-with-files-bold" })
Tabs.Estilo:Dropdown({
	Title = "Elegir Paquete",
	Values = { "Ninguno", "Old School", "Zombie", "Ninja", "Levitation" },
	Value = "Ninguno",
	Callback = function(v) selectedPack = v end
})
Tabs.Estilo:Button({
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

	local dayClock = 14.2
	local clockVal = dayClock
	if factor > 0.5 then
		clockVal = (dayClock * (1 - factor) + 24.5 * factor) % 24
	else
		clockVal = dayClock + (24.5 - dayClock) * factor
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
			if superUltraBtn then pcall(function() superUltraBtn:SetTitle("Gráfico Super Ultra") end) end
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
			if superUltraBtn then pcall(function() superUltraBtn:SetTitle("Gráfico Super Ultra") end) end
			aplicarGraficoRealistaCharacter()
			realismBtn:SetTitle("Gráfico Realismo Character ✓")
		else
			resetGraficos()
			realismBtn:SetTitle("Gráfico Realismo Character")
		end
	end
})

local UltraSection = Tabs.Grafico:Section({ Title = "Gráfico Super Ultra", Icon = "solar:key-bold", Opened = false })
local DayNightSection = Tabs.Grafico:Section({ Title = "Ambiente Día / Noche", Icon = "solar:sun-bold", Opened = false })

local graphicsKeyInput
local validateKeyBtn
local dayNightDropdown
local toggleDayNightBtn
local autoCycleToggle

local function ocultarControlesUltra()
	for _, elem in ipairs({ graphicsKeyInput, validateKeyBtn, superUltraBtn, dayNightDropdown, toggleDayNightBtn, autoCycleToggle }) do
		if elem then
			pcall(function() elem:SetVisible(false) end)
		end
	end
	pcall(function() UltraSection:SetVisible(false) end)
	pcall(function() DayNightSection:SetVisible(false) end)
end

local function mostrarControlesUltra()
	pcall(function() UltraSection:SetVisible(true) end)
	pcall(function() UltraSection:Open() end)
	pcall(function() DayNightSection:SetVisible(true) end)
	pcall(function() DayNightSection:Open() end)
	for _, elem in ipairs({ graphicsKeyInput, validateKeyBtn, superUltraBtn, dayNightDropdown, toggleDayNightBtn, autoCycleToggle }) do
		if elem then
			pcall(function() elem:SetVisible(true) end)
		end
	end
end

Tabs.Grafico:Space()
Tabs.Grafico:Divider()

Tabs.Grafico:Button({
	Title = "Verificación Dispositivo",
	Callback = function()
		ejecutarSecuenciaVerificacion(function(okDev, devInfo)
			if okDev and devInfo then
				mostrarControlesUltra()
				WindUI:Notify({
					Title = "Verificación Válida",
					Content = "Dispositivo admitido · Opciones habilitadas",
					Duration = 3
				})
			else
				ocultarControlesUltra()
				WindUI:Notify({
					Title = "Verificación Denegada",
					Content = (devInfo and devInfo.detalle) or "Dispositivo no admitido",
					Duration = 4
				})
			end
		end)
	end
})

graphicsKeyInput = UltraSection:Input({
	Title = "Ingresar Key",
	Placeholder = "Escribe aquí...",
	Callback = function(text)
		graphicsTypedKey = tostring(text or "")
	end
})

validateKeyBtn = UltraSection:Button({
	Title = "Validar Key",
	Callback = function()
		if not deviceAnalyzed or not deviceAllowed then
			WindUI:Notify({
				Title = "Acceso Denegado",
				Content = "Completa la Verificación Dispositivo primero",
				Duration = 3
			})
			return
		end

		local raw = graphicsTypedKey
		if (raw == "" or raw == nil) and graphicsKeyInput and graphicsKeyInput.Get then
			pcall(function() raw = tostring(graphicsKeyInput:Get() or "") end)
		end
		local cleaned = normalizarKey(raw)
		if cleaned == "alexgrafico" then
			graphicsUnlocked = true
			WindUI:Notify({
				Title = "Key Válida",
				Content = "Gráfico Super Ultra desbloqueado",
				Duration = 3
			})
		else
			WindUI:Notify({
				Title = "Key Incorrecta",
				Content = "Usa: alexgrafico",
				Duration = 2
			})
		end
	end
})

superUltraBtn = UltraSection:Button({
	Title = "Gráfico Super Ultra",
	Callback = function()
		if not deviceAnalyzed or not deviceAllowed then
			WindUI:Notify({
				Title = "Acceso Denegado",
				Content = "Completa la Verificación Dispositivo primero",
				Duration = 3
			})
			return
		end
		if not graphicsUnlocked then
			WindUI:Notify({
				Title = "Key Requerida",
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
			WindUI:Notify({
				Title = "Gráfico Super Ultra",
				Content = "Activado (" .. dayNightMode .. ")",
				Duration = 3
			})
		else
			autoDayNightCycle = false
			resetGraficos()
			superUltraBtn:SetTitle("Gráfico Super Ultra")
		end
	end
})

dayNightDropdown = DayNightSection:Dropdown({
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

toggleDayNightBtn = DayNightSection:Button({
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

autoCycleToggle = DayNightSection:Toggle({
	Title = "Ciclo Día / Noche (5m c/u)",
	Value = false,
	Callback = function(v)
		autoDayNightCycle = v
	end
})

ocultarControlesUltra()

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
			local blendWindow = 15 / PHASE_DURATION
			local factor
			if not isNightPhase then
				if progress > (1 - blendWindow) then
					factor = (progress - (1 - blendWindow)) / blendWindow
				else
					factor = 0
				end
			else
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

print("Alex Hub Full listo | alex@11")
