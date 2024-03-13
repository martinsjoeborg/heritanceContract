// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract InheritanceContract {
    address public owner;
    address public heir;
    uint256 public lastWithdrawal;

    constructor(address _heir) {
        owner = msg.sender;
        heir = _heir;
        lastWithdrawal = block.timestamp;
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(amount <= address(this).balance, "Insufficient balance");
        lastWithdrawal = block.timestamp;
        payable(owner).transfer(amount);
    }

    function claimControl() public {
        require(msg.sender == heir, "Only the heir can claim control");
        require(block.timestamp >= lastWithdrawal + 30 days, "Owner has not been inactive for 30 days.");
        owner = heir;
        heir = address(0);
    }

    function designateNewHeir(address newHeir) public {
        require(msg.sender == owner, "Only the owner can designate a new heir");
        heir = newHeir;
    }
}