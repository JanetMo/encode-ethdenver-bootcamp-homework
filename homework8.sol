// Write unit tests for your Volcano coin contract (from homework 5)
// The tests should show that, 1. The total supply is initially 10000, 2. That the total supply can be increased in 1000 token steps and 3. Only the owner of the contract can increase the supply.

// Example Using Foundry

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

    import "forge-std/Test.sol";
    import "../homework5.sol";

contract VolcanoCoinTest is Test {
    VolcanoCoin public vc;
    address deployer = address(0);
    address alice = address(1);
    uint256 totalSupply = 1000;

    //deploy contract
    function setUp() public {
    vm.prank(deployer);
    vc = new VolcanoCoin();
    }

    // init totalySupply == 1000
    function testInitTotalSupply() public {
    assertEq(vc.totalSupply(), totalSupply);
    }

    // Owner can increase totalySuppply
    function testIncreaseSupply() public {
        vm.prank(deployer);
        vc.increaseSupply();
        assertEq(vc.totalSupply(), 2000);
    }

    // Must be owner to inrease supply
    function testOnlyOwner() public {
        vm.prank(alice);
        vm.expectRevert(bytes("Must be owner"));
        vc.increaseSupply();
        assertEq(vc.totalSupply(), 1000);
    }
}