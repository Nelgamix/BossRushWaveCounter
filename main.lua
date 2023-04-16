local bossRushWaveCounter = RegisterMod("Boss Rush Wave Counter", 1)

local variables = require("bossrushwavecounter.variables")
local render = require("bossrushwavecounter.render")
local save = require("bossrushwavecounter.save")

save.modRef = bossRushWaveCounter

if ModConfigMenu then
    require("bossrushwavecounter.mcm")
end

-- All code written by Aaron Cohen

local version = 1.13 -- change this number every time you update the mod so it will reset the saveX.dat files in case the way data handling is changed and not break the mod for previous users

local waveHasStarted = false -- to be able to know whether a wave is in progress
local currentNumberOfEntities = 0 -- the current number of bosses in the room

-- Constants
local MAX_WAVES_BOSS_RUSH = 15 -- max number of boss rush waves
local MAX_WAVES_CHALLENGE = 3 -- max number of challenge room waves
local MAX_WAVES_CHALLENGE_BOSS = 2 -- max number of boss challenge room waves

local function checkEditModeAdjustments()
    if Input.IsButtonPressed(Keyboard.KEY_SLASH, 0) then
        variables.editMode = true
    else
        variables.editMode = false
    end

    if variables.editMode == true then
        if Input.IsButtonPressed(Keyboard.KEY_RIGHT, 0) then
            variables.horizontalAdjustment = variables.horizontalAdjustment + 1
        elseif Input.IsButtonPressed(Keyboard.KEY_LEFT, 0) then
            variables.horizontalAdjustment = variables.horizontalAdjustment - 1
        elseif Input.IsButtonPressed(Keyboard.KEY_UP, 0) then
            variables.verticalAdjustment = variables.verticalAdjustment + 1
        elseif Input.IsButtonPressed(Keyboard.KEY_DOWN, 0) then
            variables.verticalAdjustment = variables.verticalAdjustment - 1
        end
    end

    if Input.IsButtonPressed(Keyboard.KEY_PERIOD, 0) then
        variables.horizontalAdjustment = 0
        variables.verticalAdjustment = 0
    end
end

local function isInCompatibleRoomType()
    return variables.roomType ~= nil
end

function bossRushWaveCounter:loadData()
    save.loadData()
end

function bossRushWaveCounter:saveData()
    save.saveData()
end

function bossRushWaveCounter:checkRoomType()
    local currentRoomType = Game():GetRoom():GetType()
    local currentRoomDesc = Game():GetLevel():GetCurrentRoomDesc()
    local currentRoomDescData = currentRoomDesc.Data

    Isaac.DebugString("Entered a room: " .. currentRoomType .. ", index " .. currentRoomDesc.ListIndex)

    if currentRoomType == RoomType.ROOM_BOSSRUSH then
        Isaac.DebugString("Entered a boss rush room")

        variables.roomType = RoomType.ROOM_BOSSRUSH
        variables.roomTypeMaxWaves = MAX_WAVES_BOSS_RUSH
    elseif currentRoomType == RoomType.ROOM_CHALLENGE then
        Isaac.DebugString("Entered a challenge room: " .. currentRoomDescData.Type .. ", " .. currentRoomDescData.Variant .. ", " .. currentRoomDescData.Subtype)
        
        variables.roomType = RoomType.ROOM_CHALLENGE

        -- detect challenge type
        if currentRoomDescData.Subtype == 0 then    
            variables.roomTypeMaxWaves = MAX_WAVES_CHALLENGE
        elseif currentRoomDescData.Subtype == 1 then
            variables.roomTypeMaxWaves = MAX_WAVES_CHALLENGE_BOSS
        end
    else
        if variables.wave < variables.roomTypeMaxWaves or waveHasStarted then
            bossRushWaveCounter:resetCounter()
        end

        variables.roomType = nil
        variables.roomTypeMaxWaves = 0
    end
end

function bossRushWaveCounter:resetCounter()
    Isaac.DebugString("Reset room wave counter")

    variables.wave = 0

    waveHasStarted = false
    currentNumberOfEntities = 0
end

function bossRushWaveCounter:update()
    if not isInCompatibleRoomType() then
        return
    end

    -- Check keyboard inputs for editing counter positions
    checkEditModeAdjustments()

    local aliveEntityCount = 0

    if variables.roomType == RoomType.ROOM_BOSSRUSH then
        aliveEntityCount = Game():GetRoom():GetAliveBossesCount()
    elseif variables.roomType == RoomType.ROOM_CHALLENGE then
        aliveEntityCount = Game():GetRoom():GetAliveEnemiesCount()
    end

    local waveInProgress = aliveEntityCount > 0

    if aliveEntityCount - currentNumberOfEntities ~= 0 then
        Isaac.DebugString("Number of alive entities: " .. aliveEntityCount)
    end

    if not waveHasStarted and waveInProgress then
        waveHasStarted = true
        variables.wave = variables.wave + 1
        Isaac.DebugString("Increased wave number: " .. variables.wave)
    end

    if waveHasStarted and not waveInProgress then
        Isaac.DebugString("Wave has finished: " .. variables.wave)
        waveHasStarted = false
    end

    currentNumberOfEntities = aliveEntityCount
end

function bossRushWaveCounter:renderWave()
    if not isInCompatibleRoomType() then
        return
    end

    render.renderWaveCounter()
end

bossRushWaveCounter:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, bossRushWaveCounter.loadData)
bossRushWaveCounter:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, bossRushWaveCounter.saveData)
bossRushWaveCounter:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, bossRushWaveCounter.resetCounter)
bossRushWaveCounter:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, bossRushWaveCounter.checkRoomType)
bossRushWaveCounter:AddCallback(ModCallbacks.MC_POST_UPDATE, bossRushWaveCounter.update)
bossRushWaveCounter:AddCallback(ModCallbacks.MC_POST_RENDER, bossRushWaveCounter.renderWave)
