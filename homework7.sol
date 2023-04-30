// SPDX-License-Identifier: UNLICENSED

// Adding more functionality to the Volcano Coin contract (homework 5)

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {

    uint256 private totalSupply = 10000;
    address private owner;
    mapping(address => uint256) private balances;
    mapping(address => Payment[]) private transfers;

    event TotalSupplyIncreased(uint256 newTotalSupply);
    event TransferEvent(uint256 amount, address indexed recipient);
    event RecordPaymentEvent (); 

    struct Payment {
        uint256 amount;
        address recipient;
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        emit TotalSupplyIncreased(totalSupply);
    }

    function getAccountBalance(address account) public view returns (uint256){
        require(msg.sender == account, "You are not the holder of this address");
        return balances[account];
    }

    function getAccountTransfers(address account) public view returns (Payment[] memory){
        require(msg.sender == account, "Stop counting someone else's pockets");
        return transfers[account];
    }

    function transfer(uint256 amount, address recipient) public {
        require(amount <= balances[msg.sender], "You can't transfer more tokens than you have");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        transfers[msg.sender].push(Payment(amount, recipient));
        // Each time we make a transfer of tokens, we should call the this recordPayment function to record the transfer.
        _recordPayment(msg.sender, to, amount);
        emit TransferEvent (amount, recipient);
    }

    /* We made a payment mapping, but we havenʼt added all the functionality for it yet.
    Write a function to view the payment records, specifying the user as an input.
    What is the difference between doing this and making the mapping public ? */

    /* If we set the mapping to public and call the default getter fn we will have to specify both the mapping key
    and the array position. This will return a single a tuple of a single Payment struct/entry */ 
    //Writing our own function we can return the whole array for a given address. 
    function getPayments(address index) public view returns (Payment[] memory) {
        Payment[] memory arr = payments[index];
        return arr;
    }


    /* For the payments record mapping, create a function called recordPayment that
    takes the senderʼs address, the receiverʼs address and the amount as an input, 
    then creates a new payment record and adds the new record to the userʼs payment record. */ 
    function _recordPayment(address recipient, address to, uint256 amount) private {
        payments[recipient].push(Payment(amount, to));
    }
}