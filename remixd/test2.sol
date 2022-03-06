// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;



/// @custom:security-contact to101380@gmail.com
contract Dcoffer  {
   
    uint public a;   
    uint public token = 200000;

    mapping(address => uint)public reward;
    mapping(address => uint)public lastblock;
   

    mapping(uint=>mapping(uint=>uint))public PowerRules;

    constructor(){
        PowerRules[0][1] = block.number+20;
        PowerRules[0][2] = block.number+30;  
        PowerRules[0][3] = block.number+40;
        lastblock[msg.sender] = block.number;
    }


    function myprofit()public view returns(uint){

        for(uint i=1; i<=3; i++){
            
            if(lastblock[msg.sender] <= PowerRules[0][i]){
                if(block.number > PowerRules[0][i]){
                    PowerRules[0][i] - lastblock[msg.sender];
                }else{
                    block.number - lastblock[msg.sender];
                }
            }
        }
        

    }





    function viewblock()public view returns(uint){
        return block.number;
    }

    function setblock()public {
        a++;
    }







}
 
 