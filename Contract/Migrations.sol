// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DeploymentTracker {

    // Address of the contract deployer
    address public deployer;
    uint public lastMigrationStep;

    constructor() {
        deployer = msg.sender;
    }

    // Modifier to restrict access to the deployer
    modifier onlyDeployer() {
        require(
            msg.sender == deployer,
            "Access restricted to the deployer of the contract"
        );
        _;
    }

    // Function to update the migration step
    function updateMigrationStep(uint step) public onlyDeployer {
        lastMigrationStep = step;
    }
}
