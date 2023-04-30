// Write a 'shame coin' contract

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "../lib/openzeppelin-contractscontracts/token/ERC20/ERC20.sol";


contract shameToken is ERC20 {
    address immutable admin;
   
   // The shame coin needs to have an administrator address that is set in the constructor
    constructor() ERC20("ShameCoin", "SME"){
        admin = msg.sender;
    }

     // The decimal places should be set to 0
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }
    
    // The administrator can send 1 shame coin at a time to other addresses (but keep the transfer function signature the same)
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        if (msg.sender == admin) {
            require(amount == 1, "Amount must be 1");
            _mint(to, 1);
            return true;
        } else {
            _mint(msg.sender, 1);
            return true;
        }
    }
     
    // If non administrators try to transfer their shame coin, the transfer function will instead increase their balance by one.
    // Non administrators can approve the administrator (and only the administrator) to spend one token on their behalf
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        require(spender == admin, "Spender must be admin");
        require(amount == 1, "Amount must be 1");
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    // The transfer from function should just reduce the balance of the holder
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _burn(from, amount);
        return true;
    }
}