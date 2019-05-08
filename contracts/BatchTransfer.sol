pragma solidity ^ 0.5.2;

import '/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';

contract BatchTransfer is ERC20 {
    event BatchTransfered(address indexed tokenAddress, uint256 value);

    mapping (address => uint256) txCount;
    address public _owner;
    // 批量转账的数量控制在150以下
    uint16 public arrayLimit = 150;

    modifier onlyOwner(){
        require(msg.sender == _owner,"必须是合约所有者才能执行此操作");
        _;
    }

    constructor(address owner) public{
        _owner = owner;
    }

    function() external payable{}

    // 批量转移Token
    function batchTransferToken(
        address token,
        address[] memory dsts,
        uint256[] memory values
    ) public {
        uint256 total = 0;
        // 判断批量转账交易的数量没有超过限制
        require(dsts.length <= arrayLimit,"批量转账数量过多，请查看参数arrayLimit");

        ERC20 erc20Token = ERC20(token);

        // 比较数组长度是否相等
        require(dsts.length==values.length,"请重新检查转账参数，确保dsts和values数组长度一致");

        for(uint8 i = 0; i < dsts.length; i++){
            erc20Token.transferFrom(msg.sender,dsts[i],values[i]);
            total += values[i];
        }

        txCount[msg.sender]++;
        emit BatchTransfered(token, total);

    }

    // 批量转账以太坊
    // function batchTransferEthereum(
    //     address[] memory dsts,
    //     uint256[] memory values
    // ) public {
    //     uint256 total = 0;
    //     require(dsts.length <= arrayLimit,"批量转账数量过多，请查看参数arrayLimit");

    //     for(uint8 i = 0; i < dsts.length;i++){
    //         dsts[i].transfer(values[i]);
    //         total += values[i];
    //     }

    //     txCount[msg.sender]++;
    //     emit BatchTransfered(address(0), total);

    // }
}