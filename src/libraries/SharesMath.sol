// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {FixedPointMathLib} from "./FixedPointMathLib.sol";

/// @notice Shares management library.
/// @dev This implementation mitigates share price manipulations, using OpenZeppelin's method of virtual shares: https://docs.openzeppelin.com/contracts/4.x/erc4626#inflation-attack.
library SharesMath {
    using FixedPointMathLib for uint256;

    uint256 internal constant VIRTUAL_SHARES = 1e18;
    uint256 internal constant VIRTUAL_ASSETS = 1;

    /// @dev Calculates the value of the given assets quoted in shares, rounding down.
    /// Note: provided that assets <= totalAssets, this function satisfies the invariant: shares <= totalShares.
    function toSharesDown(uint256 assets, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
        return assets.mulDivDown(totalShares + VIRTUAL_SHARES, totalAssets + VIRTUAL_ASSETS);
    }

    /// @dev Calculates the value of the given shares quoted in assets, rounding down.
    /// Note: provided that shares <= totalShares, this function satisfies the invariant: assets <= totalAssets.
    function toAssetsDown(uint256 shares, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
        return shares.mulDivDown(totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES);
    }

    /// @dev Calculates the value of the given assets quoted in shares, rounding up.
    /// Note: provided that assets <= totalAssets, this function satisfies the invariant: shares <= totalShares + VIRTUAL_SHARES.
    function toSharesUp(uint256 assets, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
        return assets.mulDivUp(totalShares + VIRTUAL_SHARES, totalAssets + VIRTUAL_ASSETS);
    }

    /// @dev Calculates the value of the given shares quoted in assets, rounding up.
    /// Note: provided that shares <= totalShares, this function satisfies the invariant: assets <= totalAssets + VIRTUAL_SHARES.
    function toAssetsUp(uint256 shares, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
        return shares.mulDivUp(totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES);
    }

    /// @dev Calculates the amount of shares corresponding to a given amount of supply.
    /// Note: only works as long as totalSupplyShares >= totalSupply.
    function toSupplyShares(uint256 amount, uint256 totalSupply, uint256 totalSupplyShares)
        internal
        pure
        returns (uint256)
    {
        uint256 shares = toSharesUp(amount, totalSupply, totalSupplyShares);

        if (amount != toAssetsDown(shares, totalSupply, totalSupplyShares)) {
            return toSharesDown(amount + 1, totalSupply, totalSupplyShares);
        }

        return shares;
    }

    /// @dev Calculates the amount of shares corresponding to a given amount of borrow.
    /// Note: only works as long as totalBorrowShares >= totalBorrow.
    function toBorrowShares(uint256 amount, uint256 totalBorrow, uint256 totalBorrowShares)
        internal
        pure
        returns (uint256)
    {
        uint256 shares = toSharesDown(amount, totalBorrow, totalBorrowShares);

        if (amount != 0 && amount != toAssetsUp(shares, totalBorrow, totalBorrowShares)) {
            return toSharesUp(amount - 1, totalBorrow, totalBorrowShares);
        }

        return shares;
    }
}
