// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
//@notice Salted contract creations / create2
contract D {
    uint public x;
    constructor(uint a) {
        x = a;
    }
}

contract Create2A {
    function getBytes32(uint salt) external pure returns (bytes32) {
        return bytes32(salt);
    }

    function getAddress(bytes32 salt, uint arg) external view returns (address) {
        address addr = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(abi.encodePacked(
                type(D).creationCode,
                arg
            ))
        )))));

        return addr;
    }

    address public deployedAddr;

    function createDSalted(bytes32 salt, uint arg) public {
        D d = new D{salt: salt}(arg);
        deployedAddr = address(d);
    }
}
