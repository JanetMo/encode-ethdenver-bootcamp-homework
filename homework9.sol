// NFT contract with Open Zeppelin libraries

// Create a VolcanoNFT contract 
// This should inherit from any ERC721 implementation from the Open Zeppelin standard libraries

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract VolcanoNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Give your NFT a name and a symbo
    constructor() ERC721("VolcanoNFT", "VLCN") {

    }

    function mint() public returns (uint256) {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _mint(msg.sender, newItemId);
    return newItemId;
    }
}