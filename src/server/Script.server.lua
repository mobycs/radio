local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddServicesDeep(ServerScriptService.Services)

Knit.Start()
	:catch(warn)
	:await()
