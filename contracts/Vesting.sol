pragma solidity ^0.8.0;

import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { Token } from './Token.sol';

contract Vesting is Initializable {

    event Lockup(address indexed sender, uint256 amount);
    event Claim(address indexed sender, uint256 amount);

    struct VestingAccount {
        uint256 amountLeft;
        uint256 initialLockedAmount;
        uint256 startTimestamp;
    }

    Token token;

    // Tokens locked up for vesting
    mapping (address => VestingAccount) public lockedTokens;

    // The vesting duration
    uint256 constant public VESTING_DURATION = 300;

    // The vesting period
    uint256 constant public VESTING_PERIOD = 30;

    modifier onlyNotLocked {
        require(lockedTokens[msg.sender].amountLeft == 0, "already locked up tokens");
        _;
    }

    function initialize(address tokenAddress) initializer public {
        token = Token(tokenAddress);
    }

    function lockup(uint256 amount) external onlyNotLocked {
        require(token.balanceOf(msg.sender) >= amount, "not enough balance");

        VestingAccount memory account = VestingAccount({
            amountLeft: amount,
            initialLockedAmount: amount,
            startTimestamp: block.timestamp
        });
        lockedTokens[msg.sender] = account;

        token.transferFrom(msg.sender, address(this), amount);
    }

    function claim() external {
        VestingAccount storage account = lockedTokens[msg.sender];

        require(account.amountLeft > 0, "no vesting tokens");
        require(account.initialLockedAmount > 0, "no tokens deposited for vesting");

        uint256 amount = vestedAmount(account);
        account.amountLeft -= amount;

        token.transfer(msg.sender, amount);
    }

    function vestedAmount(VestingAccount memory account) internal view returns (uint256) {
        uint256 timePassed = block.timestamp - account.startTimestamp;

        if (timePassed > VESTING_DURATION) {
            return account.amountLeft;
        }

        uint256 vestingPeriodsPassed = timePassed / VESTING_PERIOD;
        uint256 vestedAmountPerPeriod = account.initialLockedAmount / (VESTING_DURATION / VESTING_PERIOD);

        return vestedAmountPerPeriod * vestingPeriodsPassed;
    }

}