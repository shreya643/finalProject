pragma solidity ^0.5.0;

contract users{
    
    struct Users{
        string username;
        string password;
        string email;
    }

    mapping(address=>Users) user_id;
    address owner;

    constructor() public {
        owner = msg.sender;
        user_id[owner].username='district';
        user_id[owner].password='districtOwner';
        user_id[owner].email='email@email.com';

        // user_id[''].username='district';
        // user_id[''].password='districtOwner';

        // user_id[''].username='district';
        // user_id[''].password='districtOwner';
    }

    
    modifier verifyUser(string memory username, string memory email){
        require(keccak256(abi.encodePacked((user_id[msg.sender].username)))==keccak256(abi.encodePacked((username))));
        require(keccak256(abi.encodePacked((user_id[msg.sender].email)))==keccak256(abi.encodePacked((email))));
        _;   
    }
    

    function login(string memory username, string memory password) 
    view
    public
     returns (bool){
        if(keccak256(abi.encodePacked((user_id[msg.sender].username)))==keccak256(abi.encodePacked((username)))){
        if(keccak256(abi.encodePacked((user_id[msg.sender].password)))==keccak256(abi.encodePacked((password)))){
            return true;
        }
        else{
            return false;
        }
        }
        else{
            return false;
        }
    }   

    function changePassword(string memory username, string memory email,string memory new_password) 
    public
    verifyUser(username,email)
    returns (bool){
            user_id[msg.sender].password=new_password;
            return true;
    }
}