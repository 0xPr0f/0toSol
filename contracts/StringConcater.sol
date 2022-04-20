// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract StringConcater {
  
  // only in 0.8.12 and above
  function concatStringsNewWay() public pure returns(string memory){
    string memory hiMom = "Hi Mom, ";
    string memory missYou = "miss you.";
    return string.concat(hiMom, missYou);
  }

  function concatStringsOldWay() public pure returns (string memory){
    string memory hiMom = "Hi Mom, ";
    string memory missYou = "miss you.";
    return string(abi.encodePacked(hiMom, missYou));
  }
}
