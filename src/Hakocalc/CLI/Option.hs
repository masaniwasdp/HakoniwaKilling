module Hakocalc.CLI.Option where


import Hakocalc.Entity.Defeat (HP, Probability, Quantity)


data Option
  = OptionP HP Quantity
  | OptionQ HP Probability