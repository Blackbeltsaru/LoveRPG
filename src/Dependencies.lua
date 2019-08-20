---
--- Libraries
---

Class = require("lib/class")
push = require("lib/push")
Timer = require("lib/knife.timer") --TODO:(Ryan) is this necessary?

require "defs/constants"

require "src/util/StateStack"
require "src/util/BaseState"
require "src/util/Animation"
require "src/util/util"
require "src/util/structs"

require "src/states/game/StartState"
require "src/states/game/PlayState"
require "src/states/game/DefaultState"
require "src/states/debug/DebugInfo"

require "src/entities/Entity"

require "src/components/Walk"
require "src/components/Attack"
require "src/components/PlayerControlled"
require "src/dungeon/dungeon"


require "defs/entityDefs"
---
--- Textures / Animations / Fonts
---

gFonts = {
    ["small"] = love.graphics.newFont("assets/fonts/font.ttf", 8),
    ["medium"] = love.graphics.newFont("assets/fonts/font.ttf", 16),
    ["large"] = love.graphics.newFont("assets/fonts/font.ttf", 32),
}

gTextures = {
    ["startMenu"] = {
        --TODO:(Ryan) Figure out why this is using nearly 3meg of texture memory
        ["background"] = love.graphics.newImage("assets/images/background.jpg")
    },
    ["player-character"] = love.graphics.newImage("assets/spritesheets/player-character.png"),
    ["entities"] = love.graphics.newImage("assets/spritesheets/entities.png"),
    ["dungeon-tiles"] = love.graphics.newImage("assets/spritesheets/dungeon-tiles.png"),
}

gFrames = {
    ["player-character"] = GenerateQuads(gTextures["player-character"], 16, 32),
    ["player-character-swing"] = GenerateQuads(gTextures["player-character"], 32, 32), --NOTE:(Ryan) this looks at the same texture but because of the padding on attack animations we need to create different quads
    ["entities"] = GenerateQuads(gTextures["entities"], 16, 16),
    ["dungeon-tiles"] = GenerateQuads(gTextures["dungeon-tiles"], 16, 16),
}