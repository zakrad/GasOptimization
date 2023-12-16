// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "../src/Distribute.sol";

contract DistributeTest is Test {
    Distribute public distribute;

    address user = vm.addr(1);
    uint256 passedTime = block.timestamp + 3 weeks;

    function setUp() public {
        address[6] memory contributors =
            [address(user), address(user), address(user), address(user), address(user), address(user)];
        vm.prank(user);
        vm.deal(user, 6 ether);
        distribute = new Distribute{value : 6 ether}(contributors);
    }

    function test_Distribute() public {
        skip(passedTime);
        uint256 beforeBalance = address(user).balance;
        distribute.distribute();
        uint256 afterBalance = address(user).balance;
        assertEq(afterBalance - beforeBalance, 6 ether);
    }

    function test_RevertDistribute() public {
        vm.expectRevert();
        distribute.distribute();
    }
}
