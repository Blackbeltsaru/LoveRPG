Entity = Class{}
--Initialize the self with the defs
--NOTE(Ryan) this is what the defs may look like
-- {
--     x: 0, y: 0,
--     hitboxOffsetX: 10, hitboxOffsetY: 10, hitboxWidth: 16, hitboxHeight: 16,
--     components: {
--         1: "keyboardControllable"
--         2: "invlumnOnDamage"
--         3: "health"
--     },
--     sprite: {
--         texture: "character",
--         frame: "16,16"
--     }
--     animations: {
--         idle: {texture: "character", frame: "0, 0"},
--         walk: {texture: "character", frame: "0, 0"},
--         attack: {texture: "character", frame: "0, 0"}
--     }
--     renderOffsetX: "-10", renderOffsetY: "-10",
--      activeOnAlive: true,
--
-- }
function Entity:init(defs)
    --Position
    self.x = defs.x -- number
    self.y = defs.y -- number
    --Hitbox
    self.hitboxOffsetX = defs.hitboxOffsetX -- number
    self.hitboxOffsetY = defs.hitboxOffsetY -- number
    self.hitboxWidth = defs.hitboxWidth -- number
    self.hitboxHeight = defs.hitboxHeight -- number
    --Components
    self.components = defs.components --array of compoenets that have update and render functions 
    --init all of the components with self as the context
    if self.components then
        for i = 1, #self.components do 
            self.components[i].init(self, defs)
        end
    end
    --Rotation
    --TODO:(Ryan) Is rotation something we need to worry about?
    --Animation / Sprite
    self.sprite = defs.sprite --object that has a texture and a frame 
    self.animations = self:createAnimations(defs.animations) --array of animations "idle, walk, attack" - each animation has a texture, a frame and an update
    self.renderOffsetX = defs.renderOffsetX
    self.renderOffsetY = defs.renderOffsetY
    --active flag
    self.active = defs.activeOnAlive
    self.currentAnimation = self.animations["walk-down"]
end

function Entity:createAnimations(animations) 
    local animReturned = {}

    for k, animDef in pairs(animations) do
        animReturned[k] = Animation {
            texture = animDef.texture or 'entities', --TODO:(Ryan) change the default texture
            frames = animDef.frames,
            interval = animDef.interval,
            renderOffsetX = animDef.renderOffsetX,
            renderOffsetY = animDef.renderOffsetY
        }
    end

    return animReturned
end

function Entity:changeAnimation(name) 
    if self.animations then
        self.currentAnimation = self.animations[name]
    end
end

function Entity:update(dt)
    --If I'm not active then don't update me
    if not self.active then 
        return
    end
    --Update all of the components with self as the context for delta time
    if self.components then
        for i = 1, #self.components do 
            self.components[i].update(self, dt)
        end
    end
    --Update the animation if we have one
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end
function Entity:render()
    --If I'm not active then don't render me
    if not self.active then 
        return
    end
    --TODO:(Ryan) Do we want to render components first or sprite/animation first?
    if self.components then
        for i = 1, #self.components do
            self.components[i].render(self)
        end
    end

    local drawable
    if self.currentAnimation then
        drawable = self.currentAnimation
        drawable.frame = self.currentAnimation:getCurrentFrame()
    elseif self.sprite then
        drawable = self.sprite
    end

    local rX = self.renderOffsetX
    local rY = self.renderOffsetY
    if drawable.renderOffsetX then
        rX = drawable.renderOffsetX
    end
    if drawable.renderOffsetY then
        rY = drawable.renderOffsetY
    end
    
    if drawable then
        love.graphics.draw(gTextures[drawable.texture], gFrames[drawable.texture][drawable.frame], self.x - rX, self.y - rY, 0, 1, 1, 0, 0, 0, 0)
    end

    --DEBUG draw the hitbox
    love.graphics.rectangle('line', self.x - self.hitboxOffsetX, self.y - self.hitboxOffsetY, self.hitboxWidth, self.hitboxHeight)
end
-- AABB collision 
-- TODO:(Ryan) if we are doing anything with rotations then AABB won't work
function Entity:collides(other)
    if not self.active then
        return false
    end
    return not (
        self.x - self.hitboxOffsetX + self.hitboxWidth < other.x - other.hitboxOffsetX or
        self.x - self.hitboxOffsetX > other.x - other.hitboxOffsetX + hitboxWidth or 
        self.y - self.hitboxOffsetY + self.hitboxHeight < other.y - other.hitboxOffsetY or
        self.y - self.hitboxOffsetY > other.y - other.hitboxOffsetY + hitboxHeight
    )
end
