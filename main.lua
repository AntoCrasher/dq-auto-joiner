-- settings
local masterUsername = ""

local dungeonName = ""
local difficulty = ""
local private = false

-- services and stuff 
local playerService = game:GetService("Players")
local lp = playerService.LocalPlayer

-- vars
local isMaster = lp.Name == masterUsername

-- Remote Events / Functions
local createLobbyRF = game.ReplicatedStorage.remotes.createLobby;
local joinLobbyRF = game.ReplicatedStorage.remotes.joinDungeon;

if (isMaster) then
    return createLobby()
end
-- code if not master

local hostInLobby = false

while not hostInLobby do
    for key, value in pairs(playerService:GetPlayers()) do
        if value.Name == masterUsername then
            hostInLobby = true
            break
        end
    end
    wait(5)
end

joinMasterLobby()

function createLobby()
    createLobbyRF:InvokeServer(dungeonName, difficulty, 0, true, private, false);
end

function joinMasterLobby()
    joinLobbyRF:InvokeServer(masterUsername)
end

