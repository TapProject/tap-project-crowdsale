pragma solidity ^0.4.11;

/*
  Copyright 2017, Hugh Knight (The Tap Project R&D Team)
*/

import "./CrowdsaleToken.sol";

contract TapcoinToken is CrowdsaleToken {
  function TapcoinToken(string _name, string _symbol, uint _initialSupply, uint _decimals, bool _mintable)
   CrowdsaleToken(_name, _symbol, _initialSupply, _decimals, _mintable) {
  }
}
