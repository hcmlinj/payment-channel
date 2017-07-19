pragma solidity ^0.4.11;

contract PaymentChannel {
    address public sender;
    address public recipient;
    uint public startDate;
    uint public endDate;
    mapping(address => bytes32) public signatures;
    
    event Received(address indexed sender, uint value);
    event Commit(address indexed sender, address indexed signer, bytes32 message, uint amount);
    event Closed(address indexed sender, uint amount);
    
    function() payable {
        Received(msg.sender, msg.value);
    }
    
    function PaymentChannel(address _recipient, uint timeout) payable {
        sender = msg.sender;
        recipient = _recipient;
        startDate = now;
        endDate = startDate + timeout;
        
        
        if (msg.value > 0) Received(msg.sender, msg.value);
    }
    
    function getMessage(uint amount) constant returns (bytes32) {
        return sha3(this, amount);
    }
    
    function close(bytes32 message, uint8 v, bytes32 r, bytes32 s, uint amount) {
        bytes32 h = sha3("\x19Ethereum Signed Message:\n32", sha3(message));
        address signer = ecrecover(h, v, r, s);
        
        if (signer != sender && signer != recipient) revert();
        if (sha3(this, amount) != message) revert();
        
        signatures[signer] = message;
        Commit(msg.sender, signer, message, amount);
        
        if (signatures[sender] == signatures[recipient]) {
            recipient.transfer(amount);
            Closed(msg.sender, amount);
            selfdestruct(sender);
        }
    }
    
    function cancel() {
        if (endDate > now) {
            revert();
        } else {
            selfdestruct(sender);
        }
    }
}