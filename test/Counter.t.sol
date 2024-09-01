// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function testFuzz_Increment(uint256 x) public {
        if (x == type(uint256).max) {
            counter.setNumber(x);
            vm.expectRevert("Increment would cause overflow");
            counter.increment();
        } else {
            counter.setNumber(x);
            counter.increment();
            assertEq(counter.number(), x + 1);
        }
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function testFuzz_Decrement(uint256 x) public {
        counter.setNumber(x);
        if (x == 0) {
            vm.expectRevert();
            counter.decrement();
        } else {
            counter.decrement();
            assertEq(counter.number(), x - 1);
        }
    }
}
