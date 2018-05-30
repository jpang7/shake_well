pragma solidity ^0.4.19;

import "./earn.sol";

contract ItemOwnership is Earn {

    uint repairFee = 0.001 ether;

    function withdraw() external onlyOwner {
        owner.transfer(this.balance);
    }

    function setRepairFee(uint _fee) external onlyOwner {
        repairFee = _fee;
    }

    function repair(uint _itemId) external payable {
        require(msg.value == repairFee);
        items[_itemId].strength = 100;
    }

    function getItemsByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerItemCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < items.length; i++) {
            if (itemToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}