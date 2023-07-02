// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC1155SignatureMint.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";

contract nfttrade is ERC1155SignatureMint, PermissionsEnumerable {

    // Mapping from token ID to the power level of that NFT
    mapping (uint256 => uint256) private powerLevel;

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
    
    // Add a function to set the power level, this function is only callable by DEFAULT_ADMIN_ROLE

    
    function setPowerLevel(uint256 tokenId, uint256 _powerLevel) public onlyRole(DEFAULT_ADMIN_ROLE) {
        powerLevel[tokenId] = _powerLevel;
    }

    //Override the mintTo function of the base contract
    //Set the power level of the token to be the power level of the token ID

    function mintTo(
        address _to,
        uint256 _tokenId,
        string memory _tokenURI,
        uint256 _amount
    ) public override {

        //Grab the next available token ID
        uint256 tokenId = nextTokenIdToMint();

        //Mint the NFT using the underlying logic
        super.mintTo(_to, _tokenId, _tokenURI, _amount);

        //Set the power level of that NFT
        powerLevel[tokenId] = tokenId;

    }

}

