// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/**
 * @title AccessControl
 * @dev Library for managing role-based access control with unique account assignments.
 */
library AccessControl {
    struct RoleGroup {
        mapping(address => bool) members;
    }

    /**
     * @dev Assign an account to this role group.
     */
    function assign(RoleGroup storage roleGroup, address account) internal {
        require(!isMember(roleGroup, account), "AccessControl: Account already assigned");
        roleGroup.members[account] = true;
    }

    /**
     * @dev Revoke an account's membership from this role group.
     */
    function revoke(RoleGroup storage roleGroup, address account) internal {
        require(isMember(roleGroup, account), "AccessControl: Account not a member");
        roleGroup.members[account] = false;
    }

    /**
     * @dev Check if an account is a member of this role group.
     * @return bool
     */
    function isMember(RoleGroup storage roleGroup, address account) internal view returns (bool) {
        require(account != address(0), "AccessControl: Invalid zero address");
        return roleGroup.members[account];
    }
}
