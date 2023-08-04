module NFA where
import TypesDefinition

epsilon = ""

-- Verify NFA and return a boolean
acceptsNFA :: Automata -> String -> Bool
acceptsNFA (Automata states alphabet transitions startState acceptStates) input 
        = verify startState input
  where
    verify state [] = elem state acceptStates
    verify state (x:xs)
     |(findTransition state x transitions) == [""] = False
     | otherwise = verifyAll verify (findTransition state x transitions) xs

verifyAll :: (State -> String -> Bool) -> [State] -> String -> Bool
verifyAll _ [] _ = False
verifyAll func (state:states) input = func state input || verifyAll func states input

findTransition :: State -> Symbol -> [Transition] -> [State]
findTransition curState symbol [] = [""]
findTransition curState symbol ((from,sym,to):rest)
 | curState == from && symbol == sym = [to] ++ findTransition curState symbol rest
 | otherwise = findTransition curState symbol rest

