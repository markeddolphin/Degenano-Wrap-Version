require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const FANTOM_PRIVATE_KEY = "777d8f1c2e83606fc259654f9019ad1aab44c15e69bb68471a893909535d9b1d";
const ETHERSCAN_API_KEY = "FJG5VMAUQ15WNRXNAPHZ4R6KMYPP9VKBXF";
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.9",
  etherscan: {
    // Your API key for Snowtrace
    // Obtain one at https://snowtrace.io/
    apiKey: `${ETHERSCAN_API_KEY}`,
  },
  networks: {
    fantom: {
      url: 'https://rpc.ftm.tools/',
      accounts: [`${FANTOM_PRIVATE_KEY}`]
    }
  }
};
