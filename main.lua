if not game:IsLoaded() then
    game.Loaded:Wait()
end
wait(2)
-- settings
local alts = {
    "Alt1",
    "Alt2",
    "Alt3",
    "Alt4",
    "Alt5"
}
local masterUsername = "MainAccount"
local dungeonName = "DungeonName"
local difficulty = "Insane/Nightmare"
local autoStart = true
-- services and stuff
local playerService = game:GetService("Players")
local lp = playerService.LocalPlayer
local UserInputService = game:GetService("UserInputService")
-- vars
local isMaster = lp.Name == masterUsername
-- Remote Events / Functions
local loadGame = game.ReplicatedStorage.remotes.loadPlayerCharacter;
local createLobbyRF = game.ReplicatedStorage.remotes.createLobby;
local joinDungeonRF = game.ReplicatedStorage.remotes.joinDungeon;
local startDungeonRF = game.ReplicatedStorage.remotes.startDungeon;
-- Functions
function createLobby()
    createLobbyRF:InvokeServer(dungeonName, difficulty, 0, true, false, false);
end
function joinMasterLobby()
    joinDungeonRF:InvokeServer(masterUsername)
end
function startDungeon()
    startDungeonRF:FireServer()
end
function isAllAcountsIn()
    for i, v in pairs(alts) do
        if(game.Players:FindFirstChild(v) == nil) then
            return false
        end
    end
    return true
end
local function Input(input, gameProcessedEvent)
    if (input.KeyCode == Enum.KeyCode.P) then
        startDungeon()
    end
end


-- Run Code

loadGame:FireServer(true)

wait(3)
if (isMaster) then
    createLobby()
    UserInputService.InputBegan:Connect(Input)
    if(autoStart) then
        while not isAllAcountsIn() do
            wait(0.5)
        end
        wait(1)
        startDungeon()
    end
else
    local hostInLobby = false

    while not hostInLobby do
        if game.Players:FindFirstChild(masterUsername) == nil then
            hostInLobby = false
        else
            hostInLobby = true
        end
        wait(1)
    end
    joinMasterLobby()
end
