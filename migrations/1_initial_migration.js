const Migrations = artifacts.require("Migrations");
const BatchTransfer = artifacts.require("BatchTransfer");
// [BatchTransfer, 0x0ac26115fEacba375dA2eF39648A87A30519dCB9]
module.exports = function (deployer) {
  deployer.deploy(Migrations).then(function () {
    return deployer.deploy(BatchTransfer, "0x0ac26115fEacba375dA2eF39648A87A30519dCB9")
  })
};