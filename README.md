# shake_well
## An Ethereum adventure. Buy and sell items you earn in-game!
Still under development. Smart contract (including marketplace, item creation) logic **almost completed**, needs further review.\
What does an item look like? They are ERC721 tokens (struct Item) with a:
- name (e.g. leatherboot10340130, ironwings3520113) consists of char/letter values that correspond to images in the UI and numerical values that distinguish one item from another (e.g. leatherboot1 vs leatherboot2)
- strength level (items can wear down over time. Every item once picked up starts at 100 strength. Can repair at a price that I set and restore the strength to 100.)
- id (basically the index number in Item array items.)

What is the game supposed to look like?
- Right now the "game" is an image you can control with the keyboard TODO: smoother keyboard listening
- Envisioned game description: platform style scroller with gravity. Earn items by completing quests and defeating computer enemies. Most valuable items are the rarest ones, likely the ones that will give your character special abilities (e.g. jumping higher, flying, having a pet, or moving to different game states. More advanced states will be more colorful, more "aesthetically interesting" experience) 
- Your items are EVERYTHING-- your items unlock new levels in the game, give you more power, and more aesthetic appeal.
- Implementation strategy: game.js will hold game logic AND UNIQUELY CALL smart contract method createItem. Again, there is no other way to create an item. Tokens are "minted" through gameplay. You can skip your in-game responsibilities through clever trading in the market or simply buying new items with your Ether. Cannot keep using primitive JavaScript methods-- will use a framework like Phaser
- THERE WILL BE A SYNC BUTTON (TODO)-- if the items you acquire in-game are created and recorded on the blockchain right when you pick them up, you will pay too much gas. Instead, the HTML5 game will record your in-game items. Your items will NOT be recorded on the chain until you press SYNC. 
- Exploiting this sync process will be very fun-- if you collect a new sword, you can SYNC, go crazy with it, even destroy it (replete its strength to zero) and it will still be on your chain with full strength if you don't SYNC again.

**This game's primary appeal is in its GAMEPLAY, while the opportunity to make money on the marketplace is likely a secondary source of fun**

**Much of the smart contract work is done. VERY VERY BASIC tests on Ropsten + RemixIDE (detailed below) were successful. The rest of the work is non-Solidity (UI, art, game.html, game.js)**

No compile-time errors on methods, TODO NEED TO HEED REMIX WARNINGS.

after creating two items: balanceOf returns 2, getItemsByOwner returns 0,1 in a uint256 array, if I list item 0 for 1 Wei, itemToPrice returns 1 given input 0. 

Basic test: 
![alt text](https://github.com/jpang7/shake_well/blob/master/ropstentest.JPG)

**TODO: Deploy smart contract after more review. Add author only methods if needed.**\

**TODO: Connect frontend to smart contract**

**TODO: Webpage styles and sprite artwork**

**TODO: Organize file structure**

Heavy influence drawn from Loom Network's CryptoZombies tutorial, W3's HTML5 game tutorial, LarvaLabs' Cryptopunks source code. THANK YOU.

All images are original artwork by Jonathan Pang
