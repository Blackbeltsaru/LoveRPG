StateStack = Class{}

function StateStack:init(states)
    self.states = {}
    --#if DEBUG
    self.debugIndex = 1
    --#endif
end

-- Updates the top layer in the stack unless the update 
-- Explicitly says continue update other states
function StateStack:update(dt)
    local index = #self.states
    local continue
    repeat 
        continue = self.states[index]:update(dt)
        index = index - 1
    until index <= 0 or (not continue)
end

function StateStack:processAI()
    local index = #self.states
    local continue
    repeat 
        continue = self.states[index]:processAI()
        index = index - 1
    until index <= 0 or (not continue)
end

function StateStack:render() 
    --TODO:(Ryan) Do we want to add the ability for a state to prevent further renders
    for i, state in ipairs(self.states) do
        state:render()
    end
end

function StateStack:clear()
    self.states = {}
end

function StateStack:push(state)
    --#if DEBUG
    table.insert( self.states, self.debugIndex, state)
    self.debugIndex = self.debugIndex + 1
    --#elseif
    --table.insert( self.states, state)
    --#endif
    state:enter()
end

function StateStack:pop()
    --#if DEBUG
    self.states[self.debugIndex - 1]:exit()
    table.remove(self.states, self.debugIndex - 1)
    --#elseif
    --self.states[#self.states]:exit()
    --table.remove(self.states)
    --#endif
end

--#if DEBUG
function StateStack:pushDebug(debugState) 
    table.insert(self.states, debugState)
    debugState:enter()
end

function StateStack:popDebug()
    self.state[#self.states]:exit()
    table.remove(self.states)
end
--#endif