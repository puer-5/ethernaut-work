// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract dev {
    function recovery(address _target) external pure returns(address) {
       address addr = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), _target, bytes1(0x01))))));

     return addr;
    }
}
// 0x44Ff37D982B6f2B566bCC7159aD7B72aD9690A76
// 0x44Ff37D982B6f2B566bCC7159aD7B72aD9690A76
contract Recovery {
    //generate tokens
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {
    string public name;
    mapping(address => uint256) public balances;

    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    // allow transfers of tokens
    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}