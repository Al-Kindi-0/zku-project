require("hardhat-circom");
require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: {
    compilers: [{ version: "0.7.6" }, { version: "0.8.0" }]
  },
  circom: {
    ptau: "pot15_final.ptau",
    circuits: [{name: "mint"},{ name: "unshield" }, { name: "shield" }, { name: "transfer" }]
  }
};
