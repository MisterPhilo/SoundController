# SoundController
A easy to use controller I use for all my Sound needs. It automaticallies create three sound instances (localsound, SFX, MainMusic) and two soundgroups (BackgroundGroup, SFXGroup) with the option to add/remove sounds/groups. This module can be ran using the server or the client.


## THE SET UP:
1. Create a folder in workspace named "Sounds".
2. Move the SoundLibrary module to ReplicatedStorage.
3. Move the SoundController module to ReplicatedStorage.
4. In a server script require the SoundController module and run the function `:SetUp()` (do this once).

### HOW TO USE:
The SoundLibrary is where you put all your sounds. If the sound isn't in the SoundLibrary, it can not be used with this module. Below is an example of how to add a new sound.
```
return {
  ["Audios"] = {
    ["ExampleName"] = { SoundId = "rbxassetid://000000000", Volume = 1, Looped = true },
  }
}
```
You have a few options for playing sounds.
* `SoundController:PlaySFX1(name)` for playing a SFX sound like a button being clicked. Name will always be the name of the sound you give it in SoundLibrary.
* `SoundController:PlayLocalSound(name, instance)` for playing a sound that needs to be on an instance.
* `SoundController:PlayMainSound(name)` for playing a sound that's used for main music or something like that.
* `SoundController:CustomSound(name, SoundName, SoundGroup)` is for creating a new sound instance in a soundgroup. SoundName is the name of the new Sound Instance you will create if it doesn't exist in the SoundGroup you gave it. SoundGroup is just the name (string) of the Sound group in the Sounds folder.
* `SoundController:CustomSoundGroup(properties)` is for creating a new soundgroup if the pre-existing ones don't fit your needs. Properties need to be in a table: `{ Name = "ExampleName", Volume = 1 }`.
* `SoundController:RemoveCustom(name, parent)` is for removing a custom soundgroup or sound that you no longer have the need for. If it is a sound you are removing then it should be `SoundController:RemoveCustom("ExampleName", "NameOfSoundGroup")` and vice versa for a soundgroup `SoundController:RemoveCustom("ExampleName", "Sounds")` **(the parent must be Sounds if you are removing a soundgroup)**.
* `SoundController:SetUp()` must be ran one time on the server. Running it another time or on the client may cause issues.
