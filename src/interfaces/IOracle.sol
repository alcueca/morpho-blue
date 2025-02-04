// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

/// @title IOracle
/// @author Morpho Labs
/// @custom:contact security@morpho.org
/// @notice Interface that oracles used by Morpho must implement.
interface IOracle {
    /// @notice Returns the price of 1 asset of collateral token quoted in 1 asset of loan token, scaled by 1e36.
    /// @dev It corresponds to the price of 10**(collateral token decimals) assets of collateral token quoted in
    /// 10**(loan token decimals) assets of loan token with `36 + loan token decimals - collateral token decimals`
    /// decimals of precision.
    function price() external view returns (uint256);

    /// @notice Returns the value of an amount of base token in terms of quote token.
    function value(address baseToken, address quoteToken, uint256 baseAmount) external view returns (uint256 quoteAmount);
}
