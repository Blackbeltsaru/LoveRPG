DefaultState = Class{__includes, BaseState}

function DefaultState:init()
end

function DefaultState:enter(params)

    self.player = 1
    self.enemy = 2
    self.entities = {}
    self.entities[self.player] = true
    self.entities[self.enemy] = true

    --
    --Positions
    --
    self.positionList = {}
    self.positionList[self.player] = position_struct(100, 100, 60, "down")
    self.positionList[self.enemy] = position_struct(300, 20, 60, "down")

    --
    --Health
    --
    self.healthList = {}
    self.healthList[self.player] = health_struct(10, 10)
    self.healthList[self.enemy] = health_struct(2, 2)

    --
    --Invulnerable
    --
    self.invulnerableList = {}
    self.invulnerableList[self.player] = invulnerable_struct(0.75)
    self.invulnerableList[self.enemy] = invulnerable_struct(0.25)

    --
    --Animations
    --
    self.animationList = {}
    self.animationList[self.player] = animation_table_struct("idle_down", offset_struct(8, 25), "player-character", {
        walk_down = animation_struct({1, 2, 3, 4}, 0.155),
        walk_up = animation_struct({35, 36, 37, 38}, 0.155),
        walk_left = animation_struct({52, 53, 54, 55}, 0.155),
        walk_right = animation_struct({18, 19, 20, 21}, 0.155),
        idle_down = animation_struct({1}, 0.155),
        idle_up = animation_struct({35}, 0.155),
        idle_left = animation_struct({52}, 0.155),
        idle_right = animation_struct({18}, 0.155),
        attack_down = animation_struct({33, 34, 35, 36}, 0.05, "player-character-swing", offset_struct(16)),
        attack_up = animation_struct({41, 42, 43, 44}, 0.05, "player-character-swing", offset_struct(16)),
        attack_left = animation_struct({57, 58, 59, 60}, 0.05, "player-character-swing", offset_struct(17)),
        attack_right = animation_struct({49, 50, 51, 52}, 0.05, "player-character-swing", offset_struct(17)),
    })
    self.animationList[self.enemy] = animation_table_struct("walk_down", offset_struct(8, 16), "entities", {
        walk_down = animation_struct({10, 11, 12, 11}, 0.2)
    })

    --
    --Hitboxes
    --
    self.hitboxList = {}
    self.hitboxList[self.player] = hitbox_struct(8, 18, 16, 18)
    self.hitboxList[self.enemy] = hitbox_struct(6, 16, 12, 16)

    --
    --Hurtboxes
    --
    self.hurtboxList = {}

    --
    --AI
    --
    self.aiList = {}
    self.aiList[self.enemy] = {
        goal = "moveDown", 
        action = function(position, animation, dt) return "" end,
    }

    --
    --Flags
    --
    self.flagList = {}
    self.flagList[self.player] = {}
    self.flagList[self.enemy] = {}

    self.dungeon = buildDungeon(24, 14)
end

