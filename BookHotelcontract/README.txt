This contract has three major functions:
bookroom
leaveroom
The bookroom function enables users to book a single hotel room for a $500 fee. It also makes sure that the room that the user wants to book isn't already booked. It transfers the amount to the owner of the contract and pushes its address to the bookers array.It also maps the user's address to the room they booked, to the amount they paid and to its position in the bookers array.It takes two parameters the _index is used to access the hotelroomsarray. and the password ensures that the user who booked the room is the only one that can leave it.The roomtobooker mapping maps a user to the password.The occupy function changes the state of the room to occupied
The leaveroom function enables the user to leave a hotelroom under the condition that he/she was the one who booked it. This is powered by the password parameter passed into the bookroom function.It also It deoccupies the room to leave open for rebooking. It deletes the address of the user from the bookers array using the variable 'pos' which represents the user's index in the bookers array. It also refunds the amount paid by the user.
The checkout function is the leaveroom function without the refunding parts.
The ETHtoUSD converts the ethereum paid by the user to US dollars.
The retrieveBooker function collects the address of the the person who booked the room.
The retrievemap function collects the amount paid by a user.
The retrievemappos function collects the position in the bookers array of the user.
The newHotel function allows the user to create a new hotel room based on the Hotel struct. Due to the nature of the project, The bookroom function can only work properly when there is a consecutive follow up of hotel rooms and if the isOccupied section is false. The newHotel room ensures that the hotel room being created has a room number that follows its predecessor's and that the bool parameter is always false.
It then pushes the new room to the array.
The createdefhot function adds the default hotelrooms (room1, room2, room3, room4,and room5) to the hotelroomsarray.It is run in the constructor function and requires that the function has been run. It then disallows running it for a second time.

This project is a modified version of Dapp Universitiy's book hotel contract. Apart from the initial concept of booking a hotel room, this contract is completely different from Dapp University's.