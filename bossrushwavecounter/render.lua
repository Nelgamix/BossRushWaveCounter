local variables = require("bossrushwavecounter.variables")
local utils = require("bossrushwavecounter.utils")

local render = {}

local waveBar = Sprite()
waveBar:Load("gfx/ui/waveBar.anm2", true)
waveBar:Play("Idle")

local font = Font()
font:Load("font/terminus.fnt")

local posx, posy = utils.getScreenSize()

function render:renderWaveCounter()
    if variables.editMode then
        font:DrawString("Edit Mode", posx * 0.5, posy * 0.5, KColor(1, 0, 0, 1), 12, true)
    end
    
    local waveBarV1
    local positionX = 0
    local positionYOffset = 0

    -- presets: 1 = Default, 2 = Found HUD, 3 = Boss Bar
    if variables.displayPreset == 1 then
        waveBarV1 = Vector(390 + variables.horizontalAdjustment, 29 - variables.verticalAdjustment)
        positionX = 390 + variables.horizontalAdjustment + ((variables.barScale / 100) * 6)
        positionYOffset = 29
    elseif variables.displayPreset == 2 then
        waveBarV1 = Vector(29 + variables.horizontalAdjustment, 237 - variables.verticalAdjustment)
        positionX = 29 + variables.horizontalAdjustment + ((variables.barScale / 100) * 6)
        positionYOffset = 237
    else
        if Isaac.CountBosses() >= 1 then
            waveBarV1 = Vector(136 + variables.horizontalAdjustment, 304 - variables.verticalAdjustment)
            positionX = 136 + variables.horizontalAdjustment + ((variables.barScale / 100) * 6)
            positionYOffset = 304
        else
            waveBarV1 = Vector(posx * 0.5, 304 - variables.verticalAdjustment)
            positionX = posx * 0.5 + ((variables.barScale / 100) * 6)
            positionYOffset = 304
        end
    end

    local text = variables.wave .. "/" .. variables.roomTypeMaxWaves
    local positionY = positionYOffset + variables.textNudge - variables.verticalAdjustment - ((variables.barScale / 100) * 22)
    local scaleX = 0.7 * (variables.textScale / 100)
    local scaleY = 0.7 * (variables.textScale / 100)
    local renderColor = KColor(variables.textR / 255, variables.textG / 255, variables.textB / 255, 1)
    local boxWidth = 7
    local center = true

    waveBar.Scale = Vector(variables.barScale / 100, variables.barScale / 100)
    waveBar:Render(waveBarV1, Vector(0, 0), Vector(0, 0))

    font:DrawStringScaled(text, positionX, positionY, scaleX, scaleY, renderColor, boxWidth, center)
end

return render
