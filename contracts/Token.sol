pragma solidity ^0.8.0;

import { ERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract Token is ERC20Upgradeable {

    function initialize() initializer public {
        __ERC20_init("Blahblah", "BLAH");

        // mint 10m tokens
        _mint(msg.sender, 1e25);
    }

}