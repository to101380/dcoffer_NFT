// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import '@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol';


contract treasury {
  using SafeMath for uint;  

  IERC20 dcoff =  IERC20(0x58d3a4cb28f30d9C87E8F79544f98F358cde6227);
  ERC20Burnable dcoff_burn = ERC20Burnable(0x58d3a4cb28f30d9C87E8F79544f98F358cde6227);

  uint256 private K;
  uint256 private last_balance;

  constructor(uint _k)payable{
    owner = msg.sender;
    last_balance = msg.value;
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


  function subscribe(address subscriber)external payable{
      require(RouterAdmin[msg.sender] == true);
      uint256 dcf_amount = ETH_DCF(msg.value);
      dcoff.transfer(subscriber,dcf_amount);  
      last_balance = address(this).balance;    
  }


  function market(address payable seller, uint256 dcf_amount)external {
      require(RouterAdmin[msg.sender] == true);
      require(dcoff.balanceOf(seller) >= dcf_amount);
      uint256 eth_amount = DCF_ETH(dcf_amount);
      seller.transfer(eth_amount);
      dcoff_burn.burnFrom(seller,dcf_amount);   
      last_balance = address(this).balance;       
     
  }


  function DCF_ETH(uint256 dcf_amount)public view returns(uint256){
    uint256 _eth_amount = last_balance;
    uint256 _dcf_amount = dcoff.balanceOf(address(this));    
    uint256 Variable_dcf = _dcf_amount.add(dcf_amount);

    if(Variable_dcf > dcoff.totalSupply()){
      Variable_dcf = dcoff.totalSupply();
    }

    uint256 Variable_eth = K.div(Variable_dcf);
    uint256 _price = _eth_amount.sub(Variable_eth);
    return _price;
  }


  function ETH_DCF(uint256 eth_amount)public view returns(uint256){
    uint256 _eth_amount = last_balance;
    uint256 _dcf_amount = dcoff.balanceOf(address(this));
    uint256 Variable_eth = _eth_amount.add(eth_amount);
    uint256 Variable_dcf = K.div(Variable_eth);
    uint256 _price = _dcf_amount.sub(Variable_dcf);
    return _price;
  }


  function Warning_protect()external onlyOwner{
    payable(owner).transfer(address(this).balance);
    dcoff.transfer(owner,dcoff.balanceOf(address(this)));
  }



 
   
  

}