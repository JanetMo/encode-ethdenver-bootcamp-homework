// SPDX-License-Identifier: UNLICENSED

/* Update your Volcano coin contract (homework 4) to inherit from the Open Zeppelin Ownable
contract, and use this to replace the owner functionality in your contract. */ 

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {

    uint256 private totalSupply = 10000;
    address private owner;
    mapping(address => uint256) private balances;
    mapping(address => Payment[]) private transfers;

    event TotalSupplyIncreased(uint256 newTotalSupply);
    event TransferEvent(uint256 amount, address indexed recipient);

    struct Payment {
        uint256 amount;
        address recipient;
    }

   constructor() {
   //   owner = msg.sender;
   //   balances[owner] = totalSupply;
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    // only owner should be able to call this funciton
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
        emit TransferEvent (amount, recipient);
    }

}