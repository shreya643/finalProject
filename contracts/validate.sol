pragma solidity ^0.5.16;
contract validate{
  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  struct Details{
    string id;
    string docType;
    string docOwner;
  }
//mapping documents hash to the address
  mapping (bytes32 => address) public records;

//mapping documents hash to timestamp of block creation
  mapping (bytes32 => uint256) public timestamps;
  mapping (bytes32 => Details) public belongsTo;

  event LogRecorded(bytes32 indexed record, address indexed certifier, uint256 timestamp);

/// @notice Stores the given hash in Blockchain
/// @dev stores address of function caller and blocks timestamp is stored via mapping and emits LogCertified event 
/// @param _record Hash of the given document
  function recordFile(bytes32 _record,string memory _doc,string memory _docOwner, string memory _id) public {
    bytes32 hash = keccak256(abi.encodePacked(_record));
    require(hash != keccak256(""),"input is invalid");
    require(records[hash] == address(0),"this record have already been certified");
    records[hash] = msg.sender;
    timestamps[hash] = block.timestamp;
    belongsTo[hash].docType = _doc;
    belongsTo[hash].docOwner = _docOwner;
    belongsTo[hash].id = _id;
    emit LogRecorded(hash, msg.sender, block.timestamp);
  }

/// @notice checks if hash already exists on smart contract
/// @dev hash the given record and checks if it maps to any address
/// @param _record Hash of the given document
/// @return bool value explaining whether hash already exists or not
  function exists(bytes32 _record) view public returns (bool) {
    bytes32 hash = keccak256(abi.encodePacked(_record));
    return records[hash] != address(0);
  }

/// @notice get the certifier of the Document
/// @dev checks the address mapped with given parameter
/// @param _record Hash of the given document
/// @return address of the certifier
  function getRecorder(bytes32 _record) view public returns (address) {
    return records[keccak256(abi.encodePacked(_record))];
  }

/// @notice get the timestamp when document is certified
/// @dev checks the timestamp mapped with given parameter
/// @param _record Hash of the given document
/// @return timestamp of the document certification
  function getTimestamp(bytes32 _record) view public returns (uint256) {
    return timestamps[keccak256(abi.encodePacked(_record))];
  }


/// @notice check whether the function caller certify the given record
/// @dev checks whether the hash mapped with address equals msg.sender or not
/// @param _record Hash of the given document
/// @return  bool value explaining whether the given record certified by function caller or not
  function didRecord(bytes32 _record) view public returns (bool) {
    return records[keccak256(abi.encodePacked(_record))] == msg.sender;
  }

/// @notice check whether the given address is certifier of given record
/// @dev checks whether the hash mapped with given record equals given address
/// @param _record Hash of the given document
/// @param _certifier Address of document certifier
/// @return  bool value explaining whether the given record certified by given address or not
  function isRecorder(bytes32 _record, address _certifier) view public returns (bool) {
    return records[keccak256(abi.encodePacked(_record))] == _certifier;
  }

}
