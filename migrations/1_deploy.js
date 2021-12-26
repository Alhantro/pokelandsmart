// migrations/1_deploy.js
// SPDX-License-Identifier: MIT
const artifact = artifacts.require("Pokeland");

module.exports = function (deployer) {
  deployer.deploy(artifact, "PokelandTest1", "PLNDT1");
};
