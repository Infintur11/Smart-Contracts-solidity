pragma solidity ^0.6.0;

contract Token{
    address public owner;
    mapping(address => uint) public tokenbalance;
    event SentToken(address from, address to, uint amount);
    constructor() public{
        owner = msg.sender;
        tokenbalance[owner] = 100;
    }
    function sentToken(address _to, uint _amount) public returns(bool){
        require(msg.sender == owner, "You are not the owner");
        tokenbalance[_to] += _amount;
        tokenbalance[msg.sender] -= _amount;
        emit SentToken(msg.sender, _to, _amount);
        return true;
    }
}
