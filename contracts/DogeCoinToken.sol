pragma solidity ^ 0.5.0;

import '/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';
import '/openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol';
import '/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol';

contract DogeCoinToken is ERC20, ERC20Detailed, ERC20Mintable {

    event CreateTokenSuccess(address indexed owner, uint256 amount);

    constructor(

    )
        public
        ERC20Mintable()
        ERC20Detailed("dogecoin", "DGCT", 18)
        ERC20()
    {
        mint(msg.sender,2000);
        emit CreateTokenSuccess(msg.sender,balanceOf(msg.sender));
    }
}