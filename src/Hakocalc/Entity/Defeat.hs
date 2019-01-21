{-|
 - Description : Modulo por kalkuli probablon de mortigi monstron.
 - Copyright   : 2019 masaniwa
 - License     : MIT
 -}
module Hakocalc.Entity.Defeat
  ( HP
  , Quantity
  , defeatProbability
  , enoughMissiles
  ) where


import Data.List (find)
import Hakocalc.Entity.Common (repeated)
import Hakocalc.Entity.Probability (Probability, fromProbability, toProbabilityJust)
import Numeric.Natural (Natural)


{-| Reprezentanta HP. -}
type HP = Natural


{-| Reprezentanta kvanto. -}
type Quantity = Natural


{-| Kalkulas probablon de sukcesi mortigi monstron. -}
defeatProbability :: HP -> Quantity -> Probability

defeatProbability h q = toProbabilityJust $ sum xs
  where
    xs = map (fromProbability . repeated accuracy q) [h .. q]


{-| Kalkulas postulitan kvanton da misiloj por mortigi monstron. -}
enoughMissiles :: HP -> Probability -> Maybe Quantity

enoughMissiles h p
  | fromProbability p == 0 = Nothing
  | fromProbability p == 1 = Nothing

  | otherwise = find (\q -> defeatProbability h q >= p) [h ..]


{-| La precizeco de misilo-sukcesoj. -}
accuracy :: Probability

accuracy = toProbabilityJust $ recip 7