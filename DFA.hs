module DFA where

--Types def
type State = String
type Symbol = Char
type Transition = (State,Symbol,State)
data DFA = DFA [State] [Symbol] [Transition] State [State]

-- Verify DFA and return a boolean
accepts :: DFA -> String -> Bool
accepts (DFA states alphabet transitions startState acceptStates) input 
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

-- Ex
dfaExample :: DFA
dfaExample = DFA
  ["q0", "q1", "q2"]
  ['0', '1']
  [("q0", '0', "q1"), ("q0", '1', "q0"), ("q1", '0', "q2"), ("q1", '1', "q0"), ("q2", '0', "q2"), ("q2", '1', "q2")]
  "q0"
  ["q2"]

