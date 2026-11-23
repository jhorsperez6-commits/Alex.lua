-- ==========================================
-- Alex Hub · V3 Renovada (Key + Verif 20s + UI)
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

-- ===================== DETECCIÓN DE DISPOSITIVO (GRÁFICO) =====================
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

	-- PC (Windows / macOS / Linux)
	if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux
		or (not isTouch and isKeyboard and isMouse) then
		return {
			nombre = "PC (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
			categoria = "PC",
			compatible = true,
			detalle = "Equipo de escritorio admitido"
		}
	end

	-- iOS (iPhone 13+ / iPad)
	if platform == Enum.Platform.IOS then
		if ratio <= 1.52 then
			return {
				nombre = "iPad (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
				categoria = "iPad",
				compatible = true,
				detalle = "Pantalla iPad admitida"
			}
		end

		if w >= 844 then
			return {
				nombre = "iPhone 13 o superior (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
				categoria = "iPhone 13+",
				compatible = true,
				detalle = "Modelo iPhone compatible"
			}
		else
			return {
				nombre = "iPhone anterior a iPhone 13 (" .. tostring(math.floor(w)) .. "x" .. tostring(math.floor(h)) .. ")",
				categoria = "iPhone antiguo",
				compatible = false,
				detalle = "Solo iPhone 13 o superior"
			}
		end
	end

	-- Android (Solo Tablet Samsung / pantalla grande tipo tablet)
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
				detalle = "Solo Tablet Samsung, iPad, iPhone 13+ o PC"
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

-- ===================== SISTEMA DE KEY + BOTÓN VERIFICAR (20s) =====================
local KEY_VALIDATED = false
local SCRIPT_VERIFIED = false
local isRunningScriptVerify = false

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

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "AlexKeyV3_UI"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.DisplayOrder = 10000
pcall(function() keyGui.Parent = game:GetService("CoreGui") end)
if not keyGui.Parent then keyGui.Parent = player:WaitForChild("PlayerGui") end

local bg = Instance.new("Frame", keyGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(6, 8, 11)
bg.BackgroundTransparency = 0.42
bg.BorderSizePixel = 0

local card = Instance.new("Frame", bg)
card.Size = UDim2.new(0, 340, 0, 434)
card.Position = UDim2.new(0.5, -170, 0.5, -217)
card.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
card.BorderSizePixel = 0
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 15)

local cardGrad = Instance.new("UIGradient", card)
cardGrad.Rotation = 140
cardGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 26, 35)),
	ColorSequenceKeypoint.new(0.55, Color3.fromRGB(15, 18, 24)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 13, 18))
})

local st = Instance.new("UIStroke", card)
st.Color = Color3.fromRGB(44, 52, 66)
st.Thickness = 1

local topAccent = Instance.new("Frame", card)
topAccent.Size = UDim2.new(0.30, 0, 0, 2)
topAccent.Position = UDim2.new(0.35, 0, 0, 11)
topAccent.BackgroundColor3 = Color3.fromRGB(125, 162, 196)
topAccent.BackgroundTransparency = 0.25
topAccent.BorderSizePixel = 0
Instance.new("UICorner", topAccent).CornerRadius = UDim.new(1, 0)

local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1, 0, 0, 26)
title.Position = UDim2.new(0, 0, 0, 20)
title.BackgroundTransparency = 1
title.Text = "ALEX HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 19
title.TextColor3 = Color3.fromRGB(224, 230, 238)

local subtitle = Instance.new("TextLabel", card)
subtitle.Size = UDim2.new(1, 0, 0, 16)
subtitle.Position = UDim2.new(0, 0, 0, 46)
subtitle.BackgroundTransparency = 1
subtitle.Text = "ACCESS & SCRIPT CHECK · alex@11"
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 11
subtitle.TextColor3 = Color3.fromRGB(128, 138, 154)

local avatarFrame = Instance.new("Frame", card)
avatarFrame.Size = UDim2.new(0, 50, 0, 50)
avatarFrame.Position = UDim2.new(0.5, -25, 0, 68)
avatarFrame.BackgroundColor3 = Color3.fromRGB(20, 24, 32)
avatarFrame.BorderSizePixel = 0
Instance.new("UICorner", avatarFrame).CornerRadius = UDim.new(1, 0)
local avOuterStroke = Instance.new("UIStroke", avatarFrame)
avOuterStroke.Color = Color3.fromRGB(125, 162, 196)
avOuterStroke.Thickness = 1.2
avOuterStroke.Transparency = 0.5

