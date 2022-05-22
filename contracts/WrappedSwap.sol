/**
 *Submitted for verification at BscScan.com on 2022-05-09
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";

interface IDegenano is IERC20 {
    function currentIndex() external view returns (uint256);
}

contract WrappedSwap is Ownable {

    using SafeMath for uint256;

    address dgn = 0x8Fb3Bd6290D9d2d76554d876B2EF020b3cb39dd8;
    address wrapped = 0xE0c940214Ef7b081DAf361f014B890495bD8eFb4;

    constructor () {
        
    }

    function getDgn (uint256 _amount) public {
        IERC20 _dgn = IERC20 (dgn);
        IERC20 _wrapped = IERC20 (wrapped);

        bool success = _wrapped.transferFrom(msg.sender, address(this), _amount);
        require (success, "transfer from failed");

        uint256 _refund = dgnRefundValue(_amount);
        bool success2 = _dgn.transfer(msg.sender, _refund);
        require (success2, "transfer failed");

    }

    function getWrapped (uint256 _amount) public {
        IERC20 _dgn = IERC20 (dgn);
        IERC20 _wrapped = IERC20 (wrapped);

        bool success = _dgn.transferFrom(msg.sender, address(this), _amount);
        require (success, "transfer from failed");

        uint256 _refund = wrappedRefundValue(_amount);
        bool success2 = _wrapped.transfer(msg.sender, _refund);
        require (success2, "transfer failed");
    }

    function dgnRefundValue (uint256 _amount) public view returns (uint256) {
        IDegenano _dgn = IDegenano (dgn);
        uint256 _refund = _amount.mul(_dgn.currentIndex()).div(10**18);
        return _refund;
    }

    function wrappedRefundValue (uint256 _amount) public view returns (uint256) {
        IDegenano _dgn = IDegenano (dgn);
        uint256 _refund = _amount.mul(10**18).div(_dgn.currentIndex());
        return _refund;
    }
}