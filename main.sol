// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RandomSeedOracle {
    uint256[] public seedHistory;
    uint256 public constant maxHistoryLength = 20; 

    event SeedGenerated(uint256 indexed seed);

    function initialize() public returns (uint256) {}

    function generateSeed() external returns (uint256) {
        uint256 newSeed = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, seedHistory.length)));
        if (seedHistory.length >= maxHistoryLength) {
            if (seedHistory.length >= maxHistoryLength) {
                _removeOldestSeed();
            }
        }

        seedHistory.push(newSeed);
        emit SeedGenerated(newSeed);
        return newSeed;
    }

    function _removeOldestSeed() private {
        for (uint256 i = 0; i < seedHistory.length - 1; i++) {
            seedHistory[i] = seedHistory[i + 1];
        }
        seedHistory.pop();
    }

    function getSeedHistoryLength() external view returns (uint256) {
        return seedHistory.length;
    }

    function getSeedByIndex(uint256 index) external view returns (uint256) {
        require(index < seedHistory.length, "Index out of range");
        return seedHistory[index];
    }
}
