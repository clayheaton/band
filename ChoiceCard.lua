--[[
  Use when there's a choice between several options
  other than 
]]

require('colors')
require('states')
require('Card')

ChoiceCard = class('ChoiceCard', Card)

function ChoiceCard:initialize(event_table)
  Card.initialize(self, event_table)
end

function ChoiceCard:shiftPosition(dir)
  Card.shiftPosition(self, dir)
  print("shift position in ChoiceCard")
end
