--[[
  Use for creating a character. Commiting left or right will
  set a characteristic. Male vs. Female, etc.
]]

require('colors')
require('states')
require('Card')

CharacterCard = class('CharacterCard', Card)

function CharacterCard:initialize(event_table)
  Card.initialize(self, event_table)
end

function CharacterCard:shiftPosition(dir)
  Card.shiftPosition(self, dir)
  print("shift position in CharacterCard")
end