function DefaultState:update(dt)
    --NOTE:(Ryan) update the animainos before the keyboard because the keyboard update is dependant on animaitons
    --If you update in the other direction an attack animation will get played for 1 extra frame
    for i=1, #self.animationList do
        updateAnimation(self.animationList[i].animations[self.animationList[i].current], dt)
    end

    for i=1, #self.invulnerableList do
        updateInvulnerable(self.invulnerableList[i], dt)
    end

    for i=2, #self.aiList do 
        --TODO:(Ryan) uncomment self.aiList[i].action(self.positionList[i], self.animationList[i], dt)
    end

    updateEntityByKeyboard(self.positionList[self.player], self.flagList[self.player], self.animationList[self.player], dt)

    --Check to see if the position hits a "wall"
    for i=1, #self.positionList do 
        local pos = self.positionList[i]
        local tileX = math.floor(pos.x / TILE_SIZE)
        local tileY = math.floor(pos.y / TILE_SIZE)
        pos.tileX = tileX
        pos.tileY = tileY

        --TODO:(Ryan) this should take into account the hitbox
        if self.dungeon[tileY + 1] and self.dungeon[tileY + 1][tileX + 1] == 1 then
            local bumpStruct = {
                x = tileX * TILE_SIZE,
                y = tileY * TILE_SIZE,
                width = TILE_SIZE,
                height = TILE_SIZE,
            }
            self.flagList[i].bumped = bumpStruct
        end
    end

    --TODO:(Ryan) we are technically checking all collisions twice - fix this
    for i=1, #self.hitboxList  do
        for j=i+1, #self.hitboxList do
            local hitI = self.hitboxList[i]
            local hitJ = self.hitboxList[j]
            local collideI = {
                x = self.positionList[i].x - hitI.offsetX,
                y = self.positionList[i].y - hitI.offsetY,
                width = hitI.width,
                height = hitI.height,
            }
            local collideJ = {
                x = self.positionList[j].x - hitJ.offsetX,
                y = self.positionList[j].y - hitJ.offsetY,
                width = hitJ.width,
                height = hitJ.height,
            }
            if entitiesCollide(collideI, collideJ) then
                --NOTE:(Ryan) we only mark the player as bumped here because marking both causes weird unexpcted behavior
                --TODO:(Ryan) figure out a way to determine which entity caused the bump
                self.flagList[i].bumped = collideJ--TODO:(Ryan) fix this
                resolveCollision(i, j)
            end
        end
    end

    for i=1, #self.hurtboxList do
        for j=1, #self.hitboxList do
            if not (i == j) then --A hurbox cannot hit the person who created it
                local collideI = {
                    x = self.positionList[i].x - self.hurtboxList[i].offsetX,
                    y = self.positionList[i].y - self.hurtboxList[i].offsetY,
                    width = self.hurtboxList[i].width,
                    height = self.hurtboxList[i].height,
                }
                local collideJ = {
                    x = self.positionList[j].x - hitJ.offsetX,
                    y = self.positionList[j].y - hitJ.offsetY,
                    width = hitJ.width,
                    height = hitJ.height,
                }
                if entitiesCollide(collideI, collideJ) and not (self.invulnerableList[j].active) then
                    self.healthList[j].current =self.healthList[j].current - 1
                    self.invulnerableList[j].active = true
                end
            end
        end
    end
    
    for i=1, #self.flagList do
        if self.flagList[i].bumped then
            resolveBumpedEntity(self.positionList[i], self.flagList[i].bumped, dt)
            self.flagList[i].bumped = false
        end
    end 
end

function DefaultState:render()

    --Draw a magenta background so that we are able to see if things aren't getting rendered properly
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.rectangle("fill", 0, 0, V_WIDTH, V_HEIGHT)

    drawDungeon(self.dungeon)

    love.graphics.setColor(TILE_HIGHLIGHT_COLOR.r, TILE_HIGHLIGHT_COLOR.g, TILE_HIGHLIGHT_COLOR.b, TILE_HIGHLIGHT_COLOR.a)
    for i=1, #self.positionList do
        love.graphics.rectangle("line", self.positionList[i].tileX * TILE_SIZE, self.positionList[i].tileY * TILE_SIZE, TILE_SIZE, TILE_SIZE)
    end

    love.graphics.setColor(1, 1, 1, 1)
    for i=1, #self.animationList do 
        renderAnimationFrame(self.animationList[i].texture, self.animationList[i].animations[self.animationList[i].current], self.positionList[i].x, self.positionList[i].y, self.animationList[i].renderOffset.x, self.animationList[i].renderOffset.y)
    end

    love.graphics.setColor(HITBOX_COLOR.r, HITBOX_COLOR.g, HITBOX_COLOR.b, HITBOX_COLOR.a)
    for i=1, #self.hitboxList do
        love.graphics.rectangle("line", self.positionList[i].x - self.hitboxList[i].offsetX, self.positionList[i].y - self.hitboxList[i].offsetY, self.hitboxList[i].width, self.hitboxList[i].height)
    end

    love.graphics.setColor(HURTBOX_COLOR.r, HURTBOX_COLOR.g, HURTBOX_COLOR.b, HURTBOX_COLOR.a)
    for i=1, #self.hurtboxList do
        love.graphics.rectangle("line", self.positionList[i].x - self.hurtboxList[i].offsetX, self.positionList[i].y - self.hurtboxList[i].offsetY, self.hurtboxList[i].height, self.hurtboxList[i].height)
    end

