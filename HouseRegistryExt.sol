// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./HouseRegistry.sol";

contract HouseRegistryExt is HouseRegistry{

//Функция listHouseSimple вызовет функцию listHouse из контракта HouseRegistry
//В качестве параметра принимающая адресс вызывшего функцию, как продавца дома

	function listHouseSimple(uint _housePrice, uint _houseArea,
     string memory _houseAddress ) public returns (uint){		            
		 return  listHouse (_housePrice, _houseArea,
		 msg.sender, _houseAddress );    
	}
}
