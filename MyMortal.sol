pragma solidity ^0.4.19;

contract Mortal {
    address owner;
    
    modifier onlyowner() {
        if (owner == msg.sender) {
            _;    
        } else {
            revert();
        }
    }
    
    function Mortal() public {
        owner = msg.sender;
    }
    
    function kill() public onlyowner {
        selfdestruct(owner);        
    }
}