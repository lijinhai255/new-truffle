// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract InfoContract {
    string private name;
    string private scolller; // 新增字段
    uint256 private age;

    // 定义事件，添加 indexed 关键字（可选）
    event InfoUpdated(address indexed updater, string name, uint256 age, string scolller);

    // 修改信息
    function setInfo(string memory _name, string memory _scolller, uint256 _age) public {
        name = _name;
        scolller = _scolller; // 更新 scolller
        age = _age;
        emit InfoUpdated(msg.sender, _name, _age, _scolller); // 触发事件
    }

    // 提供直接查看数据的方法
    function getInfo() public view returns (string memory, uint256, string memory) {
        return (name, age, scolller);
    }
}
