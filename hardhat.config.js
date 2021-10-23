/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 require('dotenv').config();
 require("@nomiclabs/hardhat-waffle");
 require('@nomiclabs/hardhat-ethers');
 require("@nomiclabs/hardhat-etherscan");
 require('@openzeppelin/hardhat-upgrades');
 module.exports = {
   solidity: "0.8.0",
   defaultNetwork: 'rinkeby',
   networks: {
     rinkeby: {
       url: process.env.INFURA_URL,
       accounts: [`${process.env.PRIVATE_KEY}`],
     }
   },
   etherscan: {
     apiKey: `${process.env.ETHERSCAN_KEY}`
   },
   mocha: {
     timeout: 60000,
   }
 };
 