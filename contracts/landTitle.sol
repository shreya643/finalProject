pragma solidity ^0.5.0;
contract landTitle {
    
   struct Deeds{
       string owner_name;
       string land_type;
       string district;
       string municipality;
       uint ward_no;
       uint plot_no;
   }
   
    mapping(uint=>Deeds) register_id;
    mapping(uint=>string) new_owner;
    
    address public owner;
    uint plot_count;

    constructor() public {
        owner = msg.sender;
        plot_count=0;
    }
    
    modifier verifyOwner(){require(msg.sender==owner);_;}
    
    modifier checkForRegistration(uint plot_no){
        uint flag=0;
        uint i;
        for(i=0; i < plot_count; i++) {
            if(register_id[i].plot_no==plot_no)
            {
                flag=1;
            }
            
        }
        require(flag==0);
        _;
    }
    
    function getDetails(uint _id) view public returns (string memory name, string memory land , string memory district , string memory municipality ,uint ward, uint  plot ) {
         name=register_id[_id].owner_name;
        land=register_id[_id].land_type;
        district=register_id[_id].district;
         municipality=register_id[_id].municipality;
         ward=register_id[_id].ward_no;
         plot=register_id[_id].plot_no;
        return (name,land,district,municipality,ward,plot);
    }
 
    function registerLand(uint id,string memory owner_name, string memory land_type, string memory district, string memory municipality, uint ward_no, uint plot_no) 
    verifyOwner()
    checkForRegistration(plot_no) 
    public 
    returns (bool){
        register_id[id].owner_name=owner_name;
        register_id[id].land_type=land_type;
        register_id[id].district=district;
        register_id[id].municipality=municipality;
        register_id[id].ward_no=ward_no;
        register_id[id].plot_no=plot_no;
        plot_count+=1;
        return true;
    }

    function changeOwnership(uint id, string memory owner_new) public verifyOwner() returns(bool){
        register_id[id].owner_name=owner_new;
        return true;
    }       
}
