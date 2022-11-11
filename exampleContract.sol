// SPDX-License-Identifier: UNLICENSED 
// example contract to show the use of different data types in solidity 

// define the compiler version, used to convert solidity into EVM-readable bytecode 
pragma solidity >0.7.6 <0.8.4;

// initialize a contract
contract Score {
    
    // Solidity is a statically typed language: declare the variable type before the variable name
    uint score = 5;
    // "indexed" keyword enables to search for events via Web3 in the front-end
    event Score_set(uint indexed); 

    // array to give back the score to a user 
    // uint my_score = score_list[owner];

    // constructor, defining the owner before the modifier 
    address owner; constructor() { 
        owner = msg.sender; 
    } 
    

    // modifier enables only certain addresses to change the score
    // usually used to automatically check a condition before executing a function
    // msg.sender: global variable returning the address of the caller of the function
    modifier onlyOwner {
        if (msg.sender == owner) { 
        _; 
        } 
    } 

    // first function: setter modifies the value of a variable
    // specifies between parentheses the variable type and the variable name
    // restrict it to the owner
    // sets it to new_score
    // create an event to display the new score 
    function setScore(uint new_score) public onlyOwner { 
	    score = new_score;
        emit Score_set(new_score);  
    } 

    // second function: getter that returns a value
    // function definition: "returns" keyword + variable type returned 
    // function body: "return", followed by what you want to return
    function getScore() public view returns (uint) {
	    return score; 
    } 

    // store a mapping of all the user addresses and their associated score
    // mapping(address => uint) score_list;

    // function getUserScore(address user) public view 
    // returns (uint) { 
    // return score_list[user]; 
    // }
}