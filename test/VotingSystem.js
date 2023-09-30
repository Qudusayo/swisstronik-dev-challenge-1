const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("VotingSystem", function () {
  let VotingSystem;
  let votingSystem;
  let owner;
  let voter1;
  let voter2;

  beforeEach(async function () {
    [owner, voter1, voter2] = await ethers.getSigners();

    // Deploy the VotingSystem contract
    VotingSystem = await ethers.getContractFactory("VotingSystem");
    votingSystem = await VotingSystem.deploy(owner.address);

    // Register voters
    await votingSystem.connect(owner).registerVoter(voter1.address);
    await votingSystem.connect(owner).registerVoter(voter2.address);
  });

  it("should allow registered voters to vote", async function () {
    await votingSystem.connect(voter1).vote(true);
    const [yesVotes, noVotes] = await votingSystem.getVoteCount();
    expect(yesVotes).to.equal(1);
    expect(noVotes).to.equal(0);
  });

  it("should not allow a registered voter to vote twice", async function () {
    await votingSystem.connect(voter1).vote(true);
    await expect(votingSystem.connect(voter1).vote(true)).to.be.revertedWith(
      "You have already voted"
    );
  });

  it("should not allow unregistered voters to vote", async function () {
    await expect(
      votingSystem.connect(ethers.Wallet.createRandom()).vote(true)
    ).to.be.revertedWith("Only registered voters can call this function");
  });
});
