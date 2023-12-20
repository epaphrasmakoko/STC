// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MainAccount {
    address public ADMIN;
    address public CEO;
    uint256 public totalTransactions = 0;
    uint256 public totalDeposits = 0;
    uint256 public totalSalaries = 0;

    mapping(address => uint256) public balances;
    mapping(address => bool) public registeredAddresses; // New mapping to track registered addresses
    mapping(address => string) public userRoles;         // Mapping to store user roles
    uint256 public constant ADMIN_SALARY = 1.5 ether;

/////////////// Start constructors, Events, Authority Modifiers and Receive Special function(s) ////////////////////
    constructor() {
        ADMIN = msg.sender;
    }

    // Fallback function to handle incoming Ether
    receive() external payable {
        emit FundsAdded(msg.sender, msg.value);
    }

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == ADMIN, "You are Not The Admin of The STC System");
        _;
    }

    modifier onlyCEO() {
        require(msg.sender == CEO, "Not CEO Of The Company");
        _;
    }

    modifier onlyAuthorized() {
        require( msg.sender == ADMIN || msg.sender == CEO, "Not authorized" );
        _;
    }

    event FundsAdded(address indexed account, uint256 amount);
    event SalaryDistributed(address indexed employee, uint256 amount);
/////////////// End constructors, Events, Authority Modifiers and Receive Special function(s) ////////////////////




////////////////////////////
//Start of user registration
////////////////////////////
    struct User {
        string username;
        address userAddress;
        uint256 salary;
    }

    mapping(address => User) public users;
    mapping(string => bool) public usernameExists; // New mapping to track existing usernames
    mapping(string => uint256) public usernameToSalary; // Mapping from username to salary
    address[] public userAddresses;
    User[] public userDetails;

    // Event to log user registration
    event UserRegistered(string username, address userAddress, uint256 salary);
    //modifier
    modifier registersOnly() {
        require( msg.sender == ADMIN );
        _;
    }

    // Function to register a new user
    function registerUser(string memory _username, address _userAddress, uint256 _salaryInEther, string memory _role) external registersOnly {
        require(users[_userAddress].userAddress == address(0), "User already registered");
        require(!usernameExists[_username], "Username already exists");

        // Convert Ether value to Wei
        uint256 _salary = _salaryInEther * 1 ether;

        // Create a new user
        User memory newUser = User({
            username: _username,
            userAddress: _userAddress,
            salary: _salary
        });

        // Add the user to the mapping
        users[_userAddress] = newUser;

        // Add the user's address to the array
        userAddresses.push(_userAddress);

        // Mark the username as existing
        usernameExists[_username] = true;

        // Mark the user's address as registered
        registeredAddresses[_userAddress] = true;

        // Add user details to the array
        userDetails.push(newUser);

        // Add the username and salary to the mapping
        usernameToSalary[_username] = _salary;

        // Add user role to the mapping
        userRoles[_userAddress] = _role;

        // Check if the registered user has the username "CEO" or "ceo"
        if (keccak256(bytes(_username)) == keccak256(bytes("CEO")) || keccak256(bytes(_username)) == keccak256(bytes("ceo"))) {
            CEO = _userAddress; // Assign the address to CEO
        }
        
        // Emit an event to log the registration
        emit UserRegistered(_username, _userAddress, _salary);
    }

    // Function to get the count of registered users
    function getUserCount() external view returns (uint256) {
        return userAddresses.length;
    }

    // Function to view all registered users
    function viewAllUsers() external view returns (User[] memory) {
        User[] memory allUsers = new User[](userAddresses.length);

        for (uint256 i = 0; i < userAddresses.length; i++) {
            allUsers[i] = users[userAddresses[i]];
        }

        return allUsers;
    }
//////////////////////////
//End of user registration
/////////////////////////




/////////////////////////////////////
// Function to get the role of a user
/////////////////////////////////////
    function getUserRole(address _userAddress) external view returns (string memory) {
        if (_userAddress == ADMIN){
            return "admin";
        }
        else {
            return userRoles[_userAddress];
        }
    }
/////////////////////////////////////
/////////////////////////////////////
/////////////////////////////////////




///////////////////////////////
//Start of Login Function/////
/////////////////////////////

    // Function to check if an address is registered
    function isAddressRegistered(address _userAddress) external view returns (bool) {
    return _userAddress == ADMIN || registeredAddresses[_userAddress];
    }

/////////////////////////////
//End of Login function/////
///////////////////////////


////////////////////////////////////////////////////////////////////////////
/////////////// Start Adding Funds to Contract Function ////////////////////
////////////////////////////////////////////////////////////////////////////
    function addFunds() external payable {
        require(msg.value > 0, "Amount should be greater than zero");
        balances[address(this)] += msg.value;
        totalDeposits = totalDeposits + 1 ;
        emit FundsAdded(msg.sender, msg.value);
    }
///////////////////////////////////////////////////////////////////////////
/////////////// End Adding Funds to Contract Function ////////////////////
//////////////////////////////////////////////////////////////////////////



/////////////// Start Salary Distribution Function ////////////////////
    function distributeSalary() external payable onlyAuthorized {
        address employee;
        uint256 amount;

        require(balances[address(this)] >= amount, "Insufficient funds for salary");
        payable(ADMIN).transfer(ADMIN_SALARY);
        balances[address(this)] -= ADMIN_SALARY;
        balances[ADMIN] += ADMIN_SALARY;
        totalTransactions = totalTransactions + 1;
        totalSalaries = totalSalaries +1 ;

        emit SalaryDistributed(ADMIN, ADMIN_SALARY);

        for (uint256 i = 0; i < userAddresses.length; i++) {
            employee = userAddresses[i];
            amount = users[employee].salary;

            // Ensure the contract has enough funds
            require(balances[address(this)] >= amount, "Insufficient funds for salary");

            // Transfer salary to the employee
            payable(employee).transfer(amount);

            // Distribute the salary based on the role
            balances[address(this)] -= amount;
            balances[employee] += amount;
            totalSalaries = totalSalaries +1 ;
            totalTransactions = totalTransactions + 1;

            emit SalaryDistributed(employee, amount);

        }
    }
/////////////// End Salary Distribution Function ////////////////////

    // function distributeExpense (){

    // }


    function infromation() external view returns (uint256) {
        return balances[address(this)];
        // return totalTransactions;
        // return totalDeposits
        
    }
}
