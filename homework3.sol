// SPDX-License-Identifier: None

pragma solidity 0.8.17;

contract BootcampContract {
    uint256 number;
    // Add a variable to hold the address of the deployer of the contract
    address deployer;

    // Update that variable with the deployer's address when the contract is deployed.
    constructor(){
        deployer = msg.sender;
    }

    function store(uint256 num) public {
        number = num;
    }

    function retrieve() public view returns (uint256){
        return number;
    }

    // Write an external function to return Address 0x000000000000000000000000000000000000dEaD if called by the deployer
    // Return the deployers address otherwise
    function returnAddress() public view returns (address){
        if(msg.sender != deployer){
            return 0x000000000000000000000000000000000000dEaD;
        }
        return deployer;
    } 
}
