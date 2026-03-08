// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../src/EllipticToken.sol";
import "forge-std/Script.sol";
import {ECDSA} from "openzeppelin-contracts-08/utils/cryptography/ECDSA.sol";

contract EllipticTokenSol is Script {
    EllipticToken public et_ = EllipticToken(0x7787bb9c8aF05C3f19abFE0149ED84b8b733fee3);
    address constant alice_ = 0xA11CE84AcB91Ac59B0A4E2945C9157eF3Ab17D4e;

    uint256 constant amount = 0x4048028c8680395b038d48edc0588b29ad5bdf55c0b3ce031b4db07c27abbec7;
    bytes constant tokenOwnerSignature = hex"4048028c8680395b038d48edc0588b29ad5bdf55c0b3ce031b4db07c27abbec74048028c8680395b038d48edc0588b29ad5bdf55c0b3ce031b4db07c27abbec71b";

    function run() external {
        vm.startBroadcast();

        uint256 pk = uint256(vm.parseBytes32(vm.promptSecret("private key")));

        bytes32 permitAcceptHash = keccak256(abi.encodePacked(alice_, msg.sender, amount));
        (uint8 vSpender, bytes32 rSpender, bytes32 sSpender) = vm.sign(pk, permitAcceptHash);
        bytes memory spenderSignature = abi.encodePacked(rSpender, sSpender, vSpender);

        et_.permit(amount, msg.sender, tokenOwnerSignature, spenderSignature);
        et_.transferFrom(alice_, msg.sender, 10**18*10);

        console.log(et_.balanceOf(msg.sender));
        console.log(et_.balanceOf(alice_));

        vm.stopBroadcast();
    }
}