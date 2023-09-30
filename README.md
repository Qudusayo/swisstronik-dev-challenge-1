# Sample Voting System Contract

This project demonstrates a basic voting system use case based on Switsstronik testnet. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

This contract allows registered users to vote on proposals (yes or no).

### Build
To compile contracts, use following command:

```shell
npx hardhat compile
```

### Testing & Deployment
Create `.env` file from example

```shell
cp .env.example .env
```

Add PRIVATE_KEY in .env with actual private key to interact with network.

To run tests, use following command:
```shell
npm run test
```

To deploy contracts, use following command:
```shell
npx hardhat run scripts/deploy.js
```  

A Sample deployed contract can be found here:  
[0xB626fC9D3d433F0e88024BCf60D45Bf92471147a](https://explorer-evm.testnet.swisstronik.com/address/0xB626fC9D3d433F0e88024BCf60D45Bf92471147a)