local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundController = {}

local SoundList =
	require(ReplicatedStorage:WaitForChild("SoundLibrary")).Audios
local Sounds = workspace:WaitForChild("Sounds")

local function setProp(instance: Instance, table: table)
	if instance and table then
		for propName, value in pairs(table) do
			instance[propName] = value
		end
	else
		error("There was no instance or table.")
	end
end

function SoundController:PlaySFX1(name: string) -- SFX1
	local SFX1 = Sounds:WaitForChild("SFXGroup"):WaitForChild("SFX1")
	local sound = SoundList[name]
	setProp(SFX1, sound)

	SFX1:Play()
end

function SoundController:PlayLocalSound(name: string, Instance: Instance) --Local Sound
	for _, sound in pairs(Instance:GetChildren()) do
		if sound:IsA("Sound") then
			return
		end
	end
	local localSound = Sounds:WaitForChild("SFXGroup"):WaitForChild("LocalSound"):Clone()
	local sound = SoundList[name]
	localSound.Parent = Instance

	setProp(localSound, sound)

	localSound:Play()

	localSound.Ended:Wait()
	localSound:Destroy()
end

function SoundController:PlayMainSound(name: string) -- MainMusic/Sound
	local MainSound = Sounds:WaitForChild("BackgroundGroup"):WaitForChild("MainSound")

	setProp(MainSound, SoundList[name])

	MainSound.TimePosition = 0
	MainSound:Play()
end

function SoundController:CustomSound(soundname: string, customname: string, soundgroup: string) --Create and play a custom (nonlocal) sound that isn't predetermined
	print("running")
	local mainsound = nil
	if SoundList[soundname] then
		print("Sound Found in Library.")
		if Sounds:FindFirstChild(soundgroup) then
			if Sounds:WaitForChild(soundgroup):FindFirstChild(customname) then
				mainsound = Sounds:WaitForChild(soundgroup):WaitForChild(customname)
			else
				mainsound = Instance.new("Sound")
				mainsound.Name = tostring(customname)
				mainsound.Parent = Sounds:WaitForChild(soundgroup)
				mainsound.SoundGroup = mainsound.Parent
			end
		else
			warn("SoundGroup not found.")
		end

		setProp(mainsound, SoundList[soundname])

		mainsound.TimePosition = 0
		mainsound:Play()
	end
end

function SoundController:CustomSoundGroup(properties: table) -- Create a custom sound group that isn't predetermined
	if properties then
		local newgroup = Instance.new("SoundGroup")
		newgroup.Parent = Sounds
		setProp(newgroup, properties)
	else
		warn("Properties were not provided.")
	end
end

function SoundController:RemoveCustom(name: string, parent: string) -- Remove a created (or predetermined) sound/group
	if parent == "Sounds" then
		Sounds:WaitForChild(name):Destroy()
	else
		Sounds:WaitForChild(parent):WaitForChild(name):Destroy()
	end
end

function SoundController:SetUp()
	local BackgroundGroup = Instance.new("SoundGroup")
	BackgroundGroup.Parent = Sounds
	BackgroundGroup.Name = "BackgroundGroup"
	BackgroundGroup.Volume = 0.4

	local SFXGroup = Instance.new("SoundGroup")
	SFXGroup.Parent = Sounds
	SFXGroup.Name = "SFXGroup"
	SFXGroup.Volume = 0.2

	local MainSound = Instance.new("Sound")
	MainSound.Parent = BackgroundGroup
	MainSound.SoundGroup = BackgroundGroup
	MainSound.Name = "MainSound"
	MainSound.Volume = 0.3

	local SFX1 = Instance.new("Sound")
	SFX1.Name = "SFX1"
	SFX1.SoundGroup = SFXGroup
	SFX1.Parent = SFXGroup

	local localSound = Instance.new("Sound")
	localSound.Name = "LocalSound"
	localSound.SoundGroup = SFXGroup
	localSound.Parent = SFXGroup
	localSound.RollOffMaxDistance = 30
end

return SoundController
