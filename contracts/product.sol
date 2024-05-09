// SPDX-License-Identifier: UNLICENSED
pragma solidity  ^0.8.24;

contract product {
 string public name;
 string public description;
 uint public price; 
 address public owner;
 uint public productSold;
 uint120 private productCount;


    event ProductSold(string name, string description, uint price, address owner, uint productSold);

constructor( string memory _name, string memory _description, uint _price){
 name = _name;
    description = _description;
    price = _price;
    owner = msg.sender;

}

   function buyProduct() public payable {
        
    require(msg.value >= price , "Insufficient funds");
    require(msg.sender != owner, "You are the owner of this product");
    payable(owner).transfer(msg.value);
    productSold++;
    emit ProductSold(name, description, price, owner, productSold);
 }

    function getProduct() public view returns(string memory, string memory, uint, address, uint){
        return(name, description, price, owner, productSold);
    }

function updateProduct(string memory _name, string memory _description, uint _price) public {
    require(msg.sender == owner, "You are not the owner of this product");
    name = _name;
    description = _description;
    price = _price;
    }

  modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this product");
        _;
    }

    function withdraw() public onlyOwner {
        require(msg.sender == owner, "You are not the owner of this product");
        payable(owner).transfer(address(this).balance);
    }


}