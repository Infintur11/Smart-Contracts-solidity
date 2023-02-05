// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract SmartWallet{

    address payable public owner;

    mapping(address => uint) public allowance;//this mapping tells about allowance to addresses
    mapping(address=>bool) public isAllowedtoSend;//it tells which accounts are allowed for transaction 

    mapping(address=>bool) public guardians;//these are the guardians who guard the account 
    address payable nextOwner;//this is next owner who should be new owner if minimum 3 guardians are allowed
    mapping(address=>mapping(address=>bool)) nextOwnerGuardianVotedBool;//this checks that for any next owner did any guardian voted or not
    uint guardiansResetCount;//to check guardians votes
    uint public constant confirmationsfromGuardiansForReset=3;//minimum number of guardians votes

    
    constructor(){
        owner=payable (msg.sender);//this sets the first address as owner who establish the smart contract 
    }

    function proposeNewOwner(address payable _newOwner) public{//this function assigns new owner
        require(guardians[msg.sender],"You are not guardian");//check if valid guardian came
        require(nextOwnerGuardianVotedBool[_newOwner][msg.sender]=false,"You voted buddy");//check if guardian pre voted for particular address
        if(_newOwner!=nextOwner){//if new owner is not next owner then set it and take count votes of guardians as 0
            nextOwner=_newOwner;
            guardiansResetCount=0;
        }
        guardiansResetCount++;//once valid guardian comes and press button vote is voted
        if(guardiansResetCount>=confirmationsfromGuardiansForReset){//once minimum criteria is met then owner is changed
            owner =nextOwner;
            nextOwner=payable(address(0));
        }
    }

    function setGuardian(address _guardian,bool _isguardian) public{//this function is seeting guardian only done by owner
        require(msg.sender==owner,"You are not the owner aborting");
        guardians[_guardian]=_isguardian;
    }

    function setAllowance(address _for,uint _amount) public{//this sets the allowance of any addressonly done by owne, owner gives some allowed moeny to any address
        require(msg.sender==owner,"You are not the owner aborting");
        allowance[_for] +=_amount;
        if(_amount>0){//if owner set the value more than zero then mapping will make that account true means it can carry further transactions
            isAllowedtoSend[_for]=true;
        }else{
            isAllowedtoSend[_for]=false;
        }
    }

    function transfer(address payable _to,uint _amount,bytes memory _payload)public returns(bytes memory){//this function checks the transfer to any other address if successful 
        if(msg.sender != owner){
            require(isAllowedtoSend[msg.sender],"You are not the allowed to send");
            require(allowance[msg.sender]>=_amount,"You are trying to send more than you are allowed to ,aborting");
            allowance[msg.sender]-=_amount;//here if message sender is not owner than if it is allowed to send and less than or equal to 
            //allowed account then the contract will proceed
        }
        (bool success,bytes memory returnData)=_to.call{value:_amount}(_payload);
        //the above line makes a call that if amount proceeds then it will returnData or show that call was not successful
        require(success,"Aborting call was not successful");
        return returnData;
    }

    receive() external payable{}//to send eth to our smart contract
}
