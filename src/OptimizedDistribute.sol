// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Distribute {
    address[6] public contributors;
    uint256 public immutable distributeTime;

    uint256 private immutable amount;

    error CanNotDistributeYet(); // selector 0x5a19cf77

    constructor(address[6] memory _contributors) payable {
        unchecked {
            contributors = _contributors;
            distributeTime = block.timestamp + 2 weeks;
            amount = msg.value / 6;
        }
    }

    function distribute_() external payable {
        uint256 _distributeTime = distributeTime;
        uint256 _amount = amount;
        assembly {
            if lt(timestamp(), _distributeTime) {
                mstore(0, 0x5a19cf77)
                revert(0x1c, 0x04)
            }
            pop(call(gas(), sload(0), _amount, 0, 0, 0, 0))

            pop(call(gas(), sload(1), _amount, 0, 0, 0, 0))

            pop(call(gas(), sload(2), _amount, 0, 0, 0, 0))

            pop(call(gas(), sload(3), _amount, 0, 0, 0, 0))

            pop(call(gas(), sload(4), _amount, 0, 0, 0, 0))

            pop(call(gas(), sload(5), _amount, 0, 0, 0, 0))
        }
    }
}
