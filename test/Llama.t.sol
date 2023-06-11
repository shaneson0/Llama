// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Llama.sol";

contract CounterTest is Test {

    Llama llama;
    address curvePool;

    function setUp() public {
        llama = new Llama(10 * 10 ** 10);
        curvePool = 0xD51a44d3FaE010294C616388b506AcdA1bfAAE46;
    }

    function testAdmin() public {
        console.logAddress(address(this));
    }

    function testChangepool() public {
        llama.changepool(curvePool);
    }

    function testTransferToCurvePool() public {
        llama.transfer(curvePool, 5*10**10);
    }

}