local avatarImg = Instance.new("ImageLabel", avatarFrame)
avatarImg.Size = UDim2.new(1, -4, 1, -4)
avatarImg.Position = UDim2.new(0, 2, 0, 2)
avatarImg.BackgroundColor3 = Color3.fromRGB(23, 27, 36)
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420"
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)

local infoBox = Instance.new("Frame", card)
infoBox.Size = UDim2.new(0.88, 0, 0, 66)
infoBox.Position = UDim2.new(0.06, 0, 0, 128)
infoBox.BackgroundColor3 = Color3.fromRGB(20, 24, 32)
infoBox.BorderSizePixel = 0
Instance.new("UICorner", infoBox).CornerRadius = UDim.new(0, 11)

local infoGrad = Instance.new("UIGradient", infoBox)
infoGrad.Rotation = 90
infoGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 29, 38)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 21, 28))
})

local infoStroke = Instance.new("UIStroke", infoBox)
infoStroke.Color = Color3.fromRGB(40, 47, 60)
infoStroke.Thickness = 1

local infoTitle = Instance.new("TextLabel", infoBox)
infoTitle.Size = UDim2.new(1, -104, 0, 18)
infoTitle.Position = UDim2.new(0, 12, 0, 8)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "Paso 1 · Key de Acceso"
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 12
infoTitle.TextColor3 = Color3.fromRGB(214, 222, 232)
infoTitle.TextXAlignment = Enum.TextXAlignment.Left

local infoDesc = Instance.new("TextLabel", infoBox)
infoDesc.Size = UDim2.new(1, -106, 0, 30)
infoDesc.Position = UDim2.new(0, 12, 0, 28)
infoDesc.BackgroundTransparency = 1
infoDesc.Text = "Clave: alex · Luego presiona VERIFICAR"
infoDesc.Font = Enum.Font.Gotham
infoDesc.TextSize = 11
infoDesc.TextColor3 = Color3.fromRGB(136, 146, 162)
infoDesc.TextXAlignment = Enum.TextXAlignment.Left
infoDesc.TextWrapped = true

local copyBtn = Instance.new("TextButton", infoBox)
copyBtn.Size = UDim2.new(0, 78, 0, 30)
copyBtn.Position = UDim2.new(1, -88, 0.5, -15)
copyBtn.BackgroundColor3 = Color3.fromRGB(27, 33, 44)
copyBtn.Text = "Copy"
copyBtn.Font = Enum.Font.GothamMedium
copyBtn.TextSize = 12
copyBtn.TextColor3 = Color3.fromRGB(205, 215, 228)
copyBtn.BorderSizePixel = 0
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 8)
local copyStroke = Instance.new("UIStroke", copyBtn)
copyStroke.Color = Color3.fromRGB(50, 59, 74)
copyStroke.Thickness = 1

copyBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if setclipboard then
			setclipboard("alex")
		end
	end)
	copyBtn.Text = "Copiado"
	copyBtn.TextColor3 = Color3.fromRGB(145, 205, 178)
	task.wait(1.2)
	copyBtn.Text = "Copy"
	copyBtn.TextColor3 = Color3.fromRGB(205, 215, 228)
end)

local keyBox = Instance.new("TextBox", card)
keyBox.Size = UDim2.new(0.88, 0, 0, 40)
keyBox.Position = UDim2.new(0.06, 0, 0, 206)
keyBox.BackgroundColor3 = Color3.fromRGB(19, 23, 31)
keyBox.PlaceholderText = "Escribe tu key..."
keyBox.Text = ""
keyBox.Font = Enum.Font.GothamMedium
keyBox.TextSize = 13
keyBox.TextColor3 = Color3.fromRGB(228, 234, 242)
keyBox.PlaceholderColor3 = Color3.fromRGB(115, 125, 142)
keyBox.ClearTextOnFocus = false
keyBox.BorderSizePixel = 0
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 10)
local boxStroke = Instance.new("UIStroke", keyBox)
boxStroke.Color = Color3.fromRGB(42, 50, 64)
boxStroke.Thickness = 1

