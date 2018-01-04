pragma solidity 0.4.19;

import "github.com/ethereum/solidity/std/mortal.sol";

contract MyContract is mortal {
    address creator;
    uint myNumber;
    
    function MyContract() public {
        creator = msg.sender;
        myVariable = 5;
    }

    function getCreator() public constant returns(address) {
        return creator;
    }
    
    function setMyNumber(uint myNewNumber) public {
        myVariable = myNewVariable;
    }
 
    function getMyNumber() public constant returns(uint) {
        return myVariable;
    }
}