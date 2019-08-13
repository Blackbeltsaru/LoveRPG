Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.texture = def.texture
    self.looping = def.looping or true
    self.renderOffsetX = def.renderOffsetX
    self.renderOffsetY = def.renderOffsetY

    self.timer = 0
    self.currentFrame = 1

    self.timesPlayed = 0 --TODO:(Ryan) is this needed?
end

function Animation:refresh()
    self.timer = 0
    self.currentFrame = 1
    self.timesPlayed = 0
end

function Animation:update(dt)
    --TODO:(Ryan) is this the best way to handle preventing looping?
    if not self.looping and self.timesPlayed > 0 then
        return 
    end

    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            --TODO:(Ryan) go through and understand this math
            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))

            if self.currentFrame == 1 then
                self.timesPlayed = self.timesPlayed + 1
            end
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end