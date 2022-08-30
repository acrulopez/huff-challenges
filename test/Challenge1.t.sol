// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";

interface Solver {
    function blockNumber() external returns (uint32);
}

contract Challenge1Test is Test {
    function testBlockNumber() public {
        // 6 bytes
        Solver solver = Solver(HuffDeployer.deploy("Challenge1"));
        emit log_uint(address(solver).code.length);

        // 14 gas
        uint32 blockNumber = solver.blockNumber();
        assertEq(blockNumber, block.number);
    }
}
