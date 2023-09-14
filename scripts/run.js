const main = async () => {
	const [owner, randomPerson] = await hre.ethers.getSigners();
	const invitationContract = await hre.ethers.deployContract("InvitationPortal");
	await invitationContract.waitForDeployment();
	console.log("Contract deployed to:", invitationContract.target);
	console.log("Contract deployed by:", owner.address);

	let confirmationsCount;
	confirmationsCount = await invitationContract.getTotalConfirmations();

	let confirmationTxn = await invitationContract.confirm("Hi! I'm happy to go");
	await confirmationTxn.wait();

	confirmationsCount = await invitationContract.getTotalConfirmations();

	confirmationTxn = await invitationContract.connect(randomPerson).confirm("Yes!");
	await confirmationTxn.wait();

	confirmationsCount = await invitationContract.getTotalConfirmations();

	let allConfirmations = await invitationContract.getAllConfirmations();
  console.log(allConfirmations);
};

main().catch((error) => {
	console.error(error);
	process.exitCode = 1;
});