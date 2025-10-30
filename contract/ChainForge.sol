// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title ChainForge - Decentralized Project Registry
/// @notice Allows users to create, update, and retrieve projects on-chain.
/// @dev Demonstrates simple data storage and ownership control in Solidity.
contract ChainForge {
    // Data structure to store project details
    struct Project {
        uint256 id;
        string name;
        string description;
        address owner;
        bool isActive;
    }

    uint256 private nextProjectId;
    mapping(uint256 => Project) private projects;

    // Events for logging actions
    event ProjectCreated(uint256 indexed projectId, string name, address indexed owner);
    event ProjectUpdated(uint256 indexed projectId, string name, bool isActive);

    /// @notice Create a new project entry
    /// @param name Name of the project
    /// @param description Description of the project
    function createProject(string memory name, string memory description) external {
        uint256 projectId = nextProjectId++;
        projects[projectId] = Project({
            id: projectId,
            name: name,
            description: description,
            owner: msg.sender,
            isActive: true
        });
        emit ProjectCreated(projectId, name, msg.sender);
    }

    /// @notice Update project name or activation status
    /// @param projectId ID of the project to update
    /// @param name New name of the project
    /// @param isActive Updated active status
    function updateProject(uint256 projectId, string memory name, bool isActive) external {
        Project storage project = projects[projectId];
        require(project.owner == msg.sender, "Only project owner can update");
        project.name = name;
        project.isActive = isActive;

        emit ProjectUpdated(projectId, name, isActive);
    }

    /// @notice Retrieve project details by ID
    /// @param projectId ID of the project
    /// @return Project struct with details
    function viewProject(uint256 projectId) external view returns (Project memory) {
        return projects[projectId];
    }
}
