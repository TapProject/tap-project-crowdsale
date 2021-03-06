pragma solidity ^0.4.11;


import "./ERC20.sol";
import "./Ownable.sol";
import "./StandardToken.sol";
import "./SafeMath.sol";


/*
 * A token that can increase its supply by another contract.
 *
 * This allows uncapped crowdsale by dynamically increasing the supply when money pours in.
 * Only mint agents, contracts whitelisted by owner, can mint new tokens.
 *
 */
contract MintableToken is StandardToken, Ownable {

  using SafeMath for uint;

  bool public mintingFinished = false;

  /* List of agents that are allowed to create new tokens */
  mapping (address => bool) public mintAgents;

  event MintingAgentChanged(address addr, bool state  );


  /*
   * Create new tokens and allocate them to an address..
   *
   * Only callably by a crowdsale contract (mint agent).
   */
  function mint(address receiver, uint amount) onlyMintAgent canMint public {

    if(amount == 0) {
      throw;
    }

    totalSupply = totalSupply.add(amount);
    balances[receiver] = balances[receiver].add(amount);
    Transfer(0, receiver, amount);
  }

  /*
   * Owner can allow a crowdsale contract to mint new tokens.
   */
  function setMintAgent(address addr, bool state) onlyOwner canMint public {
    mintAgents[addr] = state;
    MintingAgentChanged(addr, state);
  }

  modifier onlyMintAgent() {
    // Only crowdsale contracts are allowed to mint new tokens
    if(!mintAgents[msg.sender]) {
        throw;
    }
    _;
  }

  /* Make sure we are not done yet. */
  modifier canMint() {
    if(mintingFinished) throw;
    _;
  }
}
