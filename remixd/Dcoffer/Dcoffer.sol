// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A/ERC721A.sol";


interface _treasury{
  function subscribe(address subscriber)external payable;  
}


contract Dcoffer is ERC721A {
  using SafeMath for uint;

  _treasury treasuryCtrl = _treasury(0x063243b32833d9398Fb2186d900bbdAa2A05326D);

  constructor(uint256 _price, uint256 _admin_fee)ERC721A("Dcoffer", "Dcoffer",10000) {
    info[0][1] = _price;
    info[0][2] = _admin_fee;
  }

   address owner;
   uint256 admin;

   modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

  

  mapping(uint256 => mapping(uint256 => uint256))private info;
  // [0][1] mint price (wei)
  // [0][2] admin_fee_rate
  
 
  function mint(uint256 quantity) external payable {   
    uint price = quantity.mul(info[0][1]);
    require(msg.value >= price);  
    _safeMint(msg.sender, quantity);

    uint256 fee = msg.value.mul(info[0][2]).div(1000);
    admin = admin.add(fee);

    uint256 payment = msg.value.sub(fee);
    treasuryCtrl.subscribe{value: payment}(address(this)); 
  }


  function burn(uint256 tokenId) external  {
      _burn(tokenId);
  }  


  function setInfo(uint256 paramA, uint256 paramB, uint256 paramC)external onlyOwner{
    info[paramA][paramB]=paramC;
  }

  function ViewInfo(uint256 paramA, uint256 paramB)external view returns(uint256)  {
    return info[paramA][paramB];
  }


  function admin_fee()external onlyOwner{
    payable(owner).transfer(admin);
    admin = 0; 
  }

  function viewAdminFee()external onlyOwner view returns(uint256){
    if(owner == msg.sender){
      return admin;
    }else{
      revert();
    }
  }





  

}