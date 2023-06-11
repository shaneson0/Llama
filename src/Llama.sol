// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract Llama is Ownable, ERC20 {
    
    address pool;

    // address => blocknumber:amount
    mapping(address => uint) hashmap;
    
    constructor(uint256 _totalSupply) ERC20("Llama", "LLAMA") {
        _mint(msg.sender, _totalSupply);
    }

    function burn(uint256 value) external {
        _burn(msg.sender, value);
    }

    function changepool(address newPool) public onlyOwner {
        pool = newPool;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 
    ) internal override {
        if (from == pool || to == pool ) {
            require(hashmap[tx.origin] != block.number, "Detect MEV!");
        }
    }

    // aggregator => user 
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 
    ) internal override {
        if (from == pool || to == pool) {
            hashmap[tx.origin] =  block.number;
        }
    }

}