// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";

interface Solver {
    function isEven(uint256) external returns (uint32);
}

contract Challenge2Test is Test {
    function testEvenNumber() public {
        // 6 bytes
        Solver solver = Solver(HuffDeployer.deploy("Challenge2"));
        emit log_uint(address(solver).code.length);

        assertEq(1, solver.isEven(0));
        assertEq(1, solver.isEven(2));
        assertEq(1, solver.isEven(4));
        assertEq(1, solver.isEven(231231231231231231232134));
        assertEq(0, solver.isEven(1));
        assertEq(0, solver.isEven(3));
        assertEq(0, solver.isEven(5));
        assertEq(0, solver.isEven(231231231231231231232133));
    }
}
