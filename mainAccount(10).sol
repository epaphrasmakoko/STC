// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MainAccount {
    address public ADMIN;
    address public CEO;
    uint256 public totalTransactions = 0;
    uint256 public totalIncome = 0;
    uint256 public totalIncomeTransactions = 0;
    uint256 public totalSalaries = 0;
    uint256 public totalSalariesTransactions = 0;
    uint256 public totalAmountRequests = 0;
    uint256 public totalRequestsTransactions = 0;
    uint256 public approvedRequests = 0;
    uint256 public rejectedRequests = 0;
    uint256 public pendingRequests = 0;

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
        string role;
    }

    mapping(address => User) public users;
    mapping(string => bool) public usernameExists; // New mapping to track existing usernames
    mapping(string => uint256) public usernameToSalary; // Mapping from username to salary
    mapping(address => string) public userNames; // Mapping UserNames to Address
    address[] public userAddresses;
    User[] public userDetails;

    // Event to log user registration
    event UserRegistered(string username, address userAddress, uint256 salary);

    // Function to register a new user
    function registerUser(string memory _username, address _userAddress, uint256 _salaryInEther, string memory _role) external onlyAdmin {
        require(users[_userAddress].userAddress == address(0), "User already registered");
        require(!usernameExists[_username], "Username already exists");

        // Convert Ether value to Wei
        uint256 _salary = _salaryInEther * 1 ether;

        // Create a new user
        User memory newUser = User({
            username: _username,
            userAddress: _userAddress,
            salary: _salary,
            role: _role
        });

        // Add the user to the mapping (can be deleted)
        users[_userAddress] = newUser;

        // Add the user's address to the array
        userAddresses.push(_userAddress);

        // Mark the username as existing (can be deleted)
        usernameExists[_username] = true;

        // Mark the user's address as registered (can be deleted)
        registeredAddresses[_userAddress] = true;

        // Add user details to the array
        userDetails.push(newUser);

        // Add the username and salary to the mapping (can be deleted)
        usernameToSalary[_username] = _salary;

        // Add user role to the mapping (can be deleted)
        userRoles[_userAddress] = _role;

        // Add user name to the mapping
        userNames[_userAddress] = _username;

        // Check if the registered user has the username "CEO" or "ceo"
        if (keccak256(bytes(_username)) == keccak256(bytes("CEO")) || keccak256(bytes(_username)) == keccak256(bytes("ceo"))) {
            CEO = _userAddress; // Assign the address to CEO
        }
        
        // Emit an event to log the registration
        emit UserRegistered(_username, _userAddress, _salary);
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


//////////////////////////////////////////////
// Start Function to delete a user by admin///
//////////////////////////////////////////////

// Event to log user deletion
event UserDeleted(address userAddress);

function deleteUser(address _userAddress) external onlyAdmin {
    // Check if the user exists
    require(registeredAddresses[_userAddress], "User does not exist");

    // Find the index of the user in the userAddresses array
    uint256 userIndex;
    for (uint256 i = 0; i < userAddresses.length; i++) {
        if (userAddresses[i] == _userAddress) {
            userIndex = i;
            break;
        }
    }

    // Remove the user from the userAddresses array
    if (userIndex < userAddresses.length - 1) {
        userAddresses[userIndex] = userAddresses[userAddresses.length - 1];
    }
    userAddresses.pop();

    // Find the index of the user in the userDetails array
    uint256 userDetailsIndex;
    for (uint256 i = 0; i < userDetails.length; i++) {
        if (userDetails[i].userAddress == _userAddress) {
         userDetailsIndex = i;
         break;
        }
    }

// Remove the user details from the userDetails array
if (userDetailsIndex < userDetails.length - 1) {
    userDetails[userDetailsIndex] = userDetails[userDetails.length - 1];
}
userDetails.pop();


    // Remove the user from other mappings
    delete userNames[_userAddress];
    delete usernameExists[users[_userAddress].username];
    delete registeredAddresses[_userAddress];
    delete usernameToSalary[users[_userAddress].username];
    delete userRoles[_userAddress];
    delete users[_userAddress];

    // Check if the user being deleted is the CEO and reset the CEO variable
    if (CEO == _userAddress) {
        CEO = address(0); // Set to an empty address
    }

    // Emit an event to log the user deletion
    emit UserDeleted(_userAddress);
}

////////////////////////////////////////////
// END Function to delete a user by admin///
////////////////////////////////////////////



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
        totalIncome = totalIncome + msg.value;
        totalIncomeTransactions = totalIncomeTransactions + 1;
        totalTransactions = totalTransactions + 1;
        emit FundsAdded(msg.sender, msg.value);
    }
///////////////////////////////////////////////////////////////////////////
/////////////// End Adding Funds to Contract Function ////////////////////
//////////////////////////////////////////////////////////////////////////



