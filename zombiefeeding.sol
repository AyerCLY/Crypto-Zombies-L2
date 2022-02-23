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
  

//Storage refers to variables stored permanently on the blockchain. 
//Memory variables are temporary, and are erased between external function calls to your contract. Think of it like your computer's hard disk vs RAM.
//When a zombie feeds on some other lifeform, its DNA will combine with the other lifeform's DNA to create a new zombie.  
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];

//The formula for calculating a new zombie's DNA is simple: the average between the feeding zombie's DNA and the target's DNA.
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }
}
