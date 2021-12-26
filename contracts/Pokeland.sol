// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract Pokeland is ERC20PresetMinterPauser {
  address public owner = msg.sender;
  mapping (address => bool) private _allowedTransferAddresses;
  bool private _isTransfersAllowed;

  constructor(string memory name, string memory symbol) ERC20PresetMinterPauser(name, symbol) {
    _isTransfersAllowed = false;
  }

  function _transfer(address sender, address recipient, uint256 amount) internal virtual override {
    require(_isTransfersAllowed || _allowedTransferAddresses[sender], 'Restricted transfer');
    ERC20._transfer(sender, recipient, amount);
  }

  function getAllowedAddress(address addressToCheck) public view returns (bool) {
    require(msg.sender == owner, 'Not owner of contract');
    return _allowedTransferAddresses[addressToCheck];
  }
  function setAllowedAddress(address addressToSet, bool canTransfer) public {
    require(msg.sender == owner, 'Not owner of contract');
    _allowedTransferAddresses[addressToSet] = canTransfer;
  }
  function getTransfersAllowed() public view returns (bool) {
    require(msg.sender == owner, 'Not owner of contract');
    return _isTransfersAllowed;
  }
  function setTransfersAllowed(bool canTransfer) public {
    require(msg.sender == owner, 'Not owner of contract');
    _isTransfersAllowed = canTransfer;
  }
}
