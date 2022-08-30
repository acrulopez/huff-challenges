// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/Vm.sol";

interface Solver {
    function deposit() external payable;

    function withdraw() external payable;

    function setWithdrawer(address) external payable;
}

contract Challenge3Test is Test {
    uint256 attackerFunds = 1 ether;
    uint256 solverFunds = 0.1 ether;
    address attackerAddress = address(314159);
    Solver solver;

    function setUp() public {
        solver = Solver(HuffDeployer.deploy("Challenge3"));
        vm.deal(address(solver), solverFunds);
        vm.deal(attackerAddress, attackerFunds);
    }

    function testDrainFunds() public {
        vm.startPrank(attackerAddress);
        solver.deposit{value: 1}();
        solver.setWithdrawer{value: 2}(attackerAddress);
        solver.withdraw();

        assertEq(attackerAddress.balance, attackerFunds + solverFunds);
        assertEq(address(solver).balance, 0);
    }
}
