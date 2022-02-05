local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Packages.Component)
local Spring = require(ReplicatedStorage.Packages.Spring)

local Radio = Component.new({
	Tag = "RadioComponent",
	Ancestors = {workspace}
})

function Radio:Construct()
	self.Spring = Spring.new(0)
	self.Spring.Damper = 1
	self.Spring.Speed = 32
end

function Radio:Start()
	self.Sound = self.Instance:FindFirstChildWhichIsA("Sound")
	self.Mesh = self.Instance:FindFirstChildWhichIsA("SpecialMesh")
	self.Size = self.Mesh.Scale
end

function Radio:HeartbeatUpdate()
	if not self.Sound then
		self.Sound = self.Instance:FindFirstChildWhichIsA("Sound")
	else
		self.Spring.Target = self.Sound.PlaybackLoudness / 5000
		self.Mesh.Scale = self.Size * (1+self.Spring.Position)
	end
end

return Radio
