pragma  solidity ^0.5.13;

contract s{
    mapping(address=>uint) public balanceRecived;
    function get() public view returns(uint){
        return address(this).balance;//this tells total money in smart contract
    }
    function sendmoney() public payable{
        balanceRecived[msg.sender]+=msg.value;//this tells moeny on each address from where smart contract is deployed
    }
    function partialwithd(address payable ad,uint amoun) public{
        require(balanceRecived[msg.sender]>=amoun,"Nigga need money");/*this check if amount exists or not*/
        balanceRecived[msg.sender]-=amoun;/*reducts the money from the address*/
        ad.transfer(amoun);/*transfers moeny from smart contract to that address
        need to give ethers in 18 power to make this happen*/
    }

    /*this below function is to transfer all money
    function withdraw(address payable a) public{
        uint balanceToSend=balanceRecived[msg.sender];//here we are sending all moeny
        balanceRecived[msg.sender]=0;//this line make intial balance zero back
        a.transfer(balanceToSend);
    } */
//also here from wherever address money is transferred from that account only we can withdraw or do operation
    
}
/*mapping stores the values in form of key-value structure
Example:
key     value
address balance  
