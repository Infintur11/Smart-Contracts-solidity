pragma solidity ^0.6.0;

contract Messenger{
    address owner;
    string public message = "We want dhoni back";//message variables 
    int public count = 0;//count the variable change

    constructor() public {
        owner = msg.sender;//it set the owner once it deploys the contract
    }
    modifier ownable() {
        require(msg.sender == owner, "Be owner please:)");//once onwer comes he can only change else it will show the message
        _;
    }

    function ChangeMessage(string memory _message) ownable() public {
        message = _message;//the way of changing the message
        count++;//counting the number of types messages changed
    }
}
