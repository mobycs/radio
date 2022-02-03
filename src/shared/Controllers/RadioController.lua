local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local RadioController = Knoit.CreateController {
	Name = "RadioController"
}

function RadioController:KnitStart()
	local RadioService = Knit.GetService("RadioService")
	RadioService:Play("rbxassetid://6386768026")
end
