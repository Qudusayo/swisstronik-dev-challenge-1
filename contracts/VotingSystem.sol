/// @title VotingSystem
/// @author Qudusayo
/// @notice This contract allows registered users to vote for or against a proposals.
/// @dev This contract manages voting for or against a proposals and keeps track of registered voters.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract VotingSystem {
    address private owner;
    uint256 private voteFor;
    uint256 private voteAgainst;

    struct Voter {
        bool isRegistered;
        bool hasVoted;
    }

    mapping(address => Voter) private voters;
    
    /// @dev Initializes the contract with the provided owner's address.
    constructor() {
        owner = msg.sender;
    }
    
    /// @dev Modifier: Ensures that only the owner can execute certain functions.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    /// @dev Modifier: Ensures that only registered voters can execute certain functions.
    modifier onlyRegisteredVoter() {
        require(voters[msg.sender].isRegistered, "Only registered voters can call this function");
        _;
    }
    
    /// @notice Registers a voter.
    /// @dev Only the owner can register voters, and a voter can only be registered once.
    /// @param _voterAddress The address of the voter to be registered.
    function registerVoter(address _voterAddress) public onlyOwner {
         require(!voters[_voterAddress].isRegistered, "Voter is already registered");
        voters[_voterAddress].isRegistered = true;
    }
    
    /// @notice Allows a registered voter to cast their vote.
    /// @dev Only registered voters can vote, and each voter can vote only once.
    /// @param _vote The voter's choice (true for yes, false for no).
    function vote(bool _vote) public onlyRegisteredVoter {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        if (_vote) {
            voteFor++;
        } else {
            voteAgainst++;
        }
        voters[msg.sender].hasVoted = true;
    }
    
    /// @notice Gets the current vote count (yes and no votes).
    /// @return A tuple containing the number of yes votes and no votes.
    function getVoteCount() public view returns(uint256, uint256) {
        return (voteFor, voteAgainst);
    }
}
