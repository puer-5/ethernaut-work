// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Token {
    function transfer(address _to, uint256 _value) external  returns (bool);
}
   
contract attrack{
    mapping(address => uint256) balances;
     uint256 values;
    constructor(uint256 Supply) public {
        balances[msg.sender] = Supply = values;
    }
    
   
    address _to=0xEd9CFc29FAbaB3dd27F87818c266fFD4f0ca5d5f;
    Token t =Token(0xEd9CFc29FAbaB3dd27F87818c266fFD4f0ca5d5f);
    function add() public {
         t.transfer( _to,values);
    }
   
    

}