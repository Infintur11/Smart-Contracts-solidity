pragma solidity ^0.8.0;

contract lottery{
   address public manager;
   address payable[] public participants;

   constructor(){
       manager = msg.sender; 
   }

   receive() external payable{
       require(msg.value==1 ether);
       participants.push(payable(msg.sender));
   }//to take ether in this contract

   function getBalance() public view returns(uint){
       require(msg.sender == manager);
       return address(this).balance;
   }

   function random() public view returns(uint){
      return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
   }

   function selectWinner() public{
       require(msg.sender == manager);
       require(participants.length>=3);
       uint r = random();
       uint index = r % participants.length;
       participants[index].transfer(getBalance());
       participants = new address payable[](0);
   }
}
