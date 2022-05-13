// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A/ERC721A.sol";


contract Dcoffer is ERC721A {
  using SafeMath for uint;

  constructor() ERC721A("Dcoffer", "Dcoffer") {}

   address owner;

   modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

  

  mapping(uint256 => mapping(uint256 => uint256))private info;
  // [0][1] mint price (wei)
  

  function mint(uint256 quantity) external payable {
    uint price = quantity.mul(info[0][1]);
    require(msg.value >= price);  
    _safeMint(msg.sender, quantity);
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




  

}