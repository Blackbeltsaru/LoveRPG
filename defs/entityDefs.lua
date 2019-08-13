
ENTITY_DEFS = {
    ["player"] = {
        walkSpeed = 60,
        activeOnAlive = true,
        renderOffsetX = 8,
        renderOffsetY = 25,
        hitboxOffsetX = 8,
        hitboxOffsetY = 18,
        hitboxWidth = 16,
        hitboxHeight = 18,
        hurtbox = {
            up = {
                hurtboxOffsetX = 8,
                hurtboxOffsetY = 26,
                hurtboxWidth = 16,
                hurtboxHeight = 8,
            },
            down = {
                hurtboxOffsetX = 8,
                hurtboxOffsetY = 0,
                hurtboxWidth = 16,
                hurtboxHeight = 8,
            },
            right = {
                hurtboxOffsetX = -8,
                hurtboxOffsetY = 18,
                hurtboxWidth = 8,
                hurtboxHeight = 18,
            },
            left = {
                hurtboxOffsetX = 16,
                hurtboxOffsetY = 18,
                hurtboxWidth = 8,
                hurtboxHeight = 18,
            }
        },
        components = {
            Walk,
            PlayerControlled,
            Attack,
        },
        animations = {
            ['walk-left'] = {
                frames = {52, 53, 54, 55},
                interval = 0.155,
                texture = 'player-character'
            },
            ['walk-right'] = {
                frames = {18, 19, 20, 21},
                interval = 0.155,
                texture = 'player-character'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.155,
                texture = 'player-character'
            },
            ['walk-up'] = {
                frames = {35, 36, 37, 38},
                interval = 0.155,
                texture = 'player-character'
            },
            ['idle-left'] = {
                frames = {52},
                texture = 'player-character'
            },
            ['idle-right'] = {
                frames = {18},
                texture = 'player-character'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'player-character'
            },
            ['idle-up'] = {
                frames = {35},
                texture = 'player-character'
            },
            ['sword-left'] = {
                renderOffsetX = 17,
                interval = 0.05,
                frames = {57, 58, 59, 60},
                texture = 'player-character-swing'
            },
            ['sword-right'] = {
                renderOffsetX = 15,
                interval = 0.05,
                frames = {49, 50, 51, 52},
                texture = 'player-character-swing'
            },
            ['sword-up'] = {
                renderOffsetX = 16,
                interval = 0.05,
                frames = {41, 42, 43, 44},
                texture = 'player-character-swing'
            },
            ['sword-down'] = {
                renderOffsetX = 16,
                interval = 0.05,
                frames = {33, 34, 35, 36},
                texture = 'player-character-swing'
            }
        }
    }
}