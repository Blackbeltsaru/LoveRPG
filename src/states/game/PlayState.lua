PlayState = Class{__includes = BaseState}

function PlayState:init()

end

function PlayState:enter(params)

    local playerDefs = ENTITY_DEFS["player"]
    playerDefs.x = 100
    playerDefs.y = 100
    self.player = Entity(ENTITY_DEFS["player"])
end

function PlayState:update(dt)
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end

    self.player:update(dt)

end

function PlayState:render()
    
    --TODO:(Ryan) Create quad draw util functions
    --TODO:(Ryan) Create printf write util functions

    self.player:render();


end