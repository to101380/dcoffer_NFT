// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import './IDCF/IDCF.sol';

contract treasury  {
  using SafeMath for uint;  
  IDCF mine = IDCF(0x6a544367FCa7064B6ADA5dc87F7E5058A9bB7Af9);
  IERC20 dcoff =  IERC20(0xbE0C856e2981b9f03d7613566DFC6679eEe4708A);

  uint256 DcoffperBlock;  
  mapping(address => uint256 )private ScoreWithdrawn;

  constructor(){
    DcoffperBlock = 2e14;
  }


  function MineDcoff()external{      
      uint256 GetDCF = mineStatus(msg.sender);
      dcoff.transfer(msg.sender,GetDCF);

      uint256 afterScore = Score(msg.sender);
      ScoreWithdrawn[msg.sender] = ScoreWithdrawn[msg.sender].add(afterScore);
  }  

  function Score(address user)internal view returns(uint256){
      uint256 _Score = mine.BlockScore(user);
      uint256 afterScore = _Score.sub(ScoreWithdrawn[user]);
      return afterScore;
  } 

  function mineStatus(address user)public view returns(uint256){
      uint256 afterScore = Score(user);
      uint256 GetDCF = afterScore.mul(DcoffperBlock);
      return GetDCF;
  }

   
  

}