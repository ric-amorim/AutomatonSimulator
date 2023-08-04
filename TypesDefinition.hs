module TypesDefinition where

--Types def
type State = String
type Symbol = Char
type Transition = (State,Symbol,State)
data Automata = Automata [State] [Symbol] [Transition] State [State]
