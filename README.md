# Finite Automaton Simulator in Haskell

This is a finite automaton simulator developed in Haskell with a graphical interface using the GTK library. The simulator is capable of checking whether an input string is accepted by a deterministic finite automaton (DFA) or nondeterministic finite automaton (NFA).

## Features

- Creation of deterministic and nondeterministic finite automata
- Verification of string acceptance by automata
- User-friendly graphical interface for entering states, alphabet, transitions, and input strings

## Prerequisites

Make sure you have the following tool installed on your system IF you want to use the graphical interface:

- GTK: The GTK library should be installed to compile and run the program with the graphical interface.

## Installation

1. Clone this repository to your system:

```bash
git clone https://github.com/ric-amorim/AutomatonSimulator.git
```

2. Navigate to the project directory:

```bash 
cd automaton-simulator
```

## Usage

1. Choose if you want to use the program in the terminal or the interface:

    If you want to use the terminal:
    ```bash 
    ./terminal.sh 
    ```
    
    If you want to use the interface:
    ```bash 
    ./gui.sh
    ```

2. Fill in the input fields with the automaton details:

    Automaton Type (DFA or NFA)
    States
    Alphabet
    Transitions in the format "(state, symbol, next_state)"  (To use the Epsilon use the letter E) Ex: (state,E,next_state).
    Initial State
    Accept States

3. Input the test string and wait for the result.  (To input an empty string use: _ ).


## Contribution

Contributions are welcome! If you wish to contribute to this project by adding features, fixing bugs, or enhancing the interface, please feel free to open an [issue](https://github.com/ric-amorim/AutomatonSimulator/issues) or submit a [pull request](https://github.com/ric-amorim/AutomatonSimulator/pulls). Your contributions will be greatly appreciated!

