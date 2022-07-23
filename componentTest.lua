local m = setmetatable({}, {})
m.__index = function()
  throw("Tried to call something not valid in InstanceMod", 1)
end

self.instancesCalledByMod = {}
self.throws = 0

function m:new(calledInstance : string, parent)
  local instance
  if m:checkIfInstanceStringExists(calledInstance) then
    instance = Instance.new(calledInstance)
  else
    throw("Invalid instance: "..calledInstance, 1)
    return
  end
  if parent then
    instance.Parent = parent
  else
    throw("Invalid parent: "..parent.Name, 1)
    return
  end
  table.insert(self.instancesCalledByMod, instance)
  return instance
end
  
function throw(string : string, type : number)
    error("[ERROR "..os.clock().."] "..string, if number then number else 0)
    self.throws += 1
end

function m:recallAllInstancesMadeByModule(instanceFilter : string)
  if instanceFilter then
    local instanceFilterIsFake : boolean = not m:checkIfInstanceStringExists(instanceFilter)
    if instanceFilterIsFake then
      throw("Invalid instance filter: "..instanceFilter, 1)
      return
    end
    local found = {}
    for i, v in pairs(self.instancesCalledByMod) do
      if v.ClassName == instanceFilter then
        table.insert(found, v)
      end
    end
    return found
  else
    return self.instancesCalledByMod
  end
end



function m:checkIfInstanceStringExists(instanceString : string)
  local success, err = pcall(function()
    local instance = Instance.new(instanceString)
  end)
  return success == true and not error
end

 

function m:destroyAllInstancesMadeByModule(instanceFilter : string)
  if instanceFilter then
    local instanceFilterIsFake : boolean = not m:checkIfInstanceStringExists(instanceFilter)
    if instanceFilterIsFake then
      throw("Invalid instance filter: "..instanceFilter, 1)
      return
    end
    local found = {}
    for i, v in pairs(self.instancesCalledByMod) do
      if v.ClassName == instanceFilter then
        v:Destroy()
        table.remove(self.instancesCalledByMod, v)
      end
    end
    
  else
    for i, v in pairs(self.instancesCalledByMod) do
      v:Destroy()
      table.remove(self.instancesCalledByMod, v)
    end
  end
  warn()
end

function m.tostring() : string
  return "Instance"
end

function m.tonumber() : number
  return 0
end
