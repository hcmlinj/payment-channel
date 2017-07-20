'use strict'

const util = require('ethereumjs-util')

if (typeof process.argv[2] === 'undefined') {
    console.log('please input message')
    return
}

if (typeof process.argv[3] === 'undefined') {
    console.log('please input signature')
    return
}

const msg = util.toBuffer(process.argv[2])
const sig = util.fromRpcSig(process.argv[3])

const h = util.hashPersonalMessage(msg)
const v = sig.v
const r = sig.r
const s = sig.s

const pub = util.ecrecover(h, v, r, s)
const addr = util.publicToAddress(pub)

console.log('==========================================================================================')
console.log('h', util.bufferToHex(h))
console.log('v', v)
console.log('r', util.bufferToHex(r))
console.log('s', util.bufferToHex(s))
// console.log('pub', util.bufferToHex(pub))
console.log('addr', util.bufferToHex(addr))
console.log('==========================================================================================')