end

function DefaultState:processAI(blackboard)
    --Entity 1 is always the player so don't process ai for that entity
    for i=2, #self.aiList do
        self.aiList[i].action = function(position, animation, dt)
            local target = self.positionList[1]
            local xDif = target.x - position.x
            local yDif = target.y - position.y
            local mag = math.sqrt((xDif * xDif) + (yDif * yDif))
            position.y = position.y + position.moveSpeed * dt * (yDif / mag)
            position.x = position.x + position.moveSpeed * dt * (xDif / mag)
            return "hello"
        end
    end
end

function DefaultState:exit()
end

--TODO:(Ryan) change direction to use numbers/bits rather than strings
function updateEntityByKeyboard(position, flags, animationTable, dt)

    --If the attack button was pressed set attacking to true
    --set the current animation to attack in the facing direction
    --TODO:(Ryan) add my hurtbox(s) to the hurbox list
    if love.keyboard.wasPressed(ATTACK) then
        flags.isAttacking = true
        animationTable.current = "attack_" .. position.direction
    end

    if flags.isAttacking then
        local currentAnimation = animationTable.current
        --Once the animation has played once switch out of the attacking animation
        --TODO:(Ryan) remove my hurtbox(s) from the hurbox list
        if animationTable.animations[currentAnimation].timesPlayed > 0 then
            animationTable.animations[currentAnimation].timesPlayed = 0
            flags.isAttacking = false
            animationTable.current = "idle_" .. position.direction
        end
        return --cannot accept other input while attacking
    end

    local horizontalAxis = 0
    local verticalAxis = 0
    if love.keyboard.isDown(LEFT) then horizontalAxis = horizontalAxis - 1 end
    if love.keyboard.isDown(RIGHT) then horizontalAxis = horizontalAxis + 1 end
    if love.keyboard.isDown(UP) then verticalAxis = verticalAxis - 1 end
    if love.keyboard.isDown(DOWN) then verticalAxis = verticalAxis + 1 end

    local moveSpeedMulti = 1
    if not(horizontalAxis == 0 or verticalAxis == 0) then moveSpeedMulti = DIAGONAL_MOVE_MULTIPLIER end

    local newAnim = animationTable.current
    if not(verticalAxis == 0) then
        position.y = position.y + (position.moveSpeed * dt * moveSpeedMulti * verticalAxis)
        if verticalAxis > 0 then
            position.direction = "down"
            animationTable.current = "walk_down"
        else 
            position.direction = "up"
            animationTable.current = "walk_up"
        end
    end
    if not(horizontalAxis == 0) then
        position.x = position.x + (position.moveSpeed * dt * moveSpeedMulti * horizontalAxis)
        if horizontalAxis > 0 then
            position.direction = "right"
            animationTable.current = "walk_right"
        else 
            position.direction = "left"
            animationTable.current = "walk_left"
        end
    end

    if horizontalAxis == 0 and verticalAxis == 0 then
        animationTable.current = "idle_" .. position.direction
        --TODO:(Ryan) is there something we want to do here
    end

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

function resolveBumpedEntity(position, bumped, dt)
    --TODO:(Ryan) make this better
    local awayX = position.x - bumped.x
    local awayY = position.y - bumped.y
    position.x = position.x + awayX
    position.y = position.y + awayY
    -- if position.direction == "left" then
    --     position.x = position.x + position.moveSpeed * dt
    -- elseif position.direction == "right" then
    --     position.x = position.x - position.moveSpeed * dt
    -- elseif position.direction == "up" then
    --     position.y = position.y + position.moveSpeed * dt
    -- elseif position.direction == "down" then
    --     position.y = position.y - position.moveSpeed * dt
    -- end
end

function updateInvulnerable(invulnInfo, dt)
    if not invulnInfo.active then
        return
    end

    invulnInfo.timer = invulnInfo.timer + dt
    if invulnInfo.timer > invulnInfo.duration then
        invulnInfo.timer = 0
        invulnInfo.active = false
    end
end
