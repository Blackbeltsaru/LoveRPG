StartState = Class{__includes = BaseState}

function StartState:init() 
    --Play the start menu music
    

end

function StartState:enter(params)
end

function StartState:exit()
end

function StartState:update(dt)
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateStack:pop()
        gStateStack:push(PlayState())
    end

    --TODO:(Ryan) transition to play state
end

function StartState:render()
    love.graphics.draw(gTextures["startMenu"]["background"], 0, 0, 0,
        V_WIDTH / gTextures["startMenu"]["background"]:getWidth(),
        V_HEIGHT / gTextures["startMenu"]["background"]:getHeight())

    love.graphics.setColor(34, 34, 34, 255)
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf(GAME_TITLE, 0, V_HEIGHT / 2 - 30, V_WIDTH, "center")
    love.graphics.setFont(gFonts["small"])
    love.graphics.printf("Press Enter", 0, V_HEIGHT / 2 -64, V_WIDTH, "center")
end