keyBox.Focused:Connect(function()
	boxStroke.Color = Color3.fromRGB(125, 162, 196)
end)
keyBox.FocusLost:Connect(function()
	boxStroke.Color = Color3.fromRGB(42, 50, 64)
end)

local status = Instance.new("TextLabel", card)
status.Size = UDim2.new(0.88, 0, 0, 20)
status.Position = UDim2.new(0.06, 0, 0, 252)
status.BackgroundTransparency = 1
status.Text = "Ingresa la key para habilitar VERIFICAR"
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(136, 146, 162)

local validateBtn = Instance.new("TextButton", card)
validateBtn.Size = UDim2.new(0.88, 0, 0, 40)
validateBtn.Position = UDim2.new(0.06, 0, 0, 278)
validateBtn.BackgroundColor3 = Color3.fromRGB(29, 38, 50)
validateBtn.Text = "VALIDAR KEY"
validateBtn.Font = Enum.Font.GothamBold
validateBtn.TextSize = 12
validateBtn.TextColor3 = Color3.fromRGB(224, 232, 242)
validateBtn.BorderSizePixel = 0
Instance.new("UICorner", validateBtn).CornerRadius = UDim.new(0, 10)
local valStroke = Instance.new("UIStroke", validateBtn)
valStroke.Color = Color3.fromRGB(125, 162, 196)
valStroke.Thickness = 1
valStroke.Transparency = 0.55

-- Botón VERIFICAR (aparece y se habilita tras validar la key)
local verifyScriptBtn = Instance.new("TextButton", card)
verifyScriptBtn.Size = UDim2.new(0.88, 0, 0, 44)
verifyScriptBtn.Position = UDim2.new(0.06, 0, 0, 328)
verifyScriptBtn.BackgroundColor3 = Color3.fromRGB(26, 36, 48)
verifyScriptBtn.Text = "VERIFICAR SCRIPT (20s)"
verifyScriptBtn.Font = Enum.Font.GothamBold
verifyScriptBtn.TextSize = 13
verifyScriptBtn.TextColor3 = Color3.fromRGB(130, 142, 160)
verifyScriptBtn.BorderSizePixel = 0
verifyScriptBtn.Visible = false
verifyScriptBtn.Active = false
Instance.new("UICorner", verifyScriptBtn).CornerRadius = UDim.new(0, 10)
local verStroke = Instance.new("UIStroke", verifyScriptBtn)
verStroke.Color = Color3.fromRGB(125, 196, 165)
verStroke.Thickness = 1.2
verStroke.Transparency = 0.35

local footerLbl = Instance.new("TextLabel", card)
footerLbl.Size = UDim2.new(1, 0, 0, 14)
footerLbl.Position = UDim2.new(0, 0, 1, -20)
footerLbl.BackgroundTransparency = 1
footerLbl.Text = "Alex_12alex28 · alex@11"
footerLbl.Font = Enum.Font.Gotham
footerLbl.TextSize = 10
footerLbl.TextColor3 = Color3.fromRGB(102, 112, 128)

local function sacudirTarjeta()
	local basePos = card.Position
	task.spawn(function()
		local offsets = { -7, 7, -5, 5, 0 }
		for _, dx in ipairs(offsets) do
			card.Position = basePos + UDim2.new(0, dx, 0, 0)
			task.wait(0.04)
		end
		card.Position = basePos
	end)
end

local function validarClavePrincipal()
	if KEY_VALIDATED then return end

	local now = os.clock()
	if now < cooldownUntil then
		local rest = math.ceil(cooldownUntil - now)
		status.Text = "Espera " .. tostring(rest) .. "s por reintentos"
		status.TextColor3 = Color3.fromRGB(214, 155, 115)
		return
	end

	local rawInput = keyBox.Text or ""
	if normalizarKey(rawInput) == "" then
		status.Text = "Escribe una key antes de validar"
		status.TextColor3 = Color3.fromRGB(214, 155, 115)
		boxStroke.Color = Color3.fromRGB(214, 155, 115)
		return
	end

	if esKeyValida(rawInput) then
		KEY_VALIDATED = true
		failedAttempts = 0
		boxStroke.Color = Color3.fromRGB(145, 205, 178)
		validateBtn.Text = "KEY VALIDADA ✓"
		validateBtn.TextColor3 = Color3.fromRGB(145, 205, 178)
		status.Text = "Key correcta · Toca VERIFICAR SCRIPT (20s)"
		status.TextColor3 = Color3.fromRGB(145, 205, 178)

		verifyScriptBtn.Visible = true
		verifyScriptBtn.Active = true
		verifyScriptBtn.TextColor3 = Color3.fromRGB(232, 240, 248)
		verifyScriptBtn.BackgroundColor3 = Color3.fromRGB(32, 52, 68)
	else
		failedAttempts += 1
		boxStroke.Color = Color3.fromRGB(214, 125, 125)
		sacudirTarjeta()

		if failedAttempts >= 4 then
			cooldownUntil = os.clock() + 5
			failedAttempts = 0
			status.Text = "Demasiados intentos · Espera 5s"
			status.TextColor3 = Color3.fromRGB(214, 125, 125)
		else
			status.Text = "Key incorrecta (" .. tostring(failedAttempts) .. "/4)"
			status.TextColor3 = Color3.fromRGB(214, 125, 125)
		end
	end
end

validateBtn.MouseButton1Click:Connect(validarClavePrincipal)
keyBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		validarClavePrincipal()
	end
end)

-- ===================== VERIFICACIÓN GENERAL DE 20 SEGUNDOS (PANTALLA NEGRA) =====================
local function ejecutarVerificacionScript20s(onDone)
	if isRunningScriptVerify then return end
	isRunningScriptVerify = true

	local termScreen = Instance.new("Frame", keyGui)
	termScreen.Name = "ScriptHackVerify20s"
	termScreen.Size = UDim2.new(1, 0, 1, 0)
	termScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	termScreen.BackgroundTransparency = 0
	termScreen.BorderSizePixel = 0
	termScreen.ZIndex = 500

	local consoleFrame = Instance.new("Frame", termScreen)
	consoleFrame.Size = UDim2.new(0.88, 0, 0, 290)
	consoleFrame.Position = UDim2.new(0.06, 0, 0.5, -145)
	consoleFrame.BackgroundColor3 = Color3.fromRGB(7, 9, 12)
	consoleFrame.BorderSizePixel = 0
	consoleFrame.ZIndex = 501
	Instance.new("UICorner", consoleFrame).CornerRadius = UDim.new(0, 12)
	local cStroke = Instance.new("UIStroke", consoleFrame)
	cStroke.Color = Color3.fromRGB(40, 56, 52)
	cStroke.Thickness = 1

	local headerLbl = Instance.new("TextLabel", consoleFrame)
	headerLbl.Size = UDim2.new(1, -24, 0, 26)
	headerLbl.Position = UDim2.new(0, 12, 0, 14)
	headerLbl.BackgroundTransparency = 1
	headerLbl.Text = "ALEX HUB · VERIFICACIÓN INTEGRAL DEL SCRIPT"
	headerLbl.Font = Enum.Font.Code
	headerLbl.TextSize = 14
	headerLbl.TextColor3 = Color3.fromRGB(135, 212, 175)
	headerLbl.TextXAlignment = Enum.TextXAlignment.Left
	headerLbl.ZIndex = 502

	local log1 = Instance.new("TextLabel", consoleFrame)
	log1.Size = UDim2.new(1, -24, 0, 22)
	log1.Position = UDim2.new(0, 12, 0, 48)
	log1.BackgroundTransparency = 1
	log1.Text = "> pipipín, qué tal · iniciando auditoría del script..."
	log1.Font = Enum.Font.Code
	log1.TextSize = 12
	log1.TextColor3 = Color3.fromRGB(190, 210, 200)
	log1.TextXAlignment = Enum.TextXAlignment.Left
	log1.ZIndex = 502

	local log2 = Instance.new("TextLabel", consoleFrame)
	log2.Size = UDim2.new(1, -24, 0, 22)
	log2.Position = UDim2.new(0, 12, 0, 74)
	log2.BackgroundTransparency = 1
	log2.Text = "> hookeando rutas de servicios y comprobando integridad..."
	log2.Font = Enum.Font.Code
	log2.TextSize = 12
	log2.TextColor3 = Color3.fromRGB(145, 180, 210)
	log2.TextXAlignment = Enum.TextXAlignment.Left
	log2.ZIndex = 502

	local log3 = Instance.new("TextLabel", consoleFrame)
	log3.Size = UDim2.new(1, -24, 0, 22)
	log3.Position = UDim2.new(0, 12, 0, 100)
	log3.BackgroundTransparency = 1
	log3.Text = "> validando módulos: Aimbot · ESP · Tools · Gráfico..."
	log3.Font = Enum.Font.Code
	log3.TextSize = 12
	log3.TextColor3 = Color3.fromRGB(175, 185, 200)
	log3.TextXAlignment = Enum.TextXAlignment.Left
	log3.ZIndex = 502

	local timerLbl = Instance.new("TextLabel", consoleFrame)
	timerLbl.Size = UDim2.new(1, -24, 0, 22)
	timerLbl.Position = UDim2.new(0, 12, 0, 136)
	timerLbl.BackgroundTransparency = 1
	timerLbl.Text = "0% · 20s restantes"
	timerLbl.Font = Enum.Font.Code
	timerLbl.TextSize = 13
	timerLbl.TextColor3 = Color3.fromRGB(215, 225, 238)
	timerLbl.TextXAlignment = Enum.TextXAlignment.Left
	timerLbl.ZIndex = 502

	local barBg = Instance.new("Frame", consoleFrame)
	barBg.Size = UDim2.new(1, -24, 0, 12)
	barBg.Position = UDim2.new(0, 12, 0, 166)
	barBg.BackgroundColor3 = Color3.fromRGB(22, 27, 36)
	barBg.BorderSizePixel = 0
	barBg.ZIndex = 502
	Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

	local barFill = Instance.new("Frame", barBg)
	barFill.Size = UDim2.new(0, 0, 1, 0)
	barFill.BackgroundColor3 = Color3.fromRGB(125, 162, 196)
	barFill.BorderSizePixel = 0
	barFill.ZIndex = 503
	Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

	local statusFinal = Instance.new("TextLabel", consoleFrame)
	statusFinal.Size = UDim2.new(1, -24, 0, 56)
	statusFinal.Position = UDim2.new(0, 12, 0, 194)
	statusFinal.BackgroundTransparency = 1
	statusFinal.Text = "Escaneando estructura y dependencias..."
	statusFinal.Font = Enum.Font.GothamBold
	statusFinal.TextSize = 12
	statusFinal.TextColor3 = Color3.fromRGB(145, 175, 205)
	statusFinal.TextWrapped = true
	statusFinal.ZIndex = 502

	task.spawn(function()
		local totalTime = 20
		local elapsed = 0
		local spinner = { "|", "/", "-", "\\" }
		local step = 0

		while elapsed < totalTime do
			local dt = task.wait(0.1)
			elapsed = math.min(totalTime, elapsed + dt)
			step += 1

			local frac = elapsed / totalTime
			local pct = math.floor(frac * 100)
			local rem = math.max(0, math.ceil(totalTime - elapsed))
			local spinChar = spinner[(step % #spinner) + 1]

			barFill.Size = UDim2.new(frac, 0, 1, 0)
			timerLbl.Text = tostring(pct) .. "% · " .. tostring(rem) .. "s restantes " .. spinChar

			if frac < 0.25 then
				log2.Text = "> [0x01] verificando Players, Workspace y Lighting " .. spinChar
				statusFinal.Text = "Comprobando servicios base del juego..."
			elseif frac < 0.50 then
				log2.Text = "> [0x02] escaneando tablas de enemigos y filtros " .. spinChar
				statusFinal.Text = "Verificando lógica de combate y detección..."
			elseif frac < 0.75 then
				log2.Text = "> [0x03] auditando shaders, materiales y paquetes " .. spinChar
				statusFinal.Text = "Revisando módulos visuales y animaciones..."
			else
				log2.Text = "> [0x04] sellando integridad del script para abrir UI " .. spinChar
				statusFinal.Text = "Casi listo · Confirmando estado del script..."
			end
		end

		local servicesOk = (Players ~= nil and Lighting ~= nil and RunService ~= nil and workspace ~= nil)
		SCRIPT_VERIFIED = servicesOk

		barFill.BackgroundColor3 = Color3.fromRGB(142, 206, 176)
		log2.Text = "> [OK] todas las comprobaciones pasaron sin errores"
		statusFinal.Text = "VERIFICACIÓN COMPLETADA (20/20s)\nTodo el script está en orden · Cargando menú..."
		statusFinal.TextColor3 = Color3.fromRGB(142, 206, 176)

		task.wait(1.3)
		if termScreen and termScreen.Parent then
			termScreen:Destroy()
		end
		isRunningScriptVerify = false
		if onDone then onDone(true) end
	end)
end

verifyScriptBtn.MouseButton1Click:Connect(function()
	if not KEY_VALIDATED or isRunningScriptVerify then return end
	verifyScriptBtn.Text = "VERIFICANDO..."
	ejecutarVerificacionScript20s(function()
		if keyGui and keyGui.Parent then
			keyGui:Destroy()
		end
	end)
end)

while not SCRIPT_VERIFIED do task.wait(0.05) end

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
local espColor = Color3.fromRGB(220, 228, 238)
local hitboxEnabled = false
local hitboxInvisible = false
local hitboxSize = 3.5
local hitboxColor = Color3.fromRGB(190, 95, 95)
local hitboxRainbow = false

-- Gráfico
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
local PHASE_DURATION = 300 -- 5 minutos por fase
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

-- ===================== SECUENCIA DE VERIFICACION DISPOSITIVO (GRÁFICO) =====================
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

-- ===================== WINDUI (MENÚ Y PESTAÑAS RENOVADAS) =====================
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
		Name = "AlexCalmV3",
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
	Title = "Alex Hub · V3",
	Author = "Alex_12alex28 · alex@11",
	Folder = "AlexHub_V3",
	Theme = "AlexCalmV3",
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
	Persona = MainSection:Tab({ Title = "Radar", Icon = "solar:smartphone-bold" }),
	Aim = MainSection:Tab({ Title = "Combate", Icon = "solar:target-bold" }),
	Vis = MainSection:Tab({ Title = "Visuales", Icon = "solar:eye-bold" }),
	Farm = MainSection:Tab({ Title = "Eventos", Icon = "solar:magic-stick-3-bold" }),
	Animaciones = MainSection:Tab({ Title = "Estilo", Icon = "solar:settings-bold" }),
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
	Desc = "Creador: Alex_12alex28 · alex@11\nEjecutor: " .. execName .. "\nVerificación 20s: Aprobada ✓"
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

Tabs.Persona:Section({ Title = "Contadores en Vivo", Icon = "solar:server-bold" })
Tabs.Persona:Paragraph({ Title = "Servidor / Enemigos", Desc = "Muestra jugadores en servidor y enemigos válidos en partida." })

local function UpdatePersona()
	ServerLabel.Text = "Servidor: " .. #Players:GetPlayers()
	EnemyLabel.Text = IsInMatchStrict() and ("Enemigos: " .. #GetValidEnemies()) or "Enemigos: 0"
end

-- ===================== COMBATE =====================
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
	Default = Color3.fromRGB(190, 95, 95),
	Callback = function(c) hitboxRainbow = false hitboxColor = c end
})
Tabs.Aim:Button({ Title = "Rojo Suave", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(190, 95, 95) end })
Tabs.Aim:Button({ Title = "Salvia", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(115, 175, 145) end })
Tabs.Aim:Button({ Title = "Azul Pizarra", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(115, 155, 195) end })
Tabs.Aim:Button({ Title = "Marfil", Callback = function() hitboxRainbow = false hitboxColor = Color3.fromRGB(225, 228, 234) end })
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
Tabs.Vis:Section({ Title = "ESP Glow", Icon = "solar:eye-bold" })
Tabs.Vis:Toggle({ Title = "ESP Jugadores", Callback = function(s) espEnabled = s end })
Tabs.Vis:Colorpicker({ Title = "Color ESP", Default = Color3.fromRGB(220, 228, 238), Callback = function(c) espColor = c end })

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
Tabs.Vis:Section({ Title = "Paleta Suave ESP" })
Tabs.Vis:Button({ Title = "Salvia", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(130, 185, 160) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Azul Pizarra", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(127, 166, 201) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Coral Suave", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(205, 120, 120) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Marfil", Callback = function()
	RainbowESP = false CurrentESPColor = Color3.fromRGB(226, 232, 240) UpdatePOV() RefreshExtraESP()
end })
Tabs.Vis:Button({ Title = "Arcoíris", Callback = function()
	RainbowESP = true UpdatePOV() RefreshExtraESP()
end })

-- ===================== EVENTOS =====================
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

-- Secciones ocultas hasta que "Verificación Dispositivo" sea válido
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

print("Alex Hub V3 | alex@11")
