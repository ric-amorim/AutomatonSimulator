import DFA
import Data.Char

readTransitions :: [String] -> [Transition]
readTransitions [] = []
readTransitions (x:xs) = (from, head symbol, to) : readTransitions xs
               where 
                  from = takeWhile (not . isPunctuation) y
                  y = dropWhile isPunctuation x
                  symboltemp = dropWhile (not . isPunctuation) y
                  symbol = tail symboltemp 
                  toTemp = tail (tail symbol)
                  to = takeWhile (not .isPunctuation) toTemp

main :: IO ()
main = do
  putStrLn "Enter set of states, separated by spaces:"
  statesI <-getLine
  putStrLn "Enter set of symbols, separated by spaces:"
  symbolsI <-getLine
  putStrLn "Enter set of transitions, (current State, symbol, next State) separated by spaces:"
  transitionsI <-getLine
  putStrLn "Enter the starting state:"
  startState <-getLine
  putStrLn "Enter set of accepted states, separated by spaces:"
  acceptedStatesI <-getLine
  let states = words statesI
  let symbols = filter (not . isSpace) symbolsI
  let transitions = readTransitions (words transitionsI)
  let acceptedStates = words acceptedStatesI
  let automata = (DFA states symbols transitions startState acceptedStates)
  putStrLn "----------------"
  putStrLn "Automata Created"
  putStrLn "----------------"
  putStrLn "Enter a string of 0's and 1's:"
  input <- getLine
  let result = accepts automata input
  if result
    then putStrLn "Input Accepted! :)"
    else putStrLn "Input Rejected! :("



