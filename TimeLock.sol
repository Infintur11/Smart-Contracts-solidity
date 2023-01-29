pragma solidity ^0.5.0;

contract time_lock{
    address payable beneficiary;
    uint rtime;

    constructor(address payable _beneficiary, uint _rtime) public payable{
        require(_rtime > block.timestamp);//here we fix when in future we have to withdraw
        beneficiary = _beneficiary;
        rtime = _rtime;
    }
    function release() public{
        require(rtime < block.timestamp);/*to remove money after given time*/
        address(beneficiary).transfer(address(this).balance);
    }
}
/*project done by keeping unix timestamp converter*/
