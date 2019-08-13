DefaultState = Class{__includes, BaseState}

function DefaultState:init()
end

function DefaultState:enter(params)
    self.player = {
        id = 0,
        --State variables 
        currentAnimation = "walk_down",
        direction = "down",
        isAttacking = false,
        --Health
        health = 10,
        --Position
        x = 100,
        y = 100,
        ------------------------------------------------------------
        -- CONSTANTS
        ------------------------------------------------------------
        -- Movement Speed
        moveSpeed = 60,
        -- Rendering
        texture = "player-character",
        renderOffset = {
            x = 8,
            y = 25,
        },
        ------------------------------------------------------------
        -- Animations
        animations = {
                walk_down = {
                    frames = {1, 2, 3, 4},
                    interval = 0.155,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                walk_up = {
                    frames = {35, 36, 37, 38},
                    interval = 0.155,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                walk_left = {
                    frames = {52, 53, 54, 55},
                    interval = 0.155,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                walk_right = {
                    frames = {18, 19, 20, 21},
                    interval = 0.155,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                idle_down = {
                    frames = {1},
                    interval = 0.155,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                idle_up = {
                    frames = {35},
                    interval = 0.155,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                idle_left = {
                    frames = {52},
                    interval = 0.155,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                idle_right = {
                    frames = {18},
                    interval = 0.155,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                attack_down = {
                    renderOffset = {
                        x = 16,
                    },
                    texture = "player-character-swing",
                    frames = {33, 34, 35, 36},
                    interval = 0.05,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                attack_up = {
                    renderOffset = {
                        x = 16,
                    },
                    texture = "player-character-swing",
                    frames = {41, 42, 43, 44},
                    interval = 0.05,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                attack_left = {
                    renderOffset = {
                        x = 17,
                    },
                    texture = "player-character-swing",
                    frames = {57, 58, 59, 60},
                    interval = 0.05,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
                attack_right = {
                    renderOffset = {
                        x = 15,
                    },
                    texture = "player-character-swing",
                    frames = {49, 50, 51, 52},
                    interval = 0.05,
                    timer = 0,
                    currentFrame = 1,
                    timesPlayed = 0,
                },
        },
        --Hitboxes
        collision = {
            offsetX = 8,
            offsetY = 18,
            width = 16,
            height = 18,
        },
        --Hurtboxes
        hurtbox = {
            up = {
                offsetX = 8,
                offsetY = 26,
                width = 16,
                height = 8,
            },
            down = {
                offsetX = 8,
                offsetY = 0,
                width = 16,
                height = 8,
            },
            left = {
                offsetX = 16,
                offsetY = 18,
                width = 8,
                height = 18,
            },
            right = {
                offsetX = -8,
                offsetY = 18,
                width = 8,
                height = 18,
            },
        }
    }

    self.enemy = {
        id = 1,
        currentAnimation = "walk_down",
        direction = "down",
        isAttacking = false,
        invulnerable = false,
        invulnerableDuration = 0.25,
        invulnerableTimer = 0,
        health = 2,
        x = 300,
        y = 200,
        moveSpeed = 60,
        texture = "entities",
        renderOffset = {
            x = 8,
            y = 16,
        },
        animations = {
            walk_down = {
                frames = {10, 11, 12, 11},
                interval = 0.2,
                timer = 0,
                currentFrame = 1,
                timesPlayed = 0,
            }
        },
        collision = {
            offsetX = 6,
            offsetY = 16,
            width = 12,
            height = 16,
        }
    }

    self.hitboxes = {}

    self.dungeon = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, },
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, },
    }
end

function DefaultState:update(dt)
    --NOTE:(Ryan) update the animainos before the keyboard because the keyboard update is dependant on animaitons
    --If you update in the other direction an attack animation will get played for 1 extra frame
    updateEntityAnimation(self.player, dt)
    updateEntityByKeyboard(self.player, dt)
    updateEntityAnimation(self.enemy, dt)

    if self.enemy.invulnerable then
        self.enemy.invulnerableTimer = self.enemy.invulnerableTimer + dt
        if self.enemy.invulnerableTimer > self.enemy.invulnerableDuration then
            self.enemy.invulnerableTimer = 0
            self.enemy.invulnerable = false
        end
    end

    --Check to see if the player hits a "wall"
    self.player.xTile = math.floor(self.player.x / 16)
    self.player.yTile = math.floor(self.player.y / 16)

    if self.dungeon[self.player.yTile + 1] and self.dungeon[self.player.yTile + 1][self.player.xTile + 1] == 1 then
        self.player.bumped = true
    end

    --TODO:(Ryan) be more thougtfull about hitboxes
    local playerCollision = collisionBox(self.player.x, self.player.y, self.player.collision.offsetX, self.player.collision.offsetY, self.player.collision.width, self.player.collision.height)
    local enemyCollision = collisionBox(self.enemy.x, self.enemy.y, self.enemy.collision.offsetX, self.enemy.collision.offsetY, self.enemy.collision.width, self.enemy.collision.height)
    if entitiesCollide(playerCollision, enemyCollision) then
        --NOTE:(Ryan) we only mark the player as bumped here because marking both causes weird unexpcted behavior
        --TODO:(Ryan) figure out a way to determine which entity caused the bump
        self.player.bumped = true;
        resolveCollision(self.player, self.enemy)
    end 

    if self.player.isAttacking then
        local swordCollision = collisionBox(self.player.x, self.player.y, self.player.hurtbox[self.player.direction].offsetX, self.player.hurtbox[self.player.direction].offsetY, self.player.hurtbox[self.player.direction].width, self.player.hurtbox[self.player.direction].height)
        if entitiesCollide(swordCollision, enemyCollision) and (not self.enemy.invulnerable) then
            self.enemy.health = self.enemy.health - 1
            self.enemy.invulnerable = true
        end
    end

    resolveBumpedEntity(self.player, dt)
    resolveBumpedEntity(self.enemy, dt)
end

function DefaultState:render()
    for ky, y in pairs(self.dungeon) do
        for kx, x in pairs (self.dungeon[ky]) do
            if self.dungeon[ky][kx] == 1 then
                love.graphics.setColor(1, 0, 0, .5)
            elseif self.dungeon[ky][kx] == 0 then
                love.graphics.setColor(1, 1, 1, .5)
            end
            love.graphics.rectangle("fill", (kx - 1) * 16, (ky - 1) * 16, 16, 16)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.rectangle("line", (kx - 1) * 16, (ky - 1) * 16, 16, 16)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end

    love.graphics.setColor(TILE_HIGHLIGHT_COLOR.r, TILE_HIGHLIGHT_COLOR.g, TILE_HIGHLIGHT_COLOR.b, TILE_HIGHLIGHT_COLOR.a)
    love.graphics.rectangle("line", self.player.xTile * 16, self.player.yTile * 16, 16, 16)
    --NOTE:(Ryan) we don't worry about reseting the color here because we assume a render is responsible for making sure its color is correct


    if self.enemy.health > 0 then
        renderEntityAnimationFrame(self.enemy)
        love.graphics.setColor(HITBOX_COLOR.r, HITBOX_COLOR.g, HITBOX_COLOR.b, HITBOX_COLOR.a)
        love.graphics.rectangle("line", self.enemy.x - self.enemy.collision.offsetX, self.enemy.y - self.enemy.collision.offsetY, self.enemy.collision.width, self.enemy.collision.height)
        love.graphics.rectangle("fill", self.enemy.x, self.enemy.y, 1, 1)
    end
    renderEntityAnimationFrame(self.player)
    love.graphics.setColor(HITBOX_COLOR.r, HITBOX_COLOR.g, HITBOX_COLOR.b, HITBOX_COLOR.a)
    love.graphics.rectangle("line", self.player.x - self.player.collision.offsetX, self.player.y - self.player.collision.offsetY, self.player.collision.width, self.player.collision.height)
    love.graphics.rectangle("fill", self.player.x, self.player.y, 1, 1)

    if self.player.isAttacking then
        love.graphics.setColor(HURTBOX_COLOR.r, HURTBOX_COLOR.g, HURTBOX_COLOR.b, HURTBOX_COLOR.a)
        love.graphics.rectangle("line", self.player.x - self.player.hurtbox[self.player.direction].offsetX,
                                        self.player.y - self.player.hurtbox[self.player.direction].offsetY,
                                        self.player.hurtbox[self.player.direction].width,
                                        self.player.hurtbox[self.player.direction].height)
    end
end

function collisionBox(x, y, xOff, yOff, width, height)
    return {
        x = x - xOff,
        y = y - yOff,
        width = width,
        height = height,
    }
end

function entitiesCollide(collisionBoxA, collisionBoxB) 
    if (not collisionBoxA) or (not collisionBoxB) then 
        return false
    end
    return not (
        collisionBoxA.x + collisionBoxA.width < collisionBoxB.x or
        collisionBoxA.x > collisionBoxB.x + collisionBoxB.width or
        collisionBoxA.y + collisionBoxA.height < collisionBoxB.y or
        collisionBoxA.y > collisionBoxB.y + collisionBoxB.height
    )
end

function resolveCollision(entityA, entityB) 
end

function resolveBumpedEntity(entity, dt) 
    if entity.bumped then
        if entity.direction == "left" then
            entity.x = entity.x + entity.moveSpeed * dt
        elseif entity.direction == "right" then
            entity.x = entity.x - entity.moveSpeed * dt
        elseif entity.direction == "up" then
            entity.y = entity.y + entity.moveSpeed * dt
        elseif entity.direction == "down" then
            entity.y = entity.y - entity.moveSpeed * dt
        end
    end
    entity.bumped = false
end

function DefaultState:exit()
end

function updateEntityByKeyboard(entity, dt)
    --TODO:(Ryan) Fix direction to use numbers rather than strings
    --TODO:(Ryan) Fix multiple input handling
    if love.keyboard.wasPressed(ATTACK) then
        entity.isAttacking = true
        entity.currentAnimation = "attack_" .. entity.direction
    end

    if entity.isAttacking then
        if entity.animations[entity.currentAnimation].timesPlayed > 0 then
            entity.animations[entity.currentAnimation].timesPlayed = 0
            entity.isAttacking = false
            entity.currentAnimation = "idle_" .. entity.direction
        end

        return --cannot accept other input while attacking
    end

    if love.keyboard.isDown(LEFT) then
        entity.x = entity.x - (entity.moveSpeed * dt)
        entity.direction = "left"
        entity.currentAnimation = "walk_left"
    elseif love.keyboard.isDown(RIGHT) then
        entity.x = entity.x + (entity.moveSpeed * dt)
        entity.direction = "right"
        entity.currentAnimation = "walk_right"
    elseif love.keyboard.isDown(UP) then
        entity.y = entity.y - (entity.moveSpeed * dt)
        entity.direction = "up"
        entity.currentAnimation = "walk_up"
    elseif love.keyboard.isDown(DOWN) then
        entity.y = entity.y + (entity.moveSpeed * dt)
        entity.direction = "down"
        entity.currentAnimation = "walk_down"
    else 
        entity.currentAnimation = "idle_" .. entity.direction
        --TODO:(Ryan) is there something we want to do here
    end
end

function updateEntityAnimation(entity, dt)
    local currentAnimation = entity.currentAnimation
    local timer = entity.animations[entity.currentAnimation].timer
    local interval = entity.animations[currentAnimation].interval

    --Increment the timer for the animation
    entity.animations[currentAnimation].timer = timer + dt
    --Check if the animation has gone over the interval
    if entity.animations[currentAnimation].timer > interval then
        --Update the timer such that extra time is added to the net frame 
        entity.animations[currentAnimation].timer  = entity.animations[currentAnimation].timer - interval

        --Update the frame counter
        entity.animations[currentAnimation].currentFrame = entity.animations[currentAnimation].currentFrame + 1
        --If we need to - loop the frame 
        if entity.animations[currentAnimation].currentFrame > #entity.animations[currentAnimation].frames then
            entity.animations[currentAnimation].currentFrame = 1
            entity.animations[currentAnimation].timesPlayed = 1 --TODO:(Ryan) Is it better to just set this to 1? will we ever care if there is more than one loop?
        end
    end
end

function renderEntityAnimationFrame(entity)
    local currentAnimation = entity.animations[entity.currentAnimation]
    local xOffset = (currentAnimation.renderOffset and currentAnimation.renderOffset.x) or entity.renderOffset.x
    local yOffset = (currentAnimation.renderOffset and currentAnimation.renderOffset.y) or entity.renderOffset.y
    local frameTexture = currentAnimation.texture  or entity.texture

    simpleDraw(entity.texture, currentAnimation.frames[currentAnimation.currentFrame], entity.x - xOffset, entity.y - yOffset, frameTexture)
end

--NOTE:(Ryan) frameTexture is optional 
function simpleDraw(texture, frame, x, y, frameTexture)
    love.graphics.setColor(1, 1, 1, 1) --We don't want to tint the texture in simple draw so set color
    --Render texture with no rotation scale of 1 no shear and no weight
    love.graphics.draw(gTextures[texture], gFrames[(frameTexture or texture)][frame], x, y, 0, 1, 1, 0, 0, 0, 0)
end