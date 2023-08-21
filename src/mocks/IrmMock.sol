// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {IIrm} from "../interfaces/IIrm.sol";
import {MarketParams, Market} from "../interfaces/IMorpho.sol";

import {MathLib} from "../libraries/MathLib.sol";
import {MarketLib} from "../libraries/MarketLib.sol";
import {MorphoLib} from "../libraries/periphery/MorphoLib.sol";

contract IrmMock is IIrm {
    using MathLib for uint128;

    function borrowRateView(MarketParams memory, Market memory market) public pure returns (uint256) {
        uint256 utilization = market.totalBorrowAssets.wDivDown(market.totalSupplyAssets);

        // Divide by the number of seconds in a year.
        // This is a very simple model where x% utilization corresponds to x% APR.
        return utilization / 365 days;
    }

    function borrowRate(MarketParams memory marketParams, Market memory market) external pure returns (uint256) {
        return borrowRateView(marketParams, market);
    }
}
