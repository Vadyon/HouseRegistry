// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract HouseRegistry{    
    uint idModulus = 10 ** 5;
//структура для хранения информации о доме
    struct HouseItem {        
        uint houseId;
        uint housePrice;
        uint houseArea;
        address walletAddress;
        string houseAddress;
    }
//массив для хранения данных домов
    HouseItem[]  public  houses;
//Функция добавления новых домов в массив
    function listHouse (uint _housePrice, uint _houseArea,
    address _walletAddress, string memory _houseAddress )  
    public returns(uint _houseId ) {
        _houseId = houseIdGeneration( _walletAddress, _houseArea, _houseAddress);
        houses.push(HouseItem(_houseId, _housePrice, _houseArea, 
        _walletAddress, _houseAddress));
        return  _houseId; 
    }
//Функция генерирования унуникального ID дома
    function  houseIdGeneration(address _walletAddress, uint _houseArea,
    string memory _houseAddress) public view returns
     (uint _houseId){
		string memory strHouseArea = uint2str( _houseArea );		
        string memory walletAddressString = toAsciiString(_walletAddress);
        bytes32 _houseIdbytes = hash(concatenate(walletAddressString,
        strHouseArea, _houseAddress));	
		               
        _houseId = uint(_houseIdbytes);
        
        _houseId = _houseId % idModulus;

    return _houseId;
    } 

//Функция конвертации uint to string
    function uint2str( uint256 _i ) public  pure  returns
     (string memory str){
        if (_i == 0){
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0){
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        j = _i;
        while (j != 0){
            bstr[--k] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }
        str = string(bstr); 
    }
//Функция конкатенции строк
    function concatenate(string memory a,string memory b,string memory c) public pure returns
     (string memory){
        return string(abi.encodePacked(a,'',b,'',c));
    }
//Функция получения хэш keccak256 из строки
    function hash(string memory _string) public pure returns(bytes32) {  
       return keccak256(abi.encodePacked(_string));
    }  
//Функция конвертации bytes to uint
    function bytesToUint(bytes memory b) public pure returns (uint256){
        uint256 number;
        for(uint i=0;i<b.length;i++){
            number = number + uint8(b[i]);
        }
        return number;
    }
    //Функция конвертации address to string
    function toAsciiString(address x) public pure returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
        bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
        bytes1 hi = bytes1(uint8(b) / 16);
        bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
        s[2*i] = char(hi);
        s[2*i+1] = char(lo);            
    }
    return string(abi.encodePacked("0x",s));
    } 
    function char(bytes1 b) public pure returns (bytes1 c) {

        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }
}
