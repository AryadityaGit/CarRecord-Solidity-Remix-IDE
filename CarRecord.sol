  Ropsten Test Network : https://ropsten.etherscan.io/tx/0x7c9aa2bbf9eb3ae96a3d52b32f5c92058f61f8565805ba3d7b9fb6f8b74e1ef4
  
 status 	0x1 Transaction mined and execution succeed
 transaction hash 	0xab5ab2171dfbcea7133e8e7ddd198b91ea22d7b7a29f8018ed3b03327bcf056c
 contract address 	0x5e72914535f202659083db3a02c984188fa26e9f
 from 	0xca35b7d915458ef540ade6068dfe2f44e8fa733c
 to 	CarRegistry.(constructor)
 gas 	3000000 gas 
 transaction cost 	863351 gas 
 execution cost 	601247 gas 
 hash 	0xab5ab2171dfbcea7133e8e7ddd198b91ea22d7b7a29f8018ed3b03327bcf056c
 input 	0x608...f0029
 decoded input 	{}
 decoded output 	 - 
 logs 	[]
 value 	0 wei 



pragma solidity ^0.4.6;
contract CarRegistry {

// --- Define variables. ---

// Saves the wallet address of the owner.
address public owner;
string public name;

uint numCarTokens;

struct CarToken {
    address beneficiary;
    string carDescription;
    string serialNumber;
    uint dateIssued;
}

mapping (uint => CarToken) public carTokens;

// http://solidity.readthedocs.io/en/develop/common-patterns.html#restricting-access
modifier onlyBy(address account) {
    if (msg.sender != account) throw;
    _;
}


// --- This sets you as the contract owner. ---

function CarRegistry() {  //function CarRegistry(string contractName) {
    owner = msg.sender;
		// Set the name for display purposes
    name = "CarRegistry";  //    name = contractName;
    // Making a Token for testing and demonstration purposes.
    NewToken(0xe9Cc63556C0F580F08CcfFbBF04d86Eeaf836f6F, "Something about the car", "X-0000-0004");
}


// --- NewToken. Lets the owner create Tokens. ---

function NewToken(address receiver, string carDescription, string serialNumber) onlyBy(owner) returns (uint carTokenID) {
    carTokenID = numCarTokens++;
    carTokens[carTokenID] = CarToken(receiver, carDescription, serialNumber, block.timestamp);
}


// --- Transfer. Lets the beneficiary of a Token transfer his Token. ---

function Transfer(address receiver, uint carTokenID) {
		CarToken t = carTokens[carTokenID];
		if (t.beneficiary != msg.sender) throw;
		t.beneficiary = receiver;
}        
}
