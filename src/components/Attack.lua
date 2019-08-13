Attack = Class{}

function Attack:init(defs)
    self.isAttacking = false
    self.hurtboxDef = defs.hurtbox
end

function Attack:update(dt)
    if love.keyboard.wasPressed(ATTACK) then
        self.isAttacking = true
        self.isMoving = false
        self:changeAnimation("sword-" .. self.direction)

        self.isHurtboxActive = true
        self.hurtboxOffsetX = self.hurtboxDef[self.direction].hurtboxOffsetX
        self.hurtboxOffsetY = self.hurtboxDef[self.direction].hurtboxOffsetY
        self.hurtboxWidth = self.hurtboxDef[self.direction].hurtboxWidth
        self.hurtboxHeight = self.hurtboxDef[self.direction].hurtboxHeight
    end

    if self.isAttacking then
        if self.currentAnimation.timesPlayed > 0 then
            self.currentAnimation.timesPlayed = 0
            self.isAttacking = false
            self.isHurtboxActive = false
            self:changeAnimation("idle-" .. self.direction)
        end
    end
end

function Attack:render()
    if self.isAttacking then
        love.graphics.rectangle("line", self.x - self.hurtboxOffsetX, self.y - self.hurtboxOffsetY, self.hurtboxWidth, self.hurtboxHeight)
    end
end