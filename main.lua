local instance = require(game.ServerScriptService.instance)

local instance = instance:new("Part", workspace)
instance.Name = "Test"
local instance2 = instance:new("Decal", instance)
instance2.Name = "TestDecal"
instance2.Texture = "rbxassetid://3847925"

print(instance:recallAllInstancesMadeByModule()) --expected output: {Test}
instance:destroyAllInstancesMadeByModule("Part") --only should delete instance1

