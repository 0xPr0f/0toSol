// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// safe math
contract SafeMath {
    /// @notice This should return an error for undeflow, when using > 0.8.x
    function underflow() public pure returns (uint256) {
        uint256 x = 0;
        x--;
        return x;
    }

    /// @notice This should not return an error for undeflow becasue of unchecked {}, when using > 0.8.x
    function uncheckedUnderflow() public pure returns (uint256) {
        uint256 x = 0;
        unchecked {
            x--;
        }
        return x;
    }
}
