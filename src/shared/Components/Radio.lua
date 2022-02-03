local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Packages.Component)
local Spring = require(ReplicatedStorage.Packages.Spring)

local Radio = Component.new({
	Tag = "RadioComponent",
	Ancestors = {workspace}
})

function Radio:Construct()
	self.Spring = Spring.new(0)
	Spring.Damping = 0.6
	Spring.Speed = 32
end

function Radio:Start()
	self.Sound = self.Instance:FindFirstChildWhichIsA("Sound")
	self.Mesh = self.Instance:FindFirstChildWhichIsA("Mesh")
	self.Size = self.Mesh.Scale
end

function Radio:HeartbeatUpdate()
	self.Spring.Target = self.Sound.PlaybackLoudness / (800+(100/3))
	self.Mesh.Scale = self.Size * self.Spring.Postion
end

return Radio
