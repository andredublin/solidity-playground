pragma solidity 0.4.19;

import "github.com/ethereum/solidity/std/mortal.sol";

contract MyContract is mortal {
    uint myVariable;
    
    function MyContract() public payable {
        myVariable = 5;
    }
    
    function setMyVariable(uint myNewVariable) public onlyowner {
        myVariable = myNewVariable;
    }
 
    function getMyVariable() public constant returns(uint) {
        return myVariable;
    }
    
    function getMyContractBalance() public constant returns(uint) {
        return this.balance;
    }
    
    function () public payable {
        
    }
}