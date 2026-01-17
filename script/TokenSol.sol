// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface Token {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract TokenSol is Script {
    Token public token_ = Token(0x2aFF79d413f38731B3C5Ddb48AdBeeC6a602B6ab);

    function run() external {
        vm.startBroadcast();

        console.log("balance: ", token_.balanceOf(msg.sender));
        token_.transfer(address(0), 21);
        console.log("balance: ", token_.balanceOf(msg.sender));

        vm.stopBroadcast();
    }
}