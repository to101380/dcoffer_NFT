// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Dcoffer is ERC721A {
  constructor() ERC721A("Dcoffer", "Dcoffer") {}

  function mint(uint256 quantity) external payable {
    // _safeMint's second argument now takes in a quantity, not a tokenId.
    _safeMint(msg.sender, quantity);
  }
}