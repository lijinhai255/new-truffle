// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RedPacket {
    struct RedPacketInfo {
        address sender;
        uint256 totalAmount;
        uint256 remainAmount;
        uint256 totalCount;
        uint256 remainCount;
        bool isActive;
    }

    // redPacketId => RedPacketInfo
    mapping(uint256 => RedPacketInfo) public redPackets;
    uint256 public redPacketCounter;

    // 创建红包事件，indexed 使得可以通过参数过滤事件日志
    event RedPacketCreated(
        uint256 indexed redPacketId, 
        address indexed sender, 
        uint256 totalAmount, 
        uint256 totalCount
    );

    // 抢红包事件
    event RedPacketClaimed(
        uint256 indexed redPacketId, 
        address indexed claimer, 
        uint256 amount
    );

    // 红包信息更新事件(可以在更新状态时触发，以便前端通过事件获取最新信息)
    event RedPacketUpdated(
        uint256 indexed redPacketId,
        uint256 remainAmount,
        uint256 remainCount
    );

    // 发红包函数
    function createRedPacket(uint256 _totalCount) external payable returns (uint256) {
        require(msg.value > 0, "No ETH sent.");
        require(_totalCount > 0, "Total count must be greater than zero.");

        redPacketCounter++;
        redPackets[redPacketCounter] = RedPacketInfo({
            sender: msg.sender,
            totalAmount: msg.value,
            remainAmount: msg.value,
            totalCount: _totalCount,
            remainCount: _totalCount,
            isActive: true
        });

        emit RedPacketCreated(redPacketCounter, msg.sender, msg.value, _totalCount);

        return redPacketCounter;
    }

    // 抢红包函数
    // 简单逻辑：平均分配
    function claimRedPacket(uint256 redPacketId) external {
        RedPacketInfo storage rp = redPackets[redPacketId];
        require(rp.isActive, "Red packet is not active");
        require(rp.remainCount > 0, "No red packets left");
        require(rp.remainAmount > 0, "No amount left");

        // 计算单个领取金额（整除，如果有余数最后一个人领到多余的一点）
        uint256 amount = rp.remainAmount / rp.remainCount;

        // 如果是最后一次领取，则将剩余的全部给领取者
        if (rp.remainCount == 1) {
            amount = rp.remainAmount; 
        }

        rp.remainAmount -= amount;
        rp.remainCount -= 1;

        // 发送ETH
        payable(msg.sender).transfer(amount);

        emit RedPacketClaimed(redPacketId, msg.sender, amount);

        // 触发更新事件，前端可通过此事件获知该红包剩余数量和金额
        emit RedPacketUpdated(redPacketId, rp.remainAmount, rp.remainCount);

        // 如果已领取完，设置为不活跃
        if (rp.remainCount == 0) {
            rp.isActive = false;
        }
    }
}
