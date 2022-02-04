local ReplicatedStorage = game:GetService("ReplicatedStorage")

--> Knit
local Knit = require(ReplicatedStorage.Packages.Knit)

--> Modules
local Fusion = require(ReplicatedStorage.Packages.Fusion)

--> Services
local RadioService

local RadioController = Knit.CreateController {
	Name = "RadioController"
}

--> Fusion
local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local OnChange = Fusion.OnChange
local State = Fusion.State

function RadioController:Start()
	local SoundId = State(152745539)

	return New "ScreenGui" {
		Parent = game.Players.LocalPlayer.PlayerGui

		Name = "Radio",
		ResetOnSpawn = false,

		[Children] = {
			New "UIPadding" {
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8)
			},

			New "Frame" {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.fromScale(0, 0.5),
				Size = UDim2.fromOffset(100, 250),
				
				[Children] = {
					New "TextBox" {
						Name = "SoundId",
					
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim.fromScale(0.5, 0.5),
						Size = UDim2.fromScale(1, 0.1),
	
						PlaceholderText = "Enter SoundId here",
						[OnChange "Text"] = function(text)
							SoundId:set(text)
						end
					},

					New "TextButton" {
						Text = "PLAY",
						Position = UDim2.new(0, 0, 0.6, 0),
						AnchorPoint = Vector2.new(0, 0.5),
						Size = UDim2.fromScale(0.5, 0.1),
						
						[OnEvent "Activated"] = function()
							RadioService:Play("rbxassetid://" .. SoundId:get():match("%d+"))
						end
					},


					New "TextButton" {
						Text = "STOP",
						Position = UDim2.new(1, 0, 0.6, 0),
						AnchorPoint = Vector2.new(1, 0.5),
						Size = UDim2.fromScale(0.5, 0.1),
						
						[OnEvent "Activated"] = function()
							RadioService:Stop()
						end
					}
				}
			}
		}		
	}
end

function RadioController:KnitStart()
	RadioService = Knit.GetService("RadioService")
	RadioController:Start()
end

return RadioController