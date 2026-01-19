// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/DoubleEntryPoint.sol";
import "forge-std/Script.sol";

contract Bot is IDetectionBot {
    Forta public forta_ = Forta(0x8d38A390959fAb2BF008bA6E49aF8Eb3D19E24d7);
    CryptoVault public cv_ = CryptoVault(0x1ee6F5EC79B4f94862B3839D7Eb661bAcf79f2e1);

    function handleTransaction(address user, bytes calldata msgData) external override {
        (,, address origSender) = abi.decode(msgData[4:], (address, uint256, address));
        if (origSender == address(cv_)) {
            forta_.raiseAlert(user);
        }

    }

}

contract DoubleEntryPointSol is Script {
    Forta public forta_ = Forta(0x8d38A390959fAb2BF008bA6E49aF8Eb3D19E24d7);
    CryptoVault public cv_ = CryptoVault(0x1ee6F5EC79B4f94862B3839D7Eb661bAcf79f2e1);
    LegacyToken public lt_ = LegacyToken(0x3E847B9aE7613A08c1d8c8E52212e119903312CA);

    function run() external {
        vm.startBroadcast();

        Bot bot = Bot(address(new Bot()));
        forta_.setDetectionBot(address(bot));

        vm.stopBroadcast();
    }
}