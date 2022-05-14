// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import './IDCF/IDCF.sol';

contract treasury  {
  using SafeMath for uint;  
  IDCF mine = IDCF(0xbc1ADfF2EAC8dbA22d382DFADDf7e6B73aBC2334);
  IERC20 dcoff =  IERC20(0xbc1ADfF2EAC8dbA22d382DFADDf7e6B73aBC2334);

  uint256 DcoffperBlock;  
  mapping(address => uint256 )private ScoreWithdrawn;

  constructor(){
    DcoffperBlock = 2e14;
  }


  function MineDcoff()external{
      uint256 Score = mine.BlockScore(msg.sender);
      uint256 afterScore = Score.sub(ScoreWithdrawn[msg.sender]);
      uint256 GetDCF = afterScore.mul(DcoffperBlock);
      dcoff.transfer(msg.sender,GetDCF);
      ScoreWithdrawn[msg.sender] = ScoreWithdrawn[msg.sender].add(afterScore);
  }  


  

}