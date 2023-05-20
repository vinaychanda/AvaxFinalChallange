require("@nomicfoundation/hardhat-toolbox");

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: forkingData ? undefined : 43112,
      forking: forkingData,
    },
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: ['0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6'].map(address => address.toString()), // Convert the address to a string
    },
  },
  etherscan: {
    apiKey: 'XARM47HXT56639VUB74WS7D89ZEZATDC42', // we use an .env file to hide our Snowtrace API KEY
  },
};
