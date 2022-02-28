pragma solidity ^0.6.6;

// 1. Import the Chainlink VRF contract code VRFConsumerBase.sol "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol" contract
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

/*
You got it! The VRFConsumerbase contract includes all the code we need to send a request to a Chainlink oracle, including all the event logging code.
To interact with a Chainlink node, we need to know a few variables.
1. The address of the Chainlink token contract. This is needed so our contract can tell if we have enough LINK tokens to pay for the gas.
2. The VRF coordinator contract address. This is needed to verify that the number we get is actually random.
3. The Chainlink node keyhash. This is used identify which Chainlink node we want to work with.
4. The Chainlink node fee. This represents the fee (gas) the Chainlink will charge us, expressed in LINK tokens.
5. You can find all these variables in the Chainlink VRF Contract addresses documentation page. Once again, the addresses will be different across networks, but for the scope of this lesson we will again be working with the Rinkeby network.
*/
// 1. Have our `ZombieFactory` contract inherit from the `VRFConsumerbase` contract
contract ZombieFactory is VRFConsumerbase {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
   
    // 1. Define the `keyHash`, `fee`, and `randomResult` variables. Don't forget to make them `public`.
    bytes32 public keyHash;
    uint256 public fee;
    uint256 public randomResult;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;
    
        // 2. Create a constructor
    constructor () VRFConsumerBase(
        0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B, // VRF Coordinator
        0x01BE23585060835E02B77ef475b0Cc51aA1e0709  // LINK Token
    ) public{
            // 2. Fill in the body of the newly created constructor
        keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
        fee = 100000000000000000;
    }

    }

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }
    
    /*
Remember, the Chainlink VRF follows the basic request model, so we need to define:

A function to request the random number

A function for the the Chainlink node to return the random number to.
*/

/*A. requestRandomness

This function checks to see that our contract has LINK tokens to pay a Chainlink node
Then, it sends some LINK tokens to the Chainlink node
Emits an event that the Chainlink node is looking for
Assigns a requestId to our request for a random number on-chain
*/

    // 1. Create the `getRandomNumber` function
    function getRandomNumber() public returns (bytes32 requestId) {
        return requestRandomness(keyHash, fee);
    }

/*
B. fulfillRandomness

The Chainlink node first calls a function on the VRF Coordinator and includes a random number
The VRF Coordinator checks to see if the number is random
Then, it returns the random number the Chainlink node created, along with the original requestID from our request
*/
    // 2. Create the `fulfillRandomness` function
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
    }
//Now let's delete the old pseudo-random number generator! We are using TRUE randomness now!
/*
    function _generatePseudoRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }
*/
}
