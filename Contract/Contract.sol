// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21;

import './Roles.sol';

contract MedicalAccess {

    using Roles for Roles.Role;

    Roles.Role private admins;
    Roles.Role private physicians;
    Roles.Role private users;

    struct Physician {
        string physicianDataHash;
    }

    struct User {
        string userDataHash;
    }

    struct MedicalRecord {
        string recordDataHash;
    }

    mapping(address => Physician) private physicianData;
    mapping(address => User) private userData;
    mapping(address => MedicalRecord) private medicalRecords;

    address[] public physicianIDs;
    address[] public userIDs;
    string[] public recordDataHashes;

    address private systemAdmin;

    constructor() {
        systemAdmin = msg.sender;
        admins.add(systemAdmin);
    }

    // Retrieve Admin Address
    function getSystemAdmin() public view returns(address) {
        return systemAdmin;
    }

    // Add a Physician
    function registerPhysician(address physicianAddress) public onlyAdmin {
        physicians.add(physicianAddress);
        physicianIDs.push(physicianAddress);
    }

    // Remove a Physician
    function removePhysician(address physicianAddress) public onlyAdmin {
        physicians.remove(physicianAddress);
    }

    // Check if Address Belongs to a Physician
    function isPhysician(address checkAddress) public view returns(bool) {
        return physicians.has(checkAddress);
    }

    // Check if Address Belongs to a User
    function isUser(address checkAddress) public view returns(bool) {
        return users.has(checkAddress);
    }

    // Register a User
    function registerUser(address userAddress) public onlyAdmin {
        users.add(userAddress);
        userIDs.push(userAddress);
    }

    // Add User Information
    function addUserData(address userAddress, string memory dataHash) public onlyAdmin {
        User storage user = userData[userAddress];
        user.userDataHash = dataHash;
    }

    // Retrieve User Information
    function getUserData(address userAddress) public view returns(string memory) {
        return userData[userAddress].userDataHash;
    }

    // Add Medical Record
    function addMedicalRecord(address userAddress, string memory recordHash) public onlyPhysician {
        MedicalRecord storage record = medicalRecords[userAddress];
        record.recordDataHash = recordHash;
        recordDataHashes.push(recordHash);
    }

    // View Medical Record
    function viewMedicalRecord(address userAddress) public view returns(string memory) {
        return medicalRecords[userAddress].recordDataHash;
    }

    /*
        Modifiers for Role-based Access Control
    */

    modifier onlyAdmin() {
        require(admins.has(msg.sender), "Action restricted to admin");
        _;
    }

    modifier onlyPhysician() {
        require(physicians.has(msg.sender), "Action restricted to physicians");
        _;
    }

    modifier onlyUser() {
        require(users.has(msg.sender), "Action restricted to users");
        _;
    }
}
