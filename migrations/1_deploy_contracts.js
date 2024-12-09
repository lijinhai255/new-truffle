// const MetaCoin = artifacts.require("MetaCoin");
// const InfoContract = artifacts.require("InfoContract");
const RedPacket = artifacts.require("RedPacket");

module.exports = function (deployer) {
  // deployer.deploy(MetaCoin);
  // deployer.deploy(InfoContract);
  deployer.deploy(RedPacket);
};
