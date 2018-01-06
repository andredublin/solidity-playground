pragma solidity 0.4.19;

import "github.com/ethereum/solidity/std/mortal.sol";

contract MyWallet is mortal {
    event EventReceivedFunds(address indexed from, string reason);
    event EventProposalReceived(address indexed from, address indexed to, string reason);

    struct Proposal {
        address from;
        address to;
        uint256 value;
        string reason;
        bool sent;
    }

    uint proposalCounter;

    mapping (uint => Proposal) proposals;

    function() public payable {
        if (msg.value > 0)
            receivedFunds(msg.sender, msg.value);
    }

    function spendMoneyOn(address to, uint256 value, string reason) public returns (uint256) {
        if (owner == msg.sender) {
            require(to.send(value));
        } else {
            proposalCounter++;
            proposals[proposalCounter] = Proposal(msg.sender, to, value, reason, false);
            EventProposalReceived(msg.sender, to, reason);
            return proposalCounter;
        }
    }

    function confirmProposal(uint proposalId) public onlyowner returns (bool) {
        Proposal proposal = proposals[proposalId];
        if (proposal.from != address(0)) {
            if (!proposal.sent) {
                proposal.sent = true;
                
                
                if (proposal.to.send(proposal.value)) {
                    return true;
                }
                
                proposal.sent = false;
                return false;
            }
        }
    }
}