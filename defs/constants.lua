--
-- Version
--
VERSION = "0.0.1"
GAME_TITLE = "Prinia"

--
-- Window constants
--

V_WIDTH = 384 --TODO:(Ryan) Be more thoughtful about these values
V_HEIGHT = 216 

W_WIDTH = 1280 --TODO:(Ryan) Be more thougtful about these values
W_HEIGHT = 720

TILE_SIZE = 16 --TODO:(Ryan) am I certain I want to use 16x16 tiles?


--
--Key Bindings
--
LEFT = "a"
RIGHT = "d"
UP = "w"
DOWN = "s"
ATTACK = "space"

--
--DEBUG COLORS
--
HITBOX_COLOR = {
    r = 1,
    g = 174/255, 
    b = 174/255, 
    a = 1,
}
HURTBOX_COLOR = {
    r = 176/255,
    g = 229/255,
    b = 124/255,
    a = 1,
}
TILE_HIGHLIGHT_COLOR = {
    r = 86/255,
    g = 186/255,
    b = 236/255,
    a = 1,
}