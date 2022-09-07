// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract bookHotel{	

	address payable public owner;

	constructor(){
		owner = payable(msg.sender);
		createdefhot();
	}  

	uint256 count;
	uint256 public hcount = 5;
	bool added;

	struct Hotel{
		uint256 roomNo;		
		bool isOccupied;	
	}
		
	mapping(address => Hotel) public bookertoroom;
	mapping(string => address) public roomtobooker;
	mapping(address => uint256) public addrtoamntpaid;	
	mapping(address => uint256) public addrtoposinmapp;	

   
	Hotel[] public hotelroomsarray;
	address[] public bookers;

	Hotel public room1 = Hotel(
		{
			roomNo: 1,
			isOccupied: false			
		}
	);	

	Hotel public room2 = Hotel(
		{
			roomNo: 2,
			isOccupied: false			
		}
	);	

	Hotel public room3 = Hotel(
		{
			roomNo: 3,
			isOccupied: false			
		}
	);	

	Hotel public room4 = Hotel(
		{
			roomNo: 4,
			isOccupied: false			
		}
	);	

	Hotel public room5 = Hotel(
		{
			roomNo: 5,
			isOccupied: false			
		}
	);		

	modifier uptofee{
		uint256 fee = 500;
		require(ETHtoUSD(msg.value) >= fee, "Not enough money");
		_;
	}

	modifier onlyOwner{
		require(msg.sender == owner, "You are not the owner");
		_;
	}	

	function createdefhot() internal returns(uint256) onlyOwner{
		require(added == false, "default rooms have already been added");
		hotelroomsarray.push(room1);
		hotelroomsarray.push(room2);
		hotelroomsarray.push(room3);
		hotelroomsarray.push(room4);
		hotelroomsarray.push(room5);
		added = true;
	}	

	function newhotel(uint256 _num, bool _isoccupied) public {
		require(_num > hcount, "Room already exists");
		require(_num == hcount + 1, "Roomno must be the next number after last roomno");
		require(_isoccupied == false, "boolean must be false");		
		Hotel memory room = Hotel(_num, _isoccupied);
		hotelroomsarray.push(room);
		hcount++;
	}

	function occupy(uint256 __index) public {
		hotelroomsarray[__index - 1].isOccupied = true;
	}
	
	function deoccupy(uint256 __index) public {
		hotelroomsarray[__index - 1].isOccupied = false;
	}

	function bookroom(uint256 _index, string memory _password) public payable uptofee{
		Hotel memory wanted = hotelroomsarray[_index - 1];
		require(wanted.isOccupied == false, "This room is occupied");								
		owner.transfer(msg.value);
		bookertoroom[msg.sender] = hotelroomsarray[_index - 1];
		addrtoamntpaid[msg.sender] = msg.value;
		bookers.push(msg.sender);
		roomtobooker[_password] = msg.sender; 	
		occupy(_index);	
		count++;
		addrtoposinmapp[msg.sender] = count;
	}
	
	function leaveroom(uint256 _index, string memory _password) public{		
		Hotel memory unwanted = hotelroomsarray[_index - 1];
		uint256 unwroomNo = unwanted.roomNo;
		require(unwanted.isOccupied == true && unwroomNo == (_index) && msg.sender == roomtobooker[_password], "Error");			
		address payable wepayingto = payable(msg.sender);
		deoccupy(_index);	
		uint256 amnthispaid = retrievemap(msg.sender);	
		uint256 pos = retrievemappos(msg.sender);
		delete bookers[pos];
		count = count - 1;	
	}	

	function checkout(uint256 _index, string memory _password) public{		
		Hotel memory unwanted = hotelroomsarray[_index - 1];
		uint256 unwroomNo = unwanted.roomNo;
		require(unwanted.isOccupied == true && unwroomNo == (_index) && msg.sender == roomtobooker[_password], "Error");			
		deoccupy(_index);	
		uint256 pos = retrievemappos(msg.sender);
		delete bookers[pos];
		count = count - 1;	
	}

	function ETHtoUSD(uint256 _eth) internal pure returns(uint256){
		uint256 convertedeth = (_eth * 1716);
		return convertedeth;
	}

	function retrievebooker(string memory __password) internal view returns(address){
		address booker =  roomtobooker[__password];
		return booker;
	}		

	function retrievemap(address _addr)internal view returns(uint256){
		uint256 amnt = (addrtoamntpaid[_addr] / 1000000000000000000);
		return amnt;
	}	

  	 function retrievemappos(address _addr) internal view returns(uint256){
		   uint256 posinarr = addrtoposinmapp[_addr] - 1;
		   return posinarr;
	 }

}