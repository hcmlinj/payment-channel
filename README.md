# Payment Channel
Using solidity smart contract implements payment channel on Ethereum.
Inspired by [Ethereum Payment Channel in 50 Lines of Code](https://medium.com/@matthewdif/ethereum-payment-channel-in-50-lines-of-code-a94fad2704bc)

## Install
```bash
$ npm i
```

## testrpc (optional)
```bash
$ npm run testrpc

> testrpc

EthereumJS TestRPC v4.0.1 (ganache-core: 1.0.1)

Available Accounts
==================
(0) 0x7c2970b3ee1b08cfaa80881939782c5303130e7d
(1) 0x9d7002bde2faab4927f4cc7bfaeaaca6651137a3
(2) 0x04954341da6fadb3fc5f5c0dcf878b9e01478587
(3) 0x337e2ec86cd62ebe5c65c866a5e9a6a19ca4eb34
(4) 0xb89d0d90902c1a169c54eceb396fb1ea7a997fac
(5) 0x948fc7a3f1c41ea39412fab8bacd2b40b1a6a81f
(6) 0xda6b59a56b6925d7dfb94f66a7615990827dc9fb
(7) 0x546bbe5499e5ecff6d1c07bc05008903a81b2b07
(8) 0x24eee708b2439fc09f70c6ac94d987507e20bedb
(9) 0x65997ce04aa171fbacff4b5458f9945c4679e84f

Private Keys
==================
(0) f645770c0fce373111600d91f8a4f86fea1cc499e1cb4adffa78c1514664713f
(1) c428aff99f377e75ae9fa86ae3aee03262c9fe3c9e539dca8b1d920dce1a964e
(2) 161260dd6c1fe5f34cc2e6c2d3e14b814f18ba1975ac54554ff00308211c2e81
(3) 50e5055c6a13da6eb9eb955f3c9672d074eabb4487fc48b1af6f15e377f9b8c2
(4) 77d04c5739bf68f524d0cd941568ebe81f85b61dd355c47b9ac6e3da76ee8474
(5) 8f3d64daea24a3c2ec9b59e26ba11a5073c1ad23cfb1ef4a32a8a5d82fbe5f8f
(6) b0898e90134f56225a0d3b8ecf5fa98a930694b8eaecdb97a3038f9327d39f03
(7) 0245be31b8dde4d6b9a3603c4d4c74e845337ab4cf897491f78861998f3fde74
(8) df3eb5d5c60af93c6926a308a7f0837b10e2bde7332ed371f1a719d80a5dde24
(9) 5a32a560226e7ebf55cff4c8ad91f1229f4238f863011b21f2f2b7876a3aed8e

HD Wallet
==================
Mnemonic:      river plastic limb impulse always envelope issue engine actual ancient thunder slim
Base HD Path:  m/44'/60'/0'/0/{account_index}

Listening on localhost:8545
```

## Deploy (Truffle)
```bash
$ npm run migrate

> truffle migrate --reset

Using network 'development'.

Running migration: 1_initial_migration.js
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying PaymentChannel...
  PaymentChannel: 0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e
Saving artifacts...
```

## Console (Truffle)
```bash
$ npm run console

> truffle console

truffle(development)>
```

## Payment Channel Balance
* initial
```js
module.exports = function (deployer) {
  deployer.deploy(PaymentChannel, web3.eth.accounts[2], 259200, { from: web3.eth.accounts[1], value: web3.toWei(10) });
};
```
* get balance
```js
truffle(development)> web3.toDecimal(web3.fromWei(web3.eth.getBalance('0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e')))
10
```
* send 2 eth to smart contract
```js
truffle(development)> web3.eth.sendTransaction({from: web3.eth.coinbase, to: '0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e', value: web3.toWei(2)})
'0x9f4083f60d2b99e2910c06db38bcb9938fa9acba9ddcb31959427d20e93d45c2'

truffle(development)> web3.toDecimal(web3.fromWei(web3.eth.getBalance('0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e')))
12
```

## Check Payment Channel's Sender And Recipient
```js
truffle(development)> var pc = PaymentChannel.at('0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e')

truffle(development)> web3.eth.accounts[1]
'0x9d7002bde2faab4927f4cc7bfaeaaca6651137a3'
truffle(development)> pc.sender()
'0x9d7002bde2faab4927f4cc7bfaeaaca6651137a3'

truffle(development)> web3.eth.accounts[2]
'0x04954341da6fadb3fc5f5c0dcf878b9e01478587'
truffle(development)> pc.recipient()
'0x04954341da6fadb3fc5f5c0dcf878b9e01478587'
```

## Log The Initial Balance
```js
truffle(development)> web3.toDecimal(web3.fromWei(web3.eth.getBalance('0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e')))
12

truffle(development)> web3.toDecimal(web3.fromWei(web3.eth.getBalance(web3.eth.accounts[1])))
89.9532057

truffle(development)> web3.toDecimal(web3.fromWei(web3.eth.getBalance(web3.eth.accounts[2])))
100
```

## Get Message From Smart Contract
```js
truffle(development)> pc.getMessage(web3.toWei(6))
'0xbff8a77208e4430fc219b8561f39f2b0c1591f7851cf500f137a55b6c7458789'
```

## Sign Message From Sender
* get signature
```js
truffle(development)> web3.eth.sign(web3.eth.accounts[1], '0xbff8a77208e4430fc219b8561f39f2b0c1591f7851cf500f137a55b6c7458789')
'0xd03fa88ef05299a8af6a0aca62d14ba1a3bf705b3be055b170f19faa77e831355a980f2883a33260e3bc2f4ff11264b88923d6f8914a4e3277e3338473a9184701'
```
* verify signature and find v, r, s
```bash
$ node verify.js 0xbff8a77208e4430fc219b8561f39f2b0c1591f7851cf500f137a55b6c7458789 0xd03fa88ef05299a8af6a0aca62d14ba1a3bf705b3be055b170f19faa77e831355a980f2883a33260e3bc2f4ff11264b88923d6f8914a4e3277e3338473a9184701
==========================================================================================
h 0xdc7497106fe3677b6ddacbf0f087b424e77f3daab0890c3cc00babd7415b5354
v 28
r 0xd03fa88ef05299a8af6a0aca62d14ba1a3bf705b3be055b170f19faa77e83135
s 0x5a980f2883a33260e3bc2f4ff11264b88923d6f8914a4e3277e3338473a91847
addr 0x9d7002bde2faab4927f4cc7bfaeaaca6651137a3
==========================================================================================
```

## Sign Message From Recipient
```js
truffle(development)> web3.eth.sign(web3.eth.accounts[2], '0xbff8a77208e4430fc219b8561f39f2b0c1591f7851cf500f137a55b6c7458789')
'0x5f665a817734d10a10423ac6ea1fe1638810aa1dd4774f74e03da68af38ace4946ec1bff5accab085d9ac9f57ac7b75ce80009bb263f4a86b5189ba8c12dc85a00'
```
* verify signature and find v, r, s
```bash
$ node verify.js 0xbff8a77208e4430fc219b8561f39f2b0c1591f7851cf500f137a55b6c7458789 0x5f665a817734d10a10423ac6ea1fe1638810aa1dd4774f74e03da68af38ace4946ec1bff5accab085d9ac9f57ac7b75ce80009bb263f4a86b5189ba8c12dc85a00
==========================================================================================
h 0xdc7497106fe3677b6ddacbf0f087b424e77f3daab0890c3cc00babd7415b5354
v 27
r 0x5f665a817734d10a10423ac6ea1fe1638810aa1dd4774f74e03da68af38ace49
s 0x46ec1bff5accab085d9ac9f57ac7b75ce80009bb263f4a86b5189ba8c12dc85a
addr 0x04954341da6fadb3fc5f5c0dcf878b9e01478587
==========================================================================================
```

## Send Multisig To Payment Channel
```js
truffle(development)> pc.close('0xbff8a77208e4430fc219b8561f39f2b0c1591f7851cf500f137a55b6c7458789', 28, '0xd03fa88ef05299a8af6a0aca62d14ba1a3bf705b3be055b170f19faa77e83135', '0x5a980f2883a33260e3bc2f4ff11264b88923d6f8914a4e3277e3338473a91847', web3.toWei(6))
{ tx: '0xf4aff05366c854e762f3f7131948f4b9a09292715a764f1444391ba5c9268de9',
  receipt:
   { transactionHash: '0xf4aff05366c854e762f3f7131948f4b9a09292715a764f1444391ba5c9268de9',
     transactionIndex: 0,
     blockHash: '0x66d2f11d0fc8fe2a7e006f47547ce12551e17a6044ea812760e374dd0411688c',
     blockNumber: 4,
     gasUsed: 55165,
     cumulativeGasUsed: 55165,
     contractAddress: null,
     logs: [ [Object] ] },
  logs:
   [ { logIndex: 0,
       transactionIndex: 0,
       transactionHash: '0xf4aff05366c854e762f3f7131948f4b9a09292715a764f1444391ba5c9268de9',
       blockHash: '0x66d2f11d0fc8fe2a7e006f47547ce12551e17a6044ea812760e374dd0411688c',
       blockNumber: 4,
       address: '0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e',
       type: 'mined',
       event: 'Commit',
       args: [Object] } ] }

truffle(development)> pc.close('0xbff8a77208e4430fc219b8561f39f2b0c1591f7851cf500f137a55b6c7458789', 27, '0x5f665a817734d10a10423ac6ea1fe1638810aa1dd4774f74e03da68af38ace49', '0x46ec1bff5accab085d9ac9f57ac7b75ce80009bb263f4a86b5189ba8c12dc85a', web3.toWei(6))
{ tx: '0x0b89299649e10787581fdbca97cf394254a007878e48605935bc9b49d0d66046',
  receipt:
   { transactionHash: '0x0b89299649e10787581fdbca97cf394254a007878e48605935bc9b49d0d66046',
     transactionIndex: 0,
     blockHash: '0xae0d03833c4babd35d8b5744178a9be2a47972cbf68e0838c43b7dbb4756802b',
     blockNumber: 5,
     gasUsed: 39662,
     cumulativeGasUsed: 39662,
     contractAddress: null,
     logs: [ [Object], [Object] ] },
  logs:
   [ { logIndex: 0,
       transactionIndex: 0,
       transactionHash: '0x0b89299649e10787581fdbca97cf394254a007878e48605935bc9b49d0d66046',
       blockHash: '0xae0d03833c4babd35d8b5744178a9be2a47972cbf68e0838c43b7dbb4756802b',
       blockNumber: 5,
       address: '0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e',
       type: 'mined',
       event: 'Commit',
       args: [Object] },
     { logIndex: 1,
       transactionIndex: 0,
       transactionHash: '0x0b89299649e10787581fdbca97cf394254a007878e48605935bc9b49d0d66046',
       blockHash: '0xae0d03833c4babd35d8b5744178a9be2a47972cbf68e0838c43b7dbb4756802b',
       blockNumber: 5,
       address: '0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e',
       type: 'mined',
       event: 'Closed',
       args: [Object] } ] }
```

## Check The Final Balance
```js
truffle(development)> web3.toDecimal(web3.fromWei(web3.eth.getBalance('0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e')))
0

truffle(development)> web3.toDecimal(web3.fromWei(web3.eth.getBalance(web3.eth.accounts[1])))
95.9532057

truffle(development)> web3.toDecimal(web3.fromWei(web3.eth.getBalance(web3.eth.accounts[2])))
106
```

## Confirm The Smart Contract
```js
truffle(development)> PaymentChannel.at('0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e')
(node:2002) UnhandledPromiseRejectionWarning: Unhandled promise rejection (rejection id: 1): Error: Cannot create instance of PaymentChannel; no code at address 0xca7e455f8ac3e048bb11d82a7b3a4e0136afc30e
(node:2002) [DEP0018] DeprecationWarning: Unhandled promise rejections are deprecated. In the future, promise rejections that are not handled will terminate the Node.js process with a non-zero exit code.
```