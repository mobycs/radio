local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectiveService = game:GetService("CollectionService")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Knit = ReplicatedStorage.Packages.Knit)

local RadioService = Knir.CreateService {
	Name = "RadioService",
	Client = {}
}

function RadioService.Client:Play(player: Player, soundId: string)
	if typeof(soundId) ~= "string" then
		return
	end

	local character: Model = player.Character or player.CharacterAdded:Wait()

	if not character.Parent then
		character.AncestryChanged:Wait()
	end

	local sound: Sound = self.Server:GetSound(character, soundId)	
	if sound then
		sound:Play()
	else
		return "No sound was found sadly", false
	end
end

function RadioService:GetSound(character: Model, soundId: string)
	local radio = character:WaitForChild("Radio", 10)

	if radio then
		local sound = radio:FindFirstChildWhichIsA("Sound")

		if sound then
			sound.SoundId = soundId
			return sound
		else
			return RadioService:MakeSound(radio, soundId)
		end
	else
		return
	end
end

function RadioService:MakeSound(radio: BasePart, sound: Sound)
	local sound = Instance.new("Sound")
	sound.Name = "RadioService"
	sound.SoundId = soundId
	sound.Volume = 1
	sound.Parent = radio

	return sound
end

local function weld(part0: BasePart, part1: BasePart)
	local weld = Instance.new("WeldConstraint")
	weld.Name = part0.Name .. " -> " .. part1.Name
	weld.Part0 = part0
	weld.Part1 = part1
	weld.Parent = part0

	return weld
end

local RADIO_MODEL = ServerStorage:WaitForChild("Radio")

function RadioService:GiveRadio(character: Model)
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	local torso = character:FindFirstChild("Torso") or character:FindFirstChildWhichIsA("UpperTorso")

	local radio = RADIO_MODEL:Clone()
	CollectionService:AddTag(radio, "RadioComponent")
	radio.CFrame = humanoid.RootPart.CFrame * CFrame.Angles(0, math.pi, math.pi/4) - torso.CFrame.LookVector
	weld(torso, radio)
	radio.Parent = character

	return radio
end

function RadioService:KnitInit()
	local function playerAdded(player: Player)
		local function characterAdded(character: Model)
			if not character.Parent then
				character.AncestryChanged:Wait()
			end

			self:GiveRadio(character)
		end

		local character = player.Character
		
		if character then
			task.spawn(characterAdded, character)
		end

		player.CharacterAdded:Connect(characterAdded)
	end

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(playerAdded, player)
	end

	Players.PlayerAdded:Connect(playerAdded)
end

return RadioService
