// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Election {
    // Structure to represent a citizen
    struct Citizen {
        uint256 id; // Unique identifier for the citizen
        bool isVoted; // Indicates if the citizen has voted
    }

    // Structure to represent a candidate
    struct Candidate {
        uint256 citizenId; // Citizen ID of the candidate
        uint256 voteCount; // Number of votes received by the candidate
    }

    // Mappings to store candidates and citizens
    mapping(uint256 => Candidate) candidateList; // Maps candidate ID to Candidate struct
    mapping(uint256 => Citizen) citizenList; // Maps citizen ID to Citizen struct
    bool isElectionAvailable; // Indicates if the election is available

    // Function to create a new citizen
    function createCitizen(uint256 _id) public returns (uint256) {
        // Check if the citizen ID already exists
        require(citizenList[_id].id == 0, "Please enter a valid ID number");
        Citizen memory _tempCitizen = Citizen(_id, false); // Create a new citizen
        citizenList[_id] = _tempCitizen; // Store the citizen in the mapping
        return _id; // Return the ID of the created citizen
    }

    // Function to get details of a citizen by ID
    function getCitizen(uint256 _id) public view returns (Citizen memory) {
        return citizenList[_id]; // Return the citizen struct
    }

    // Function to create a new candidate
    function createCandidate(uint256 _id) public returns (uint256) {
        // Check if the candidate ID already exists
        require(candidateList[_id].citizenId == 0, "Candidate with this ID already exists");
        Candidate memory _tempCandidate = Candidate(_id, 0); // Create a new candidate
        candidateList[_id] = _tempCandidate; // Store the candidate in the mapping
        return _id; // Return the ID of the created candidate
    }

    // Function to get details of a candidate by ID
    function getCandidate(uint256 _id) public view returns (Candidate memory) {
        return candidateList[_id]; // Return the candidate struct
    }

    // Function to get the vote count of a candidate by ID
    function getCandidateVoteCount(uint256 _id) public view returns (uint256) {
        return candidateList[_id].voteCount; // Return the vote count
    }

    // Function to allow a citizen to vote for a candidate
    function vote(uint256 _citizenId, uint256 _candidateId) public returns (uint256, uint256) {
        // Check if the election is available
        require(isElectionAvailable, "Election is not available at this time");
        // Check if the citizen has already voted
        require(!citizenList[_citizenId].isVoted, "This citizen has already voted");
        // Increase the vote count for the candidate
        candidateList[_candidateId].voteCount += 1;
        // Mark the citizen as having voted
        citizenList[_citizenId].isVoted = true;
        return (_citizenId, _candidateId); // Return the IDs of the citizen and candidate
    }

    // Function to start or stop the election
    function toggleElectionAvailability() public {
        isElectionAvailable = !isElectionAvailable; // Toggle the election availability status
    }
}
