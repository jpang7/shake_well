# shake_well
## An Ethereum adventure. Buy and sell items you earn in-game!
Still under development. Smart contract (including marketplace, item creation) logic **almost completed**, needs further review.\
What does an item look like? They are ERC721 tokens (struct Item) with a:
- name (e.g. leatherboot10340130, ironwings3520113) consists of char/letter values that correspond to images in the UI and numerical values that distinguish one item from another (e.g. leatherboot1 vs leatherboot2)
- strength level (items can wear down over time. Every item once picked up starts at 100 strength. Can repair at a price that I set and restore the strength to 100.)
- id (basically the index number in Item array items.)

**TODO: Deploy smart contract after more review. Add author only methods if needed.**\
Basic methods including buy, offerItem, 

**TODO: Connect frontend to smart contract**


**TODO: Organize file structure**

Original artwork by Jonathan Pang
