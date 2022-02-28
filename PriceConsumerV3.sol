pragma solidity ^0.6.7; //1. Enter Solidity version here

// Importing from NPM and Github
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

//2. Create the `PriceConsumerV3`contract
contract PriceConsumerV3 {

  // 1. Create a `public` variable named `priceFeed` of type `AggregatorV3Interface`.
  AggregatorV3Interface public priceFeed;

  // 2. Create a constructor
  constructor() public {
      // 3. Instantiate the `AggregatorV3Interface` contract
    priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
  }
  
  //A tuple is a way in Solidity to create a syntactic grouping of expressions.
  // Additionally, if there are variables that we are not going to use, it's often best practice to leave them as blanks, like so:(,int price,,,) = priceFeed.latestRoundData();
  //Create a public view function named getLatestPrice. The function returns an int.
  function getLatestPrice() public view returns (int){
  //Call the latestRoundData function of thepriceFeed contract, and store only the answer in an int variable named price. Exclude any other variables from being declared in our function call. If you can't remember the syntax for doing this, check the example from above. But first, try to do it without peeking.
    (,int price,,,) = priceFeed.latestRoundData();
    //Return the price variable.
    return price;
  }
  
    //make a getDecimals function that returns how many decimals this contract 
  //1.Create a public view function called getDecimals that returns the result of the decimals function from the AggregatorV3Interface. When you declare the function, keep in mind that the return value is a uint8.
  function getDecimals() public view returns (uint8) {
    //2.The first line of code should call the priceFeed.decimals() function, and store the result in a variable named decimals of type uint8.
    uint8 decimals = priceFeed.decimals();
    //3.The second line of the function should return the decimals variable.
    return decimals;
  }
  
} 
