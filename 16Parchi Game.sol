// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolahParchiThap {
    address owner = msg.sender;
    address[2] p;
    uint8[4][2] aparchis;
    uint endgame;
    uint newgame;
    uint startTime;
    uint8 turn;
    uint id;
    
    modifier onlyOwner {require(msg.sender == owner); _;}

    mapping (address => uint8[]) _players;
    mapping(uint => mapping(address => bool)) allPlayers;
    mapping(address => uint) users;
    mapping(address => uint256) wins;

    // To set and start the game
    function setState(address[2] memory players, uint8[4][2] memory parchis) public onlyOwner returns (string memory){
       require(newgame == 0, "Game is currently in session");

    aparchis = parchis;

       for( uint ad; ad < 2; ad++){
        require(players[ad] != address(0));
       }

       for (uint i=0; i < players.length; i++){
            if (players[i] == owner){
                return ("Owner can not be a player");
            } else {
                 allPlayers[id][players[i]] = true;
                _players[players[i]] = parchis[i];
                users[players[i]] = id;
                id += 1;
            }
        } p = players;
        

        startTime = uint(block.timestamp);
        return ("Succeeded");

    }

    // To pass the parchi to next player
    function passParchi(uint8 parchi) public returns (string memory) {
        if(newgame == 0){
            turn = 0;
        }
        
        uint8 j = checkP();
       
        require(j == turn, "It is not your turn to play the game");
        turn  = j + 1;
        require(checkP() != 7, "You are not a valid player");
        require(_players[msg.sender][parchi] > 0, "Not enough parchis to play");
        require(parchi < 4, "Invalid input");

        delete _players[msg.sender][parchi];
        if(turn == 4){
            turn = 1;
        }
        uint8 value = _players[msg.sender][parchi]; 
        _players[p[turn]][parchi] = value;

        newgame = 1;

        return ("Done");
    }


    // To claim win
    function claimWin() public returns (string memory) {
        uint v = checkP();
        require (v != 7, "You are not a vaild memebr of this game");

        for (uint x; x < 4; x++){
            if (_players[msg.sender][x] == 4) {
                endGame();

            } else {
                return ("You do not have a parchi slot of '4'");
            }
        }

        wins[msg.sender] += 1;
    }


    //To end the game
    function endGame() public {
        require(uint(block.timestamp) > (startTime + 1 hours), "The game can not end game at the current moment");

        newgame = 0;
        p[0] = p[1] = address(0);
    }


    //To see the number of wins
    function getWins(address add) public view returns (uint256) {
        require(add != address(0));
        return (wins[msg.sender]);
    }


     // To see the parchis held by the caller of this function
    function myParchis() public view returns (uint8[] memory) {
        require (checkP() != 7, "You are not a vaild memebr of this game");

        uint8[] memory data =_players[msg.sender];

        return (data);
    }

    // To get the state of the game
    function getState() public view onlyOwner returns (address[2] memory, address, uint8[4][2] memory) {
        require(newgame == 1, "Game is not in session");
    }


    function checkP() view internal returns (uint8){
        for (uint8 i; i < 2; i++){
            if(msg.sender == p[i]) return i;
        } return 7;
    }


     function newGame() internal {
        newgame = 1;
    }

}
