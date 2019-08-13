
PlayerControlled = Class{}

function PlayerControlled:init(defs)
    self.direction = "down"
    self.isMoving = false
end

function PlayerControlled:update(dt)
    -- Cannot accept other input if I'm currently attacking
    if self.isAttacking then 
        return 
    end

    --Lets just assume I'm moving 
    self.isMoving = true
    if love.keyboard.isDown(LEFT) then
        self.direction = "left"
        self:changeAnimation("walk-left")
    elseif love.keyboard.isDown(RIGHT) then
        self.direction = "right"
        self:changeAnimation("walk-right")
    elseif love.keyboard.isDown(UP) then
        self.direction = "up"
        self:changeAnimation("walk-up")
    elseif love.keyboard.isDown(DOWN) then
        self.direction = "down"
        self:changeAnimation("walk-down")
    else
    --And fix it if I"m not actually moving
        self:changeAnimation("idle-" .. self.direction)
        self.isMoving = false
    end
end

function PlayerControlled:render()
end