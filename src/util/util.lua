
function GenerateQuads(atlas, tileWidth, tileHeight) 
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] = 
                love.graphics.newQuad(x * tileWidth, y * tileHeight, 
                    tileWidth, tileHeight, atlas:getDimensions())
                sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

--
--Animation utilities
--
 
function simpleDraw(texture, frame, x, y, frameTexture)
    love.graphics.setColor(1, 1, 1, 1) --We don't want to tint the texture in simple draw so set color
    --Render texture with no rotation scale of 1 no shear and no weight
    love.graphics.draw(gTextures[texture], gFrames[(frameTexture or texture)][frame], x, y, 0, 1, 1, 0, 0, 0, 0)
end

function renderAnimationFrame(texture, animation, x, y, Xoffset, Yoffset)
    local offsetX = (animation.renderOffset and animation.renderOffset.x) or Xoffset
    local offsetY = (animation.renderOffset and animation.renderOffset.y) or Yoffset
    local frameTexture = animation.texture or texture
    simpleDraw(texture, animation.frames[animation.currentFrame], x - offsetX, y - offsetY, frameTexture)
end

function updateAnimation(currentAnimation, dt) 
    local interval = currentAnimation.interval
    --Increment the timer for the current animation
    currentAnimation.timer = currentAnimation.timer + dt
    if currentAnimation.timer > interval then
        --Update the timer such that extra time is added to the next frame
        currentAnimation.timer = currentAnimation.timer - interval

        --Update the frame counter
        currentAnimation.currentFrame = currentAnimation.currentFrame + 1

        --Increment the loop frame
        if currentAnimation.currentFrame > #currentAnimation.frames then
            currentAnimation.currentFrame = 1
            currentAnimation.timesPlayed = 1 --TODO:(Ryan) Is it better to just set this to 1? will we ever care if there is more than one loop?
        end
    end
end
