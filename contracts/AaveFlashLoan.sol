// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "https://github.com/0xPr0f/defi-by-example/blob/main/contracts/interfaces/aave/FlashLoanReceiverBase.sol";

contract TestAaveFlashLoan is FlashLoanReceiverBase {
  using SafeMath for uint;

  event Log(string message, uint val);
  event OutPut (address add , bytes lol);

 constructor(ILendingPoolAddressesProvider _addressProvider)
    FlashLoanReceiverBase(_addressProvider)
  {}

  function AaveFlashLoan(address asset, uint amount) external {
  /*
    uint bal = IERC20(asset).balanceOf(address(this));
    require(bal > amount, "bal <= amount");
  */
    address receiver = address(this);

    address[] memory assets = new address[](1);
    assets[0] = asset;

    uint[] memory amounts = new uint[](1);
    amounts[0] = amount;

    // 0 = no debt, 1 = stable, 2 = variable
    // 0 = pay all loaned
    uint[] memory modes = new uint[](1);
    modes[0] = 0;

    address onBehalfOf = address(this);

    bytes memory params = ""; // extra data to pass abi.encode(...)
    uint16 referralCode = 0;

    LENDING_POOL.flashLoan(
      receiver,
      assets,
      amounts,
      modes,
      onBehalfOf,
      params,
      referralCode
    );
  }

  function executeOperation(
    address[] calldata assets,
    uint[] calldata amounts,
    uint[] calldata premiums,
    address initiator,
    bytes calldata params
  ) external override returns (bool) {
    
    // buy eth @ 2950 from a and sell eth @ 2960 to b
    // buy one eth, make $10
    // 500,000,000 
    // 170,000 eth
    // sell 170,000 eth @ 2960 for $ 503,200,000
    // make profit of $503,200,000 - $500,000,000 = 3,200,000 
    // pay 0.009% commission to aave, bag the rest.
    // do stuff here (arbitrage, liquidation, etc...)

    // abi.decode(params) to decode params
    for (uint i = 0; i < assets.length; ++i) {
      emit Log("borrowed", amounts[i]);
      emit Log("fee", premiums[i]);
      emit OutPut (initiator , params);
      uint amountOwing = amounts[i].add(premiums[i]);
      IERC20(assets[i]).approve(address(LENDING_POOL), amountOwing);
    }
    // repay Aave
    return true;
  }
}
