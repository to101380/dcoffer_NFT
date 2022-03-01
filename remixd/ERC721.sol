// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";



/// @custom:security-contact to101380@gmail.com
contract Dcoffer is ERC721, ERC721URIStorage, ERC721Burnable, Ownable, IERC721Receiver{
    using SafeMath for uint;
    using Counters for Counters.Counter;

    mapping(address=>bool)licence;
    mapping(uint=>uint)dcofferPower;

    uint constant totalSupply = 13122;


    Counters.Counter private _tokenIdCounter;

    

    constructor() ERC721("Dcoffer", "Dcoffer") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/QmT6PrxRmwfjnrAZdX57q8WcNovCAh7hGWBcyXDZjRPUPM/";
    }

    function safeMint(address to) public {  
        require(licence[msg.sender] == true);

        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId < totalSupply);

        

        string memory file = ".json";         
        string memory id = Strings.toString(tokenId);
        string memory tokenIdFile = string(abi.encodePacked(id,file));
        set_power(to,tokenId);

        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenIdFile);
    }


    function set_power(address user, uint tokenId)private {       
        bytes32 random = keccak256(abi.encodePacked(user,tokenId,block.timestamp,block.number,block.difficulty));
        uint power =uint(random).mod(10);

        if(power == 0){
            power = power.add(1);
        }

        dcofferPower[tokenId] = power;
    }


     /**
     * Always returns `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }


    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {          
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function _license(address user, bool admin)external onlyOwner{
        licence[user] = admin;
    }

    function check_license(address user)external view returns(bool){
        return licence[user];
    }

    function MaxTotalSupply()external pure returns(uint){
        return totalSupply;
    }

    function minePower(uint tokenId)external view returns(uint){
        return dcofferPower[tokenId];
    }
}
 
 