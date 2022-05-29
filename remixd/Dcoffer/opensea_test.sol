// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A/ERC721A.sol";



contract Dcoffer is ERC721A {
  using SafeMath for uint;



  constructor()ERC721A("Dcoffer", "Dcoffer",10000) {
    
  }



  mapping(uint256 => mapping(uint256 => uint256))private info;

  
 
  function mint(uint256 quantity) external { 
    _safeMint(msg.sender, quantity);
 
  }


  

}