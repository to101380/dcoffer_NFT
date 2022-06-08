// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A/ERC721A.sol";



contract Dcoffer is ERC721A {
  using SafeMath for uint;



  constructor()ERC721A("Dcoffer", "Dcoffer") {
    
  }

 
  function mint(uint256 quantity) external { 
    _safeMint(msg.sender, quantity);
 
  }


  

}