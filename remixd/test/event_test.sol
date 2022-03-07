// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;



/// @custom:security-contact to101380@gmail.com
contract Dcoffer  {
   
    
    uint public token_amount;
    uint public mytoken;

    event _price(uint time , uint price);

    constructor(){        
        mytoken = 10000e18;
        token_amount = 10000e18;
    }


    function get_price()public payable{        
        uint price = view_price();
        emit _price(block.timestamp,price);
       
    }

    function view_price()public view returns(uint){
        uint coffer = (address(this)).balance;
        uint price = uint(1e18)*coffer/token_amount;      
        return price;
    }

    




}
 
 