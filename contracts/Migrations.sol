// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Migrations {
    // Public state variables to store owner and migration step.
    address public owner;
    uint256 public last_completed_migration;

    // Modifier to ensure only the owner can call the restricted functions
    modifier restricted() {
        require(msg.sender == owner, "You are not the contract owner");
        _; // Continue execution if the condition is met
    }

    // Constructor to initialize the contract with the deployer's address and initial migration step
    constructor() { 
        owner = msg.sender;  // Set the owner as the deployer (msg.sender)
    }

    // Function to update the last completed migration step
    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed; // Set the new migration step
    }

    // Function to upgrade the contract to a new address with the same interface
    function upgrade(address new_address) public restricted {
        // Ensure the new contract address is a valid contract of type 'Migrations'
        Migrations upgraded = Migrations(new_address);
        
        // Call setCompleted on the new contract to ensure continuity in migration steps
        upgraded.setCompleted(last_completed_migration);
    }
}
