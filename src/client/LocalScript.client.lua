local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local Loader = require(ReplicatedStorage.Packages.Loader)

Knit.AddControllersDeep(ReplicatedStorage.Controllers)

Knit.Start()
	:catch(warn)
	:await()

Loader.LoadChildren(ReplicatedStorage.Components)
