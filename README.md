# 16Parchi_game_Contract
An enjoyable card game where four friends aim to collect four chits, called parchis, of the same type without revealing their hand to one another. They take turns passing chits, and the first to gather four of a kind wins the game!

All funtions of the game

// To set and start the game
    
    function setState(address[2] memory players, uint8[4][2] memory parchis) 
    
// To pass the parchi to next player
    
    function passParchi(uint8 parchi) 

// To claim win
    
    function claimWin() 

//To end the game
    
    function endGame() 
    
//To see the number of wins
    
    function getWins(address add) 

// To see the parchis held by the caller of this function
    
    function myParchis() 

// To get the state of the game
    
    function getState() 
