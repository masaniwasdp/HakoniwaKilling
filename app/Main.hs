import Hakocalc.Command (calcProbability, calcQuantity)
import Hakocalc.Parser (Option (ProbabilityOption, QuantityOption), optionParser)
import Options.Applicative (customExecParser, prefs, showHelpOnError)


main :: IO ()

main = run =<< customExecParser (prefs showHelpOnError) optionParser


run :: Option -> IO ()

run (ProbabilityOption opt) = calcProbability opt

run (QuantityOption opt) = calcQuantity opt
