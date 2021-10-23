const { ethers, upgrades } = require("hardhat");

async function main() {
    const Vesting = await ethers.getContractFactory("Token");
    const vesting = await upgrades.deployProxy(Vesting, []);

    await vesting.deployed();
    
    console.log(vesting.address);
}

main();