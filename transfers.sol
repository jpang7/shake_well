pragma solidity ^0.4.19;

import "./ownership.sol";
import "./erc721.sol";
import "./safemath.sol";

contract Transfers is Ownership, ERC721 {

    using SafeMath for uint256;

    struct Offer {
        bool isForSale;
        uint itemId;
        address seller;
        uint value; //In Ether
        address onlySellTo; //Sell only to a specific person if specified
    }

    mapping (uint => address) itemApprovals;
    mapping (uint => Offer) public itemsOfferedForSale;
    mapping (address => uint) public pendingWithdrawals;

    function withdraw() {
        uint256 amount = pendingWithdrawals[msg.sender];
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }

    function offerItem(uint256 _itemId, uint _salePriceInWei) {
        require(itemToOwner[_itemId] == msg.sender);
        itemsOfferedForSale[_itemId] = Offer(true, _itemId, msg.sender, salePriceInWei, 0x0);
    }

    function offerItemToAddress(uint256 _itemId, uint _salePriceInWei, address _to) {
        require(itemToOwner[_itemId] == msg.sender);
        itemsOfferedForSale[_itemId] == Offer(true, _itemId, msg.sender, salePriceInWei, _to);
    }

    function buyItem(uint256 _itemId) {
        Offer offer = itemsOfferedForSale[_itemId];
        require(offer.isForSale); 
        require(offer.onlySellTo == 0x0 || offer.onlySellTo == msg.sender);
        require(msg.value == offer.value);
        require(offer.seller == itemToOwner[_itemId]);

        address seller = offer.seller;

        itemToOwner[_itemId] = msg.sender;
        ownerItemCount[seller].sub(1);
        ownerItemCount[msg.sender].add(1);
        _transfer(seller, msg.sender, _itemId);
        itemsOfferedForSale[_itemId] = Offer(false, _itemId, msg.sender, 0, 0x0);
        pendingWithdrawals[seller].add(msg.value);
        
    }

    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerItemCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return itemToOwner[_tokenId];
    }

    function transfer(address _to, uint256 _tokenId) public {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        itemApprovals[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerItemCount[_to] = ownerItemCount[_to].add(1);
        ownerItemCount[msg.sender] = ownerItemCount[msg.sender].sub(1);
        itemToOwner[_tokenId] = _to;
        Transfer(_from, _to, _tokenId);
    }
}