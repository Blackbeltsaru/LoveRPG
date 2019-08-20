function position_struct(x, y, moveSpeed, direction) 
    return {
        x = x,
        y = y,
        moveSpeed = moveSpeed,
        direction = direction,
        tileX = math.floor(x / TILE_SIZE),
        tileY = math.floor(y / TILE_SIZE),
    }
end

function health_struct(current, max) 
    return {
        current = current,
        max = max,
    }
end

function invulnerable_struct(duration)
    return {
        active = false,
        duration = duration,
        timer = 0,
    }
end

function offset_struct(x, y) 
    return {
        x = x,
        y = y,
    }
end

function animation_table_struct(current, offset, texture, animations)
    return {
        current = current,
        renderOffset = offset,
        texture = texture,
        animations = animations,
    }
end

function animation_struct(frames, interval, texture, offset)
    return {
        frames = frames,
        interval = interval,
        timer = 0,
        currentFrame = 1, 
        timesPlayed = 0, 
        renderOffset = offset, 
        texture = texture,
    }
end

function hitbox_struct(x, y, width, height)
    return {
        offsetX = x,
        offsetY = y,
        width = width,
        height = height,
    }
end