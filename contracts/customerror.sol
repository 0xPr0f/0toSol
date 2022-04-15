// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
// custom error

contract VendingMachine {
    address payable public owner = payable(msg.sender);
    /// @notice custom error e.g error Unauthorized(); must not be decleared in the contract
    /// @notice custom error e.g error Unauthorized() when decleared outside a contract can be imported into other contracts
    error Unauthorized(string error);
    function withdraw() public {
        if (msg.sender != owner)
    /// @notice Uses less gass than revert("unathourized");
            revert Unauthorized("unathourized");
      owner.transfer(address(this).balance);
    }
}

error InsufficientBalance(uint256 available, uint256 required);

contract TestToken {
    mapping(address => uint) public balance;
    function transfer(address to, uint256 amount) public {
        if (amount > balance[msg.sender])
            revert InsufficientBalance({
                available: balance[msg.sender],
                required: amount
            });
        balance[msg.sender] -= amount;
        balance[to] += amount;
    }
}
