--[[
Abstract parent class for game scenes.
]]

require('states')

Scene = class('Scene')

function Scene:initialize(scene_name)
  self.name = scene_name
end

function Scene:update(dt)

end

function Scene:draw()

end

function Scene:keypressed(key, scancode, isrepeat)
  print(key .. " pressed: Scene default behavior")
end

function Scene:mousepressed(x, y, button, istouch)
  print("Mouse button " .. button .. " pressed: Scene default behavior")
end
