var landTitle = artifacts.require("landTitle");
var users = artifacts.require("users");
var validate = artifacts.require("validate");

module.exports = function(deployer) {
  deployer.deploy(landTitle);
  deployer.deploy(users);
  deployer.deploy(validate);
};