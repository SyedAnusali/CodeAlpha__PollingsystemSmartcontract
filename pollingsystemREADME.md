Polling System Smart Contract

The `PollingSystem` smart contract is a simple and efficient on-chain polling/voting system built with Solidity. It allows users to create polls with multiple options, vote on active polls, and determine the winning option after the poll ends.

 Features

- Create Polls: Any user can create a new poll by specifying a title, a list of options, and a duration (in seconds).
- Vote: Users can vote for their preferred option in any active poll. Each user can vote only once per poll.
- Automatic Poll End: Polls automatically end after the specified duration. Votes cannot be cast after the poll has ended.
- Winner Calculation: After a poll ends, anyone can query the contract to determine the winning option (the one with the most votes).

 Key Data Structures

- **Poll:** Contains the poll’s title, options, and end time.
- **voteCount:** Tracks the number of votes each option has received for each poll.
- **hasVoted:** Ensures that each address can only vote once per poll.

 Usage

1. Create a Poll:  
   Call `createPoll(string memory _title, string[] memory _options, uint _duration)` to create a new poll.

2. Vote:  
   Call `vote(uint pollId, uint optionIndex)` to vote for an option in an active poll.

3. Get Winner:  
   After the poll ends, call `electedWinner(uint pollId)` to get the winning option.
