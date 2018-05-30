pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";

contract Earn is Ownable {

    using SafeMath for uint256;

    event NewItem(uint itemId, string name, uint mix);

    struct Item {
        string name;
        uint mix;
        uint strength;
    }

    Item[] public items;

    mapping (uint => address) public itemToOwner;
    mapping (address => uint) ownerItemCount;

    modifier onlyOwnerOf(uint _itemId) {
        require(msg.sender == itemToOwner[_itemId]);
        _;
    }

    //TODO DECIDE HOW CREATE ITEM IS GOING TO GO
    function createItem(string _name, uint _mix, uint _strength) internal {
        uint id = items.push(Item(_name, _mix, _strength));
        itemToOwner[id] = msg.sender;
        ownerItemCount[msg.sender].add(1);
    }
}