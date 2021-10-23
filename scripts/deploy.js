async function main() {
    const ffnFactory = await ethers.getContractFactory('Vesting');

    const ffn = await ffnFactory.deploy();
    console.log('address:', ffn.address);
}

main()
    .then(() => process.exit(0))
    .catch(err => {
        console.error(err);
        process.exit(1);
    });