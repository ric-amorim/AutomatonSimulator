module DFA where
import TypesDefinition

-- Verify DFA and return a boolean
acceptsDFA :: Automata -> String -> Bool
acceptsDFA (Automata states alphabet transitions startState acceptStates) input 
        = verify startState input
  where
    verify state [] = elem state acceptStates
    verify state (x:xs)
     |(findTransition state x transitions) == "" = False
     | otherwise = verify (findTransition state x transitions)  xs


findTransition :: State -> Symbol -> [Transition] -> State
findTransition curState symbol [] = ""
findTransition curState symbol ((from,sym,to):rest)
 | curState == from && symbol == sym = to 
 | otherwise = findTransition curState symbol rest

{-
-- Ex
dfaExample :: Automata
dfaExample = Automata
  ["q0", "q1", "q2"]
  ['0', '1']
  [("q0", '0', "q1"), ("q0", '1', "q0"), ("q1", '0', "q2"), ("q1", '1', "q0"), ("q2", '0', "q2"), ("q2", '1', "q2")]
  "q0"
  ["q2"]
-}
