// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract MotorbikeSol is Script {

    function run() external {
        vm.startBroadcast();

        uint256 pk = uint256(vm.parseBytes32(vm.promptSecret("private key")));
        vm.signAndAttachDelegation(address(0), pk);

        payable(msg.sender).transfer(0);

        vm.stopBroadcast();
    }
}