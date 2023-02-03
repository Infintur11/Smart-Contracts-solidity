pragma solidity 0.8.15;

contract MappingStructExample{
    struct Transaction{
        uint amount;
        uint timestamp;
    }
    struct  Balance{
        uint totalBalance;
        uint numDeposits;
        mapping(uint=>Transaction)  deposits;//for deposit function
        uint numWithdrawals;
        mapping(uint=>Transaction) withdrawls;//for withdrawl function
    }

    mapping(address=>Balance) public balances;

    function getDepositNum(address _from,uint _numDeposit)public view returns(Transaction memory){
        return balances[_from].deposits[_numDeposit];
    }

    function depositMoney() public payable{
        balances[msg.sender].totalBalance+= msg.value;
        Transaction memory deposit = Transaction(msg.value,block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].numDeposits]=deposit;//if any doubt check tree structure under to understand
        balances[msg.sender].numDeposits++;//if any doubt check tree structure under to understand
    }
    function withdraw(address payable _to,uint _amount)public{
        balances[msg.sender].totalBalance -= _amount;
        Transaction memory withdrawal = Transaction(_amount,block.timestamp);//if any doubt check tree structure under to understand
        balances[msg.sender].withdrawls[balances[msg.sender].numWithdrawals]=withdrawal;//if any doubt check tree structure under to understand
        balances[msg.sender].numWithdrawals++;//if any doubt check tree structure under to understand
    }
}

//         |-totalBalance
//         |-numdeposits                 |-amount
// balance-|-deposits------------|-uint--|-timestamp
//         |-numWithdrawals
//         |-withdrawals---------|-uint--|-amount
//                                       |-timestamp

// balances------------|-address------------------------|-totalBalance
//                                                      |-numdeposits
//                                                      |-deposits-------|-uint-|-amount
//                                                                              |-timestamp
//                                                      |-numWithdrawal
//                                                      |-Withdrawals----|-uint-|amount
//                                                                              |-timestamp 

//deposit--------|-msg.value
//               |-timestamp
