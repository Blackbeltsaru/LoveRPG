--#if DEBUG
DebugInfo = Class{__includes = BaseState}

function DebugInfo:init()
end

function DebugInfo:enter(params)
end

function DebugInfo:update(dt)

    return true
end

function DebugInfo:render()
    love.graphics.setColor(204, 204, 204)
    love.graphics.setFont(gFonts["small"])

    local states = love.graphics.getStats()
    love.graphics.printf("Draw Calls: " .. states.drawcalls, 0, 0, V_WIDTH, "right")
    love.graphics.printf("Canvas Switches: " .. states.canvasswitches, 0, 8, V_WIDTH, "right")
    love.graphics.printf("Texture Memory: " .. states.texturememory / 1024 / 1024 .. " MB", 0, 16, V_WIDTH, "right")
    love.graphics.printf("Images: " .. states.images, 0, 24, V_WIDTH, "right")
    love.graphics.printf("Canvases: " .. states.canvases, 0, 32, V_WIDTH, "right")
    love.graphics.printf("Fonts: " .. states.fonts, 0, 40, V_WIDTH, "right")

    love.graphics.printf("Version: " .. VERSION, 0, V_HEIGHT - 16, V_WIDTH, "right")
    love.graphics.printf("This is an early development build - assets are not final", 0, V_HEIGHT - 8, V_WIDTH, "right")
end

--#endif
