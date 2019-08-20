BaseState = Class{}

function BaseState:init() return true end
function BaseState:enter(params) return true end
function BaseState:exit() return true end
function BaseState:update(dt) return true end
function BaseState:render() return true end
function BaseState:processAI(blackboard) return true end