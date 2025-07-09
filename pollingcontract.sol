// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollingSystem {

    struct Poll {
        string title;
        string[] options;
        uint endTime;
        // mappings cannot be in memory structs, so we keep them outside
    }

    mapping(uint => Poll) public polls;
    mapping(uint => mapping(uint => uint)) public voteCount; // pollId => optionIndex => votes
    mapping(uint => mapping(address => bool)) public hasVoted; // pollId => voter => voted

    uint public pollCount;

    function createPoll(string memory _title, string[] memory _options, uint _duration) public {
        polls[pollCount] = Poll(_title, _options, block.timestamp + _duration);
        pollCount++;
    }

    function vote(uint pollId, uint optionIndex) public {
        require(pollId < pollCount, "Invalid poll");
        Poll storage poll = polls[pollId];
        require(block.timestamp < poll.endTime, "Poll ended");
        require(!hasVoted[pollId][msg.sender], "Already voted");
        require(optionIndex < poll.options.length, "Invalid option");
        voteCount[pollId][optionIndex]++;
        hasVoted[pollId][msg.sender] = true;
    }

    function electedWinner(uint pollId) public view returns (string memory winner) {
        require(pollId < pollCount, "Invalid poll");
        Poll storage poll = polls[pollId];
        require(block.timestamp >= poll.endTime, "Poll not ended");

        uint winningVoteCount = 0;
        uint winningOption = 0;

        for (uint i = 0; i < poll.options.length; i++) {
            if (voteCount[pollId][i] > winningVoteCount) {
                winningVoteCount = voteCount[pollId][i];
                winningOption = i;
            }
        }
        return poll.options[winningOption];
    }
}




//["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db","0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"]