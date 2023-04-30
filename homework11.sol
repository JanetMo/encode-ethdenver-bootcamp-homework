// Continue developing your Volcano NFT project (from homework 9)

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address _token;

    constructor(address token) ERC721("VolcanoNFT", "VLCN") {
        _token = token;
    }

    function mintNFT(address recipient) public onlyOwner returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        return newItemId;
    }

    // Add a function that allows a user to mint an NFT if they pay 0.01 ETH
    function EthMint() public payable returns (uint256) {
        require(msg.value != 0.01 ether, "Price is 0.01 eth");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        return newItemId;
    }

    // Make sure that when a token is minted we can specify a token URI - a location wher we can store metadata / images for the NFT.
    function ERC20Mint(uint256 amount) public returns (uint256) {
        require(amount == 1);
        IERC20 token = IERC20(_token); 
        token.transferFrom(msg.sender, address(token), amount);
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        return newItemId;
    }
}