/////////////// Start Salary Distribution Function ////////////////////
    function distributeSalary() external payable onlyCEO {
        address employee;
        uint256 amount;

        require(balances[address(this)] >= amount, "Insufficient funds for salary");
        payable(ADMIN).transfer(ADMIN_SALARY);
        balances[address(this)] -= ADMIN_SALARY;
        balances[ADMIN] += ADMIN_SALARY;
        totalSalaries = totalSalaries + ADMIN_SALARY;
        totalSalariesTransactions = totalSalariesTransactions + 1;
        totalTransactions = totalTransactions + 1;

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
            totalSalaries = totalSalaries + amount;
            totalSalariesTransactions = totalSalariesTransactions + 1;
            totalTransactions = totalTransactions + 1;

            emit SalaryDistributed(employee, amount);

        }
    }
/////////////// End Salary Distribution Function ////////////////////

//////////////////////////////////////////////////////////////////////////
///////////////////////////Start of REQUEST FUNCTION//////////////////////
//////////////////////////////////////////////////////////////////////////
    enum RequestStatus { Pending, Approved, Rejected }

    struct Request {
        uint256 id;
        address user;
        uint256 amountWei; // Amount in Wei
        string details;
        RequestStatus status;
    }

    mapping(uint => Request) public requests;
    uint public requestCounter;

    event RequestCreated(uint requestId, address indexed user, uint256 amountWei, string details);
    event RequestProcessed(uint requestId, RequestStatus status);
    event Withdrawal(address indexed user, uint256 amountWei);

    function requestMoney(uint256 _amountWei, string memory _details) external {
        requestCounter++;
        pendingRequests++;
        requests[requestCounter] = Request(requestCounter, msg.sender, _amountWei, _details, RequestStatus.Pending);
        emit RequestCreated(requestCounter, msg.sender, _amountWei, _details);
    }

    function processRequest(uint requestId, bool isApproved) external onlyCEO {
        require(requestId <= requestCounter, "Invalid request ID");
        require(requests[requestId].status == RequestStatus.Pending, "Request has already been processed");
        
        if (isApproved) {
            // Convert Wei to Ether before transferring funds to the user
            uint256 amountEther = requests[requestId].amountWei * 1 ether;
            
            // Transfer funds to the user
            payable(requests[requestId].user).transfer(amountEther);
            balances[address(this)] -= amountEther;
            totalAmountRequests = totalAmountRequests + amountEther;
            totalTransactions++;
            approvedRequests++;
            totalRequestsTransactions++;
            pendingRequests--;
            
            emit Withdrawal(requests[requestId].user, requests[requestId].amountWei);
            requests[requestId].status = RequestStatus.Approved;
        } else {
            requests[requestId].status = RequestStatus.Rejected;
            totalTransactions++;
            rejectedRequests++;
            totalRequestsTransactions++;
            pendingRequests--;

        }

        emit RequestProcessed(requestId, requests[requestId].status);
    }

//////////////////////////////////////////////////////////////////////////
///////////////////////////End of REQUEST FUNCTION////////////////////////
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
////////////////////////// DASHBOARD FUNCTIONS ///////////////////////////
//////////////////////////////////////////////////////////////////////////

        //function to get Balance of the Main Account aka this contract
    function getBalance() external view returns (uint256) {
        return balances[address(this)];
    }

        //Function to get all total transactions
    function TotalTransactions() external view returns (uint256) {
        return totalTransactions;
    }

        // Function to get the count of registered users
    function getUserCount() external view returns (uint256) {
        return 1 + userAddresses.length;
    }

        // function to get total salary distributed in particular month
    function TotalSalariesDistributed() external view returns (uint256) {
        return totalSalaries;
    }

        // function to get total salary transactions distributed in particular month
    function TotalSalariesTransactions() external  view returns  (uint256) {
        return totalSalariesTransactions;
    }

        //Function to get total fund added to main contract 
    function TotalIncome() external view returns (uint256)  {
        return totalIncome;
    }

        //Function to get total fund Transactions added to main contract 
    function TotalIncomeTransactions() external view returns (uint256)  {
        return totalIncomeTransactions;
    }

    function TotalAmountRequests() external view returns (uint256)  {
        return totalAmountRequests;
    }

        //Function to get total requests
    function TotalRequests() external view returns (uint256)  {
        return totalRequestsTransactions;
    }

        //Function to get approved requests
    function ApprovedRequests() external view returns (uint256)  {
        return approvedRequests;
    }

        //Function to get rejected requests
    function RejectedRequests() external view returns (uint256)  {
        return rejectedRequests;
    }

        //Function to get pending requests
    function PendingRequests() external view returns (uint256)  {
        return pendingRequests;
    }
        // Function to get the name of a registered user
    function getUserName(address userAddress) external view returns (string memory) {
        if (userAddress == ADMIN) {
            return "Admin";
        }
        return userNames[userAddress];
    }
}