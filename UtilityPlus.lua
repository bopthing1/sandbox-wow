local m = setmetatable({}, {})
m.__index = function() warn("Attempt to index nil object/class in module!") end


function m:new(betaMode : boolean, scriptIndexed : script)
  self.betaMode = betaMode
  self.scriptsIndexed = setmetatable({}, {})
  self.rep64 = setmetatable({}, {})
  rep64.__index = 0
  if scriptsIndexed then table.insert(self.scriptsIndexed, scriptsIndexed) end
end

function m:increa
  
return m

function m:getAllScriptsIndexedInModule()
end
