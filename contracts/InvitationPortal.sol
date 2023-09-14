// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract InvitationPortal {
    uint256 totalConfirmations;

    event NewConfirmation(address indexed from, uint256 timestamp, string message);

    struct Confirmation {
        address guest; // Endereço do usuário que deu tchauzinho
        string message;
        uint256 timestamp;
    }

    Confirmation[] confirmations;

    constructor() {
        console.log("Ueba, i'm a smart contract");
    }

    function confirm(string memory _message) public {
        totalConfirmations += 1;
        console.log("%s confirmed presence! With message %s", msg.sender, _message);

        confirmations.push(Confirmation(msg.sender, _message, block.timestamp));
        emit NewConfirmation(msg.sender, block.timestamp, _message);

    }

    function getAllConfirmations() public view returns (Confirmation[] memory) {
        return confirmations;
    }

    function getTotalConfirmations() public view returns (uint256) {
        console.log("We have a total of %d confirmations!", totalConfirmations);
        return totalConfirmations;
    }
}