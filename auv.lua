-- // load ui
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()


local Window = Fluent:CreateWindow({
  Title = "Anime Ultra Verse ",
  SubTitle = "Insatant wave",
  TabWidth = 160,
  Size = UDim2.fromOffset(580, 460),
  Acrylic = true,
  Theme = "Darker",
  MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
  Main = Window:AddTab({ Title = "Main", Icon = "" }),
  Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- // Service
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicaRemoteEvents = ReplicatedStorage:FindFirstChild("ReplicaRemoteEvents")
local Replica_ReplicaSignal = ReplicaRemoteEvents:FindFirstChild('Replica_ReplicaSignal')

local mainPlaceId = 17899227840

-- // elements UI
local stopAtWaveInput
local insatantWaveToggle
local autoDisbleInstantToggle
local autoReplayToggle

-- // Functions
local foundChannel = nil

-- Hook remote
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if self == Replica_ReplicaSignal and method == "FireServer" then
        if typeof(args[1]) == "number" and args[2] == "Speed" or args[2] == "Vote" or args[2] == "Restart" then
            foundChannel = args[1]
            print('Found')
        end
    end

    return oldNamecall(self, ...)
end

setreadonly(mt, true)


local function setInstantWave(enabled)
    if not foundChannel then
        repeat
          task.wait()
        until foundChannel
    end

    if enabled then
        Replica_ReplicaSignal:FireServer(foundChannel, "Speed", 0/0)
    else
        Replica_ReplicaSignal:FireServer(foundChannel, "Speed", 1)
    end
end


local function getWave()
    local text = PlayerGui.DefenseScreenFolder.WaveScreen.WaveTop.Waves.Text
    local number = text:match("^(%d+)")  -- ดึงเลขด้านหน้า
    return tonumber(number)
end

local function startAutoDisable()
    task.spawn(function()
        while autoDisbleInstantToggle.Value do
            task.wait()

            local currentWave = getWave()
            local stopWave = tonumber(stopAtWaveInput.Value)

            if currentWave == stopWave and insatantWaveToggle.Value then
                Options.insatantWaveToggle:SetValue(false)
            elseif PlayerGui.DefenseScreenFolder.WaveScreen.WaveVote.Visible and not insatantWaveToggle.Value then
              Options.insatantWaveToggle:SetValue(true)
            end
        end
    end)
end

local function autoReplay()
  task.spawn(function()
    while autoReplayToggle.Value do task.wait()
      if PlayerGui.DefenseScreenFolder.WaveEndScreen.WaveEnd.Visible then
          Replica_ReplicaSignal:FireServer(foundChannel,'Replay')
      end
    end
  end)
  
end

do
  stopAtWaveInput = Tabs.Main:AddInput("stopAtWaveInput", {
    Title = "Stop at wave",
    Default = 15,
    Placeholder = "",
    Numeric = true,   -- Only allows numbers
    Finished = false, -- Only calls callback when you press enter
    Callback = function() end
  })
  stopAtWaveInput:OnChanged(function() end)


  insatantWaveToggle = Tabs.Main:AddToggle("insatantWaveToggle", { Title = "Insatant wave", Default = false })

  insatantWaveToggle:OnChanged(function(value)
    setInstantWave(value)
  end)

  Options.insatantWaveToggle:SetValue(false)

  autoDisbleInstantToggle = Tabs.Main:AddToggle("autoDisbleInstantToggle",
    { Title = "Auto disble instant wave", Default = false })

  autoDisbleInstantToggle:OnChanged(function(value)
    if value then
    startAutoDisable()
    end
  end)

  autoReplayToggle = Tabs.Main:AddToggle("autoReplayToggle",
    { Title = "Auto Replay", Default = false })

  autoReplayToggle:OnChanged(function(value)
    if value then
    autoReplay()
    end
  end)



  Tabs.Main:AddButton({
    Title = "Restart Game",
    Callback = function()
      Window:Dialog({
        Title = "Restart confirm",
        Content = " Are you sure to restart match?",
        Buttons = {
          {
            Title = "Confirm",
            Callback = function()
              Replica_ReplicaSignal:FireServer(foundChannel,"Restart")
            end
          },
          {
            Title = "Cancel",
            Callback = function()
            end
          }
        }
      })
    end
  })
end


SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
  Title = "Fluent",
  Content = "The script has been loaded.",
  Duration = 8
})

SaveManager:LoadAutoloadConfig()
