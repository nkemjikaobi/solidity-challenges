pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  //event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;
  uint256 public constant tokensPerEth = 100;

  event BuyTokens(address, uint256, uint256);

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  function buyTokens() public payable {
        uint numOfTokens = msg.value * tokensPerEth;
        yourToken.transfer(msg.sender, numOfTokens);
        emit BuyTokens(msg.sender, msg.value, numOfTokens);
    }

  function withdraw() public onlyOwner {
    address myAdd = owner();
    payable(myAdd).transfer(address(this).balance);
  }
  // ToDo: create a withdraw() function that lets the owner withdraw ETH

  function sellTokens(uint256 amount) public {
    require(yourToken.allowance(msg.sender, address(this)) >= amount, "You have not approved Vendor");
    yourToken.transferFrom(msg.sender, address(this), amount);
    payable(msg.sender).transfer(amount / tokensPerEth);
  }

  // ToDo: create a sellTokens() function:

}