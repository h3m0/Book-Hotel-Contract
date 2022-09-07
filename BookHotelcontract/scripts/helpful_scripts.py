from brownie import accounts, network, LOTTERY, config
from web3 import Web3

def get_account():
	if network.show_active() == 'development':
		account = accounts[0]
	else:
		account = config["wallets"]["from_key"]

def deploy_mocks():
	print(f"The active network is {network.show_active()}")
	print("deploying mocks")
	if len(MockAggregrator) <= 0:
		MockAggregrator.deploy(18, Web3.toWei("2000", "ether"), {"from": get_account()})
	print("Mocks deployed!")