local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

task.wait(2)

-- ==================== KEY PRINCIPAL ====================
local MainWindow = Rayfield:CreateWindow({
   Name = "Alex Hub",
   LoadingTitle = "Alex Hub",
   LoadingSubtitle = "Key System",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true,
   KeySettings = {
      Title = "Alex Hub Key",
      Subtitle = "Acceso Principal",
      Note = "Ingrese Key",
      FileName = "AlexHubKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"hub"}
   }
})

local Tab = MainWindow:CreateTab("Selector", 4483362458)

Tab:CreateSection("Elige tu Menú")

Tab:CreateButton({
   Name = "🟢 Menú Normal",
   Callback = function() loadNormalMenu() end,
})

Tab:CreateButton({
   Name = "🔴 Menú VIP",
   Callback = function() loadVIPMenu() end,
})

-- ==================== NORMAL ====================
function loadNormalMenu()
   local Window = Rayfield:CreateWindow({
      Name = "Alex Normal",
      LoadingTitle = "Cargando...",
      LoadingSubtitle = "Versión Normal",
      ConfigurationSaving = { Enabled = false },
      KeySystem = true,
      KeySettings = {
         Title = "Key Normal",
         Subtitle = "Verificación",
         Note = "Ingrese Key",
         FileName = "AlexNormalKey",
         SaveKey = true,
         GrabKeyFromSite = false,
         Key = {"alexv1.0"}
      }
   })

   local TabFarm = Window:CreateTab("Auto Farm", 4483362458)
   createFarmTab(TabFarm, "Normal")
end

-- ==================== VIP ====================
function loadVIPMenu()
   local Window = Rayfield:CreateWindow({
      Name = "Alex VIP",
      LoadingTitle = "Cargando...",
      LoadingSubtitle = "Versión VIP",
      ConfigurationSaving = { Enabled = false },
      KeySystem = true,
      KeySettings = {
         Title = "Key VIP",
         Subtitle = "Verificación",
         Note = "Ingrese Key",
         FileName = "AlexVIPKey",
         SaveKey = true,
         GrabKeyFromSite = false,
         Key = {"vipalex1.0"}
      }
   })

   local TabFarm = Window:CreateTab("Auto Farm", 4483362458)
   createFarmTab(TabFarm, "VIP")
end

-- ==================== AUTO FARM (Bucle Infinito Mejorado) ====================
function createFarmTab(Tab, version)
   local target = Vector3.new(-1337.02, 241.72, 6437.63)
   local enabled = false
   local currentSpeed = 180
   local flyHeight = 90
   local waitAfterLand = 8

   local bodyVel = nil
   local noclipConn = nil
   local loopConn = nil

   local function stopMovement()
      enabled = false
      if bodyVel then bodyVel:Destroy() bodyVel = nil end
      if noclipConn then noclipConn:Disconnect() noclipConn = nil end
      if loopConn then loopConn:Disconnect() loopConn = nil end
   end

   local function goToPoint()
      if not enabled then return end
      
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local root = char:WaitForChild("HumanoidRootPart")

      -- Noclip
      noclipConn = game:GetService("RunService").Stepped:Connect(function()
         for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
               part.CanCollide = false
            end
         end
         if char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = true
         end
      end)

      bodyVel = Instance.new("BodyVelocity")
      bodyVel.MaxForce = Vector3.new(100000, 100000, 100000)
      bodyVel.P = 2000
      bodyVel.Parent = root

      loopConn = game:GetService("RunService").Heartbeat:Connect(function()
         if not enabled or not root.Parent then return end

         local currentPos = root.Position
         local highTarget = Vector3.new(target.X, target.Y + flyHeight, target.Z)
         local distToHigh = (highTarget - currentPos).Magnitude
         local distToTarget = (target - currentPos).Magnitude

         if distToHigh > 30 then
            bodyVel.Velocity = (highTarget - currentPos).Unit * currentSpeed
         elseif distToTarget > 15 then
            bodyVel.Velocity = (target - currentPos).Unit * (currentSpeed * 0.9)
         else
            -- Llegada
            if bodyVel then bodyVel:Destroy() bodyVel = nil end
            if noclipConn then noclipConn:Disconnect() noclipConn = nil end
            if loopConn then loopConn:Disconnect() loopConn = nil end

            root.Velocity = Vector3.new(0, -35, 0)
            task.wait(0.6)
            if char:FindFirstChild("Humanoid") then
               char.Humanoid.PlatformStand = false
            end

            task.wait(waitAfterLand)
            goToPoint() -- ← Bucle infinito
         end
      end)
   end

   -- Auto restart al morir
   game.Players.LocalPlayer.CharacterAdded:Connect(function()
      task.wait(2)
      if enabled then goToPoint() end
   end)

   Tab:CreateSection("Auto Farm - Alex " .. version)

   Tab:CreateToggle({
      Name = "Activar AutoFarm (Bucle Infinito)",
      CurrentValue = false,
      Callback = function(v)
         enabled = v
         if v then
            goToPoint()
         else
            stopMovement()
         end
      end,
   })

   Tab:CreateSlider({Name = "Velocidad", Range = {50, 500}, Increment = 10, CurrentValue = 180, Callback = function(v) currentSpeed = v end})
   Tab:CreateSlider({Name = "Altura de Vuelo", Range = {40, 200}, Increment = 5, CurrentValue = 90, Callback = function(v) flyHeight = v end})
   Tab:CreateSlider({Name = "Espera después de llegar (seg)", Range = {3, 25}, Increment = 1, CurrentValue = 8, Callback = function(v) waitAfterLand = v end})

   Tab:CreateButton({Name = "Ir al Punto (Una vez)", Callback = function() enabled = true; goToPoint() end})
   Tab:CreateButton({Name = "Detener Todo", Callback = stopMovement})
end

Rayfield:Notify({Title = "Alex Hub", Content = "Listo ✅\nKey principal: hub", Duration = 6})
