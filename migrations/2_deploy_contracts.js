var PaymentChannel = artifacts.require("./PaymentChannel.sol");

module.exports = function (deployer) {
  deployer.deploy(PaymentChannel, web3.eth.accounts[1], 259200, { value: web3.toWei(10) });
};
