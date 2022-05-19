// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';


contract treasury  {
  using SafeMath for uint;  

  IERC20 dcoff =  IERC20(0xbE0C856e2981b9f03d7613566DFC6679eEe4708A);

  uint256 private K;

  constructor(uint _k){
    owner = msg.sender;
    K = _k;
  }

  address owner;
  mapping(address => bool)private RouterAdmin;

  modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
  }


  





  function setRouter(address user, bool power)external onlyOwner{
    RouterAdmin[user] = power;
  }


  function DcfPrice(uint256 dcf_amount)public view returns(uint){
    uint256 _eth_amount = address(this).balance;
    uint256 _dcf_amount = dcoff.balanceOf(address(this));
    uint256 Variable_dcf = _dcf_amount.add(dcf_amount);
    uint256 Variable_eth = K.div(Variable_dcf);
    uint256 _price = _eth_amount.sub(Variable_eth);
    return _price;
  }



 
   
  

}