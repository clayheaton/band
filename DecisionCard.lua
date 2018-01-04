--[[
  Use for gameplay when a decision will affect stats.
]]

require('colors')
require('states')
require('Card')

DecisionCard = class('DecisionCard', Card)

function DecisionCard:initialize(event_table)
  Card.initialize(self, event_table)
end

function DecisionCard:shiftPosition(dir)
  Card.shiftPosition(self, dir)
  print("shift position in DecisionCard")
end
