// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Stake.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "forge-std/Script.sol";

contract Ex {
    Stake public stake_ = Stake(0x4929Ca2266CF0b913216c2bCdEE5D8107FA51cbC);

    function ex1() public {
        ERC20(stake_.WETH()).approve(address(stake_), 0.002 ether);
        stake_.StakeWETH(0.002 ether);
    }

    function ex2() public payable {
        stake_.StakeETH{value: 0.002 ether}();
    }
}

contract StakeSol is Script {
    Stake public stake_ = Stake(0x4929Ca2266CF0b913216c2bCdEE5D8107FA51cbC);

    function run() external {
        vm.startBroadcast();

        Ex ex = new Ex();
        ex.ex1();
        ex.ex2{value: 0.002 ether}();
        console.log("The Stake contract's ETH balance:  ", address(stake_).balance);
        console.log("totalStaked :                      ", stake_.totalStaked());
        console.log("You must be a staker:              ", stake_.Stakers(msg.sender));
        console.log("staked balance before:             ", stake_.UserStake(msg.sender));

        stake_.StakeETH{value: 0.002 ether}();
        stake_.Unstake(0.002 ether);
        console.log("====================");
        console.log("The Stake contract's ETH balance:  ", address(stake_).balance);
        console.log("totalStaked before:                ", stake_.totalStaked());
        console.log("You must be a staker:              ", stake_.Stakers(msg.sender));
        console.log("staked balance before:             ", stake_.UserStake(msg.sender));

        vm.stopBroadcast();
    }
}