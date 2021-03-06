// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract Token is ERC20('Test Token', 'TT'), Ownable {
	event TokenBurnt(uint256 amount);

	function mint(address recipient_, uint256 amount_) public onlyOwner returns (bool) {
		uint256 balanceBefore = balanceOf(recipient_);
		_mint(recipient_, amount_);
		uint256 balanceAfter = balanceOf(recipient_);

		return balanceAfter > balanceBefore;
	}

	// this is kinda pointless, anyone can transfer tokens to a burn address
	function burn(uint256 amount_) public onlyOwner {
		_burn(msg.sender, amount_);
		emit TokenBurnt(amount_);
	}
}
