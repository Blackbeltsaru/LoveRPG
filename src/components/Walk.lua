Walk = Class{}

function Walk:init(defs)
    self.walkSpeed = defs.walkSpeed
    self.direction = "down"
    self.isMoving = false
end

function Walk:update(dt)
    self.bumped = self.bumped or false
    if not self.isMoving then
        return
    end

    if self.direction == "left" then
        self.x = self.x - self.walkSpeed * dt

        --TODO:(Ryan) check for collisions
    elseif self.direction == "right" then
        self.x = self.x + self.walkSpeed * dt

        --TODO:(Rya) check for collisions
    elseif self.direction == "up" then
        self.y = self.y - self.walkSpeed * dt
        
        --TODO:(Ryan) check for collisions
    elseif self.direction == "down" then
        self.y = self.y + self.walkSpeed * dt

        --TODO:(Ryan) check for collisions
    end
end

function Walk:render()
end