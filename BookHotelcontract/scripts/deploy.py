from brownie import accounts, network, bookHotel, config
from web3 import Web3

def deploy_contract():
	account = accounts.add(config["wallets"]["from_key"])
	# account = accounts[0]
	deploy_txn = bookHotel.deploy({"from": account})
	# createdefhot_txn = deploy_txn.createdefhot({"from": account})
	
def main():
	deploy_contract()