pragma solidity ^0.6.0;

contract Messenger{
    address owner;
    string public message = "We want dhoni back";
    int public count = 0;

    constructor() public {
        owner = msg.sender;
    }
    modifier ownable() {
        require(msg.sender == owner, "Be owner please:)");
        _;
    }

    function ChangeMessage(string memory _message) ownable() public {
        message = _message;
        count++;
    }
}
