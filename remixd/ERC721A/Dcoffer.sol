// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A.sol";


contract Dcoffer is ERC721A {
  using SafeMath for uint;

  constructor() ERC721A("Dcoffer", "Dcoffer") {
    info[0][1] = 5e16;
  }

  

  mapping(uint => mapping(uint => uint))private info;
  // [0][1] mint price (wei)
  

  function mint(uint256 quantity) external payable {
    uint price = quantity.mul(info[0][1]);
    require(msg.value >= price);
    // _safeMint's second argument now takes in a quantity, not a tokenId.
    _safeMint(msg.sender, quantity);
  }  

  

}