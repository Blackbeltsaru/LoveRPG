love.graphics.setDefaultFilter('nearest', 'nearest', 100)
require 'src/Dependencies'

function love.load()
    --TODO:(Ryan) for debug purposes we may want to write the seed to a file`
    math.randomseed(os.time()) --TODO: is os time really the best seed
    love.window.setTitle(GAME_TITLE)

    push:setupScreen(V_WIDTH, V_HEIGHT, W_WIDTH, W_HEIGHT, {
        fullscreen = false,
        resizeable = false, --TODO:(Ryan) we may want to change resiable in the future
        canvas = false, --TODO:(Ryan) read more about this parameeter - what does it do and why might we want to use it
        pixelperfect = false, --TODO:(Ryan) read more about this parameter 
        highdpi = true, 
        stretched = false, 
    })

    love.graphics.setFont(gFonts['small'])

    --TODO:(Ryan) is the state stack needed? We can probably simplify this out
    gStateStack = StateStack {}
    gStateStack:push(DefaultState())
    --#if DEBUG
    gStateStack:pushDebug(DebugInfo)
    --#endif

    love.keyboard.keyPressed = {}
end

function love.resize(w, h) 
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keyPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keyPressed[key]
end

function love.update(dt)
    Timer.update(dt) --TODO:(Ryan) what is this?
    gStateStack:processAI()
    gStateStack:update(dt)

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end

    -- Clear out the keys pressed every frame
    --TODO:(Ryan) for debug purposes we might want to write the keypressed to a file
    --that way we can replay any game 
    love.keyboard.keyPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end