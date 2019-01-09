pragma solidity ^0.5.0;

contract owned {
    address public owner;

    constructor () public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract Election is owned {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    event VoteTracker(uint id, uint tally);

    constructor () public {
        addCandidate("Anthony Applegate");
        addCandidate("Barbara Bananahammock");
    }

    function addCandidate(string memory _name) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function addOwnerCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function incrementVote(uint _id, uint _inc) public {
        candidates[_id].voteCount = candidates[_id].voteCount + _inc;
        emit VoteTracker(_id, candidates[_id].voteCount);
    }
}
