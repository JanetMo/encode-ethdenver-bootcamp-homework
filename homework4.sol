// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract VolcanoCoin {
    // Create a variable to hold the total supply of 10000
    uint256 private totalSupply = 10000;

    //We probably want users to be aware of functions in the contract for greater transparency
    // But to make them all public will create some security risks
    // e.g. we don't want users to be able to change the total supply
    // Declare an address variable called owner .
    address private owner;
    
    // In order to keep track of user balances, we need to associate a user's address with the balance that they have
    // Using your choice of data structure, set up a variable called balances 
    // to keep track of the number of volcano coins that a user has
    mapping(address => uint256) private balances;

    // We want to have a payments array for each user sending the payment
    // Create a mapping which returns an array of Payment structs when given this user's address
    mapping(address => Payment[]) private transfers;

    event TotalSupplyIncreased(uint256 newTotalSupply);
    event TransferEvent(uint256 amount, address indexed recipient);

    // We want to keep a record for each user's transfers
    // Create a struct called Payment that stores the transfer amount and the recipient's address
    struct Payment {
        uint256 amount;
        address recipient;
    }

    // Next, create a modifier which only allows an owner to execute certain functions
    modifier onlyOwner() {
        require(msg.sender == owner, "This is an owner only function");
        _;
    }
    // The contract owner's address should only be updateable in one place
    // Create a constructor and within the constructor, store the owner's address

    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

 // Make a public function that returns the total supply
    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    // Make a public function that can increase the total supply
    // Inside the function, add 1000 to the current total supply.
    // Make your change total supply function public , but add your modifier so that only the owner can execute it
    // It would be useful to broadcast a change in the total supply
    // Create an event that emits the new value whenever the total supply changes
    // When the supply changes, emit this event
    // change the constructor, to give all of the total supply to the owner of the contract
    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        // balances[owner] += 1000;
        emit TotalSupplyIncreased(totalSupply);
    }

    // We want to allow the balances variable to be read from the contract
    function getAccountBalance(address account) public view returns (uint256){
        require(msg.sender == account, "You are not the holder of this address");
        return balances[account];
    }

    function getAccountTransfers(address account) public view returns (Payment[] memory){
        require(msg.sender == account, "Stop counting someone else's pockets");
        return transfers[account];
    }

    //  Now add a public function called transfer to allow a user to transfer their tokens to another address
    //  This function should have 2 parameters : the amount to transfer and the recipient address.

    function transfer(uint256 amount, address recipient) public {
        require(amount <= balances[msg.sender], "You can't transfer more tokens than you have");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        transfers[msg.sender].push(Payment(amount, recipient));
        // Add an event to the transfer function to indicate that a transfer has taken place
        // It should log the amount and the recipient address
        emit TransferEvent (amount, recipient);
    }

}