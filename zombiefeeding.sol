pragma solidity >=0.5.0 <0.6.0;

// put import statement here
import "./zombiefactory.sol";

//interface 1) use (;) at the end in order to differciated from contract 2) only copy the useful function from whole contract
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

//Make a contract called ZombieFeeding , This contract should inherit from our ZombieFactory contract.
contract ZombieFeeding is ZombieFactory {

//The address of CryptoKitties contract in Etherem

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

// Initialize kittyContract here using `ckAddress` from above

  KittyInterface kittyContract = KittyInterface(ckAddress);

// Now `kittyContract` is pointing to the other contract
// Now we can call `getKitty` from that contract:
//Let's make it so zombies made from kitties have some unique feature that shows they're cat-zombies.To do this, we can add some special kitty code in the zombie's DNA.
//use the last 2 unused digits(in 16 digits) to handle "special" characteristics. We'll say that cat-zombies have 99 as their last two digits of DNA (since cats have 9 lives). 
//So in our code, we'll say if a zombie comes from a cat, then set the last two digits of DNA to 99. Modify function definition here (add the 3rd argument):
  
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {

//Storage refers to variables stored permanently on the blockchain. 
//Memory variables are temporary, and are erased between external function calls to your contract. Think of it like your computer's hard disk vs RAM.
//When a zombie feeds on some other lifeform, its DNA will combine with the other lifeform's DNA to create a new zombie.  

    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];

//The formula for calculating a new zombie's DNA is simple: the average between the feeding zombie's DNA and the target's DNA.

    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    
// Remember with the strings (the 3rd argument), we have to compare their keccak256 hashes
// to check equality
// Add an if statement here

    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))){
        newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

// Let's make a function that gets the kitty genes from the contract:

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
      uint kittyDna;
//if we only cared about one of the values
//We can just leave the other fields blank:
      (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
// And modify function call here:Lastly, we need to change the function call inside feedOnKitty. When it calls feedAndMultiply, add the parameter "kitty" to the end.
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
  
}
