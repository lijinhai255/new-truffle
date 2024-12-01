// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MetaCoin is ERC20 {
    string public constant NAME = 'WEBAIERC20Token';
    string public constant SYMBOL = 'WEBAI';
    uint256 public constant INITIAL_SUPPLY = 10000;

    constructor() ERC20(NAME, SYMBOL) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

}
