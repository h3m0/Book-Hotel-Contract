from brownie import accounts, network, bookHotel

def test_crcreatedefhot():
	# arrange
	account = accounts[0]
	deploy_txn = bookHotel.deploy({"from": account})
	# act
	createdefhot_txn = deploy_txn.createdefhot({"from": account})
	# assert
	assert createdefhot_txn = 5