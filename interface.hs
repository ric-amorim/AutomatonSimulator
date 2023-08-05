import NFA 
import DFA
import TypesDefinition
import Graphics.UI.Gtk
import Data.Char
import qualified Data.Text as T

readTransitions :: [String] -> [Transition]
readTransitions [] = []
readTransitions (x:xs) = (from, head symbol, to) : readTransitions xs
               where 
                  from = takeWhile (not . isPunctuation) y
                  y = dropWhile isPunctuation x
                  symboltemp = dropWhile (not . isPunctuation) y
                  symbol = tail symboltemp 
                  toTemp = tail (tail symbol)
                  to = takeWhile (not . isPunctuation) toTemp

onVerifyButtonClicked :: Entry -> Entry -> Entry -> Entry -> Entry -> Entry -> TextView -> TextBuffer-> IO ()
onVerifyButtonClicked automataTypeEntry statesEntry alphabetEntry transitionsEntry startEntry acceptEntry inputTextView resultBuffer= do
    automataType <- entryGetText automataTypeEntry
    states <- entryGetText statesEntry
    alphabet <- entryGetText alphabetEntry
    transitions <- entryGetText transitionsEntry
    startState <- entryGetText startEntry
    acceptStates <- entryGetText acceptEntry
    inputBuffer <- textViewGetBuffer inputTextView
    startIter <- textBufferGetStartIter inputBuffer
    endIter <- textBufferGetEndIter inputBuffer
    inputText <- textBufferGetText inputBuffer startIter endIter False
    let input = T.unpack inputText


    -- Create automaton based on user input
    let automaton = Automata (words states) (filter (not . isSpace) alphabet) (readTransitions (words transitions)) startState (words acceptStates)

    -- Verify input against the automaton
    let result
         | automataType == "DFA" = acceptsDFA automaton input
         | automataType == "NFA" = acceptsNFA automaton input
         | otherwise = error "Invalid Type"

    -- Display result in the inputTextView
    let resultText = if result then "Accepted! :)" else "Rejected! :("
    textBufferSetText resultBuffer resultText

main :: IO ()
main = do
    initGUI

    -- Create Window
    window <- windowNew
    set window [windowTitle := "Automata Simulator", windowDefaultWidth := 400, windowDefaultHeight := 300, containerBorderWidth := 10]

    typeLabel <- labelNew (Just "Choose DFA or NFA")
    typeEntry <- entryNew
    statesLabel <- labelNew (Just "States       Ex: q0 q1 ")
    statesEntry <- entryNew
    alphabetLabel <- labelNew (Just "Alphabet      Ex: a b ")
    alphabetEntry <- entryNew
    transitionsLabel <- labelNew (Just "Transitions (current State, symbol, next State)        Ex: (q0,a,q1)  | (epsilon is represented by: E) Ex: (q0,E,q0) ")
    transitionsEntry <- entryNew
    startLabel <- labelNew (Just "Starting State      Ex: q0 ")
    startEntry <- entryNew
    acceptLabel <- labelNew (Just "Accepted States    Ex: q0 q1")
    acceptEntry <- entryNew
    inputLabel <- labelNew (Just "Input       Ex: 01101011  | (Empty input is represented by: _ ) Ex: _ ")
    inputTextView <- textViewNew
    verifyButton <- buttonNewWithLabel "Check Input"
    resultTextView <- textViewNew
    resultLabel  <- labelNew (Just "Result:")
    resultBuffer <- textViewGetBuffer resultTextView

    -- Add elements to window
    vbox <- vBoxNew False 5
    containerAdd vbox typeLabel
    containerAdd vbox typeEntry

    containerAdd vbox statesLabel
    containerAdd vbox statesEntry

    containerAdd vbox alphabetLabel
    containerAdd vbox alphabetEntry

    containerAdd vbox transitionsLabel
    containerAdd vbox transitionsEntry

    containerAdd vbox startLabel
    containerAdd vbox startEntry

    containerAdd vbox acceptLabel
    containerAdd vbox acceptEntry

    containerAdd vbox inputLabel
    containerAdd vbox inputTextView
    containerAdd vbox verifyButton
    containerAdd vbox resultLabel
    containerAdd vbox resultTextView
    containerAdd window vbox

    -- Add the following line after creating the verifyButton
    onClicked verifyButton $ onVerifyButtonClicked typeEntry statesEntry alphabetEntry transitionsEntry startEntry acceptEntry inputTextView resultBuffer



    -- Show window
    widgetShowAll window

    mainGUI

