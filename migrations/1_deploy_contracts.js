const MetaCoin = artifacts.require("MetaCoin");
const InfoContract = artifacts.require("InfoContract");

module.exports = function (deployer) {
  deployer.deploy(MetaCoin);
  deployer.deploy(InfoContract);
};
