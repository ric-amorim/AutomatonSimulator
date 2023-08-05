module NFA where
import TypesDefinition

-- !!!! test more to see if its good
-- doesnt work if its empty string


-- Verify NFA and return a boolean
acceptsNFA :: Automata -> String -> Bool
acceptsNFA (Automata states alphabet transitions startState acceptStates) input 
        = verify startState input
  where
    verify state [] = elem state acceptStates
    verify state (x:xs)
     | elem (state,'E',next) transitions == True = verifyAll verify (next:rest) (x:xs)
     | otherwise = verifyAll verify (next:rest) xs
     where 
        (next:rest) = findTransition state x transitions

verifyAll :: (State -> String -> Bool) -> [State] -> String -> Bool
verifyAll _ [] _ = False
verifyAll func (state:states) input = func state input || verifyAll func states input

findTransition :: State -> Symbol -> [Transition] -> [State]
findTransition curState symbol [] = [""]
findTransition curState symbol ((from,sym,to):rest)
 | (curState == from && symbol == sym) || (curState == from && sym == 'E') = [to] ++ findTransition curState symbol rest
 | otherwise = findTransition curState symbol rest




