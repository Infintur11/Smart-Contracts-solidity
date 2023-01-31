pragma solidity ^0.8.15;

contract SendToAddress{
    string public mystring;
    address payable public acc1=payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);//put the specified address you want to send eth in

    function set(string memory _mystring) public payable {
       if (msg.value==1 ether) {
           mystring=_mystring;
       }
       else{
           payable(acc1).transfer(msg.value);
       }
    }
}//here a example of sending your ether to a predefined account so that if any error occur you can send it
