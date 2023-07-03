// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC1155SignatureMint.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol";

contract wordmint is ERC1155SignatureMint, PermissionsEnumerable {

  //  uint256 public maxSupply = 1;

    constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps,
        address _primarySaleRecipient
    )
        ERC1155SignatureMint(
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps,
            _primarySaleRecipient
        )
    {
        //SET UP DEFAULT_ADMIN_ROLE
        //And provide that role to the wallet address that deploys the contract
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

//Mint function with public override
    function mintTo(
        address _to,
        uint256 _tokenId,
        string memory _tokenURI,
        uint256 _amount
    ) public virtual override {

        uint256 tokenIdToMint;
        uint256 nextIdToMint = nextTokenIdToMint();

        if (_tokenId == type(uint256).max) {
            tokenIdToMint = nextIdToMint;
            nextTokenIdToMint_ += 1;
            _setTokenURI(nextIdToMint, _tokenURI);
        } else {
            require(_tokenId < nextIdToMint, "invalid id");
            tokenIdToMint = _tokenId;
        }

        _mint(_to, tokenIdToMint, _amount, "");
    }
}