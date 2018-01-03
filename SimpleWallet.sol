pragma solidity ^0.4.19;

import "github.com/ethereum/solidity/std/mortal.sol";

contract SimpleWallet is mortal {
    
    mapping(address => Permission) permittedAddresses;
    
    event EventAddToSendersList(address added, address sender, uint maxTransferAmount);
    event EventRemoveFromSendersList(address removed, address sender);
    event EventSendFunds(address receiver, address sender, uint amount);

    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }
    
    function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyowner {
        permittedAddresses[permitted] = Permission(true, maxTransferAmount);
        EventAddToSendersList(permitted, msg.sender, maxTransferAmount);
    }

    function removeAddressFromSendersList(address remove) public onlyowner {
        delete permittedAddresses[remove];
        EventRemoveFromSendersList(remove, msg.sender);
    }

    function sendFunds(address receiver, uint amountInWei) public {
        require(permittedAddresses[msg.sender].isAllowed);
        require(permittedAddresses[msg.sender].maxTransferAmount >= amountInWei);
        
        bool isTheAmountReallySent = receiver.send(amountInWei);
        require(isTheAmountReallySent);
        EventSendFunds(receiver, msg.sender, amountInWei);
    }

    function () public payable {
        
    }
}