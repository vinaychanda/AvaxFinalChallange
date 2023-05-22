// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    
    mapping(address => uint256) public tokenBalances;
    mapping(address => bool) public hasRedeemed;

    struct Item {
        string name;
        uint256 price;
    }

    Item[] public items;

    constructor() ERC20("Degen", "DGN") {       
        items.push(Item("Item A", 70));
        items.push(Item("Item B", 100));
        items.push(Item("Item C", 150));
        }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(_msgSender()) >= amount, "Insufficient balance");
        
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function redeem(uint256 itemId ) public {
        require(itemId >= 0 && itemId < items.length, "Invalid item ID");
        require(!hasRedeemed[msg.sender], "Already redeemed");

        
        Item memory item = items[itemId];
        uint256 price = item.price;

        require(balanceOf(_msgSender()) >=price, "Insufficient balance");
        
        _burn(_msgSender(), price);
    }

    function burn(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(_msgSender()) >= amount, "Insufficient balance");
        
        _burn(_msgSender(), amount);
    }

    function balanceOf(address account) public view override returns (uint256) {
        return super.balanceOf(account);
    }
}
