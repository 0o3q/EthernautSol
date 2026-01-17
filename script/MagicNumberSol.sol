// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/MagicNumber.sol";
import "forge-std/Script.sol";

contract Ex {
    constructor() {
        assembly {
            mstore(0, 0x602a3d5260203df3)
            return(0x18, 0x0a)
        }
    }
}

contract MagicNumberSol is Script {
    MagicNum public mn_ = MagicNum(0xE014CA873DA55A5a0BDb583046Ee273ACF243B3c);

    function run() external {
        vm.startBroadcast();

        Ex ex = new Ex();
        mn_.setSolver(address(ex));

        vm.stopBroadcast();
    }
}