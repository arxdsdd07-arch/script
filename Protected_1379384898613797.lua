local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Replicated = ReplicatedStorage:FindFirstChild('Replicated')
local Packages = Replicated:FindFirstChild('Packages')
local Knit = Packages:FindFirstChild('Knit')
local Services = Knit:FindFirstChild('Services')
local ItochiEventService = Services:FindFirstChild('ItochiEventService')
local RFevent = ItochiEventService:FindFirstChild('RF')
local ExchangeRedClouds = RFevent:FindFirstChild('ExchangeRedClouds')
local RaidService = Services:FindFirstChild('RaidService')
local RFraid = RaidService:FindFirstChild('RF')
local ExchangeRaidCoins = RFraid:FindFirstChild('ExchangeRaidCoins')
local UnitService = Services:FindFirstChild('UnitService')
local UnitServiceRF = UnitService:FindFirstChild('RF')
local FeedUnit = UnitServiceRF:FindFirstChild('FeedUnit')
local unit = PlayerGui.Inventory.Main.Units.UnitsScroll


ExchangeRaidCoins:InvokeServer("MagicTokens", -math.huge)
ExchangeRaidCoins:InvokeServer("PerfectStatCubes", -math.huge)
ExchangeRaidCoins:InvokeServer("StatCubes",-math.huge)

ExchangeRedClouds:InvokeServer("MagicTokens", -math.huge)
ExchangeRedClouds:InvokeServer("PerfectStatCubes", -math.huge)
ExchangeRedClouds:InvokeServer("StatCubes", -math.huge)
