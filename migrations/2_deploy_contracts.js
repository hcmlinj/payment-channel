var PaymentChannel = artifacts.require("./PaymentChannel.sol");

module.exports = function (deployer) {
  deployer.deploy(PaymentChannel, web3.eth.accounts[2], 259200, { from: web3.eth.accounts[1], value: web3.toWei(10) });
};
