
function drawDungeon(dungeon) 
    --Draw the floors
    for y=1, #dungeon do
        for x=1, #dungeon[y] do
            if not (dungeon[y][x] == 1) then
                simpleDraw("dungeon-tiles", dungeon[y][x], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE, "dungeon-tiles")
            else 
                simpleDraw("dungeon-tiles", 130, (x-1) * TILE_SIZE, (y-1) * TILE_SIZE, "dungeon-tiles")
            end
        end
    end
    --Draw the walls
    for y=1, #dungeon do
        for x=1, #dungeon[y] do
            if dungeon[y][x] == 1 then
                --If I have left or right neighbors 
                local right = bit.lshift(1, 0)--0x0001 Right neighbor
                local left = bit.lshift(1, 1)--0x0010 Left neighbor
                local top = bit.lshift(1, 2)--0x0100 Top Neighbor
                local bottom = bit.lshift(1, 3)--0x1000 bottom neighbor
                local directionMask = 0
                if dungeon[y][x-1] == 1 then
                    directionMask = bit.bor(directionMask, left)
                end
                if dungeon[y][x+1] == 1 then
                    directionMask = bit.bor(directionMask, right)
                end
                if dungeon[y-1] and dungeon[y-1][x] == 1 then
                    directionMask = bit.bor(directionMask, top)
                end
                if dungeon[y+1] and dungeon[y+1][x] == 1 then
                    directionMask = bit.bor(directionMask, bottom)
                end

                local tile = 34
                if directionMask == 4 then
                    tile = 290
                elseif directionMask == 5 then 
                    tile = 323
                elseif directionMask == 6 then 
                    tile = 324
                elseif directionMask < 8 and not (directionMask == 4) then
                    tile = 34
                elseif directionMask == 8 or directionMask == 12 then 
                    tile = 258
                elseif directionMask == 9 or directionMask == 11 or directionMask == 13 or directionMask == 16 then
                    tile = 259
                elseif directionMask == 10 or directionMask == 14 then
                    tile = 260
                end

                love.graphics.setColor(1, 1, 1, 1)
                simpleDraw("dungeon-tiles", tile, (x-1) * TILE_SIZE, (y-1) * TILE_SIZE, "dungeon-tiles")
            end
        end
    end
end

function buildDungeon(width, height)
    local damageTiles = {131, 132, 162, 163, 164, 194, 195}
    local damageChance = 5
    local undamagedTile = 130
    local dungeon = {}
    for y=1, height do
        for x=1, width do
            if not dungeon[y] then
                dungeon[y] = {}
            end
        
            local damage = math.random(1, 100)
            if y == 1 or y == height or x == 1 or x == width then
                dungeon[y][x] = 1
            elseif damage < damageChance then
                local tile = math.random(1, #damageTiles)
                dungeon[y][x] = damageTiles[tile]
            else
                dungeon[y][x] = undamagedTile
            end
        end
    end
    return dungeon
end