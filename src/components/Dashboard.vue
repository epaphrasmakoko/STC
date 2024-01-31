<template>
  <div id="dashboard">
    <div v-if="!isUser && !isAdmin && !isCEO" id="connect">
    <button class="btn btn-dark" @click="connectMetaMask"><strong>Connect To Your Metamask Wallet</strong></button>
    </div>
    <div v-if="isAdmin" class="admin-btns" style="background-color: #11235A;">
      <!-- Specific Features for Admin -->
      <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#viewModal">View
        Users</button>
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registerModal">Register
        User</button>
      <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">Delete
        User</button>

      
      <!-- Modal -->
      <div class="modal fade" id="viewModal" role="dialog">
        <div class="modal-dialog modal-lg">
          <!-- Modal content -->
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Total Users: <strong>{{NumberOfUser}}</strong></h4>
              <button style="color: white;" id="closeIcon" type="button" class="btn btn-close" data-bs-dismiss="modal"
                data-dismiss="modal"></button>
            </div>
            <div class="modal-body">
              <div class="admin-users">
                <table class="table table-bordered table-hover table-dark">
                  <thead>
                   <tr>
                   <th>Username</th>
                   <th>Address</th>
                   <th>Salary (Ether)</th>
                   <th>Role</th>
                   </tr>
                  </thead>
                <tbody>
                  <tr v-for="user in allUsers" :key="user.address">
                   <td>{{ user.username }}</td>
                   <td>{{ user.address }}</td>
                   <td>{{ user.salary / 1e18 }}</td>
                   <td>{{ user.role }}</td>
                   </tr>
                </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      

      <!-- Delete User Modal -->
      <div class="modal fade" id="deleteModal" role="dialog">
        <div class="modal-dialog">
          <!-- Modal content -->
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Delete User</h4>
              <button style="color: white;" id="closeIcon" type="button" class="btn btn-close" data-bs-dismiss="modal"
                data-dismiss="modal"></button>
            </div>
            <div class="modal-body">
              <!-- Delete user by providing Address of the User -->
              <form @submit.prevent="deleteUser">
                <div class="form-group">
                  <label for="address">Address:</label>
                  <input type="text" class="form-control" id="address" v-model="deleteUserAddress" required>
                </div>
                <div class="form-footer">
                  <button type="submit" class="btn btn-danger">Delete</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>


      <!--Register User Modal -->
      <div class="modal fade" id="registerModal" role="dialog">
        <div class="modal-dialog">
          <!-- Modal content -->
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Fill User Information</h4>
              <button style="color: white;" id="closeIcon" type="button" class="btn btn-close" data-bs-dismiss="modal"
                data-dismiss="modal"></button>
            </div>
            <div class="modal-body">
              <!-- Input fields for user information -->
              <form @submit.prevent="submitUser">
                <div class="form-group">
                  <label for="username">Username</label>
                  <input type="text" class="form-control" id="username" v-model="newUser.username" required>
                </div>
                <div class="form-group">
                  <label for="address">Address</label>
                  <input type="text" class="form-control" id="address" v-model="newUser.address" required>
                </div>
                <div class="form-group">
                  <label for="salary">Salary</label>
                  <input type="number" class="form-control" id="salary" v-model="newUser.salary" step="0.01" min="0"
                    placeholder="Ether Amount in Ether" required>
                </div>
                <div class="form-group">
                  <label for="role">Role</label>
                  <select class="form-control" name="role" id="role" v-model="newUser.role" required>
                    <option value="" disabled>Select a role</option>
                    <option value="CEO">CEO</option>
                    <option value="user">User</option>
                  </select>
                </div>
                <div class="form-footer">
                  <button type="submit" class="btn btn-success">Submit</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="isCEO || isUser || isAdmin" class="top" style="background-color: #11235A;">
      <!-- Specific Features for CEO -->
      <div class="request-btns">
        <button v-if="isUser || isAdmin || isCEO" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#requestModal">Request Money</button>
        <button v-if="isCEO" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#approvalModal">Approvals</button>
        <button v-if="isCEO" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#depositModal">Deposits</button>
        <button v-if="isCEO" class="btn btn-danger" @click="distributeSalaries">Distribute Salaries</button>



        <!-- view Deposits Modal -->
        <div class="modal fade" id="depositModal" role="dialog">
          <div class="modal-dialog modal-lg">
            <!-- Modal content -->
            <div class="modal-content">
              <div class="modal-header">
                <h4 class="modal-title">Total Deposits: <strong>{{TotalIncome}} Ethers</strong></h4>
                <button style="color: white;" id="closeIcon" type="button" class="btn btn-close" data-bs-dismiss="modal"
                  data-dismiss="modal"></button>
              </div>
              <div class="modal-body">
                <div class="user-requests">
                  <h1 class="title">Deposits</h1>
                 <table class="table table-bordered table-hover table-dark table-lg">
                  <thead>
                   <tr>
                   <th>Request ID</th>
                   <th>Address</th>
                   <th>Amount (Ether)</th>
                   <th>Details</th>
                   </tr>
                  </thead>
                 <tbody>
                  <tr v-for="DepositTransaction in depositList" :key="DepositTransaction.id">
                  <td>{{ DepositTransaction.id }}</td>
                  <td>{{ DepositTransaction.depositor }}</td>
                  <td>{{ Number(DepositTransaction.amount.toString()) / 1e18 }}</td>
                  <td>{{ DepositTransaction.details }}</td>
                 </tr>
                 </tbody>
                 </table>
              </div>
              </div>
            </div>
          </div>
        </div>


        <!-- Approval Modal -->
        <div class="modal fade" id="approvalModal" role="dialog">
          <div class="modal-dialog">
            <!-- Modal content -->
            <div class="modal-content">
              <div class="modal-header">
                <h4 class="modal-title">Requests List</h4>
                <button style="color: white;" id="closeIcon" type="button" class="btn btn-close" data-bs-dismiss="modal"
                  data-dismiss="modal"></button>
              </div>
              <div class="modal-body">
                  <div v-for="request in requestsList" :key="request.id">
                    <p><strong>Id:  </strong> {{ request.id }}</p>
                    <p><strong>user:  </strong> {{ request.user }}</p>
                    <p><strong>Details:  </strong> {{ request.details }}</p>
                    <p><strong>Amount:  </strong>{{ request.amountWei }} Ether</p>
                    <p><strong>Status:  </strong> {{ getStatusLabel(request.status) }}</p>

                    <!-- Display approve and reject buttons for pending requests -->
                    <template v-if="request.status == 0">
                      <button class="btn btn-success" @click="approveRequest(request.id)">Approve</button>
                      <button class="btn btn-danger" @click="rejectRequest(request.id)">Reject</button>
                    </template>

                    <hr>
                  </div>
              </div>
            </div>
          </div>
        </div>


        <!--Request Modal -->
        <div class="modal fade" id="requestModal" role="dialog">
          <div class="modal-dialog">
            <!-- Modal content -->
            <div class="modal-content">
              <div class="modal-header">
                <h4 class="modal-title">Fill Request Information</h4>
                <button style="color: white;" id="closeIcon" type="button" class="btn btn-close" data-bs-dismiss="modal"
                  data-dismiss="modal"></button>
              </div>
              <div class="modal-body">
                <!-- Input fields for REQUEST INFORMATION -->
                <form @submit.prevent="submitRequest">
                  <div class="form-group">
                    <label for="requestAmount">Amount</label>
                    <input type="number" class="form-control" id="requestAmount" v-model="requestAmount" step="0.01" min="0"
                      placeholder="Ether Amount in Ether" required>
                  </div>
                  <div class="form-group">
                    <label for="requestDetails">Details of Request</label>
                    <input type="text" class="form-control" id="requestDetails" v-model="requestDetails" required>
                  </div>
                  <div class="form-footer">
                    <button type="submit" class="btn btn-success">Submit</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>


      <!--Deposit Modal -->
      <div class="modal fade" id="IncomeModal" role="dialog">
        <div class="modal-dialog">
          <!-- Modal content -->
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Fill Deposit Information</h4>
                <button style="color: white;" id="closeIcon" type="button" class="btn btn-close" data-bs-dismiss="modal"
                  data-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- Input fields for Deposit INFORMATION -->
                <form @submit.prevent="depositMoney">
                  <div class="form-group">
                    <label for="depositAmount">Amount</label>
                    <input type="number" class="form-control" id="depositAmount" v-model="depositAmount" step="0.01" min="0"
                      placeholder="Ether Amount in Ether" required>
                  </div>
                  <div class="form-group">
                    <label for="depositDetails">Details of Deposit</label>
                    <input type="text" class="form-control" id="depositDetails" v-model="depositDetails" required>
                  </div>
                  <div class="form-footer">
                    <button type="submit" class="btn btn-success">Submit</button>
                  </div>
                </form>
            </div>
          </div>
        </div>
      </div>


      <div v-if="isUser || isCEO || isAdmin" class="deposits">
        <button v-if="isUser || isAdmin || isCEO" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#IncomeModal">Deposit Money</button>
      </div>
    </div>
    <hr>

<div class="userTables" v-if="isUser || isAdmin">
  <div class="user-requests">
  <h1 class="title">Requests</h1>
  <table class="table table-hover table-bordered table-dark table-lg">
    <thead>
      <tr>
        <!-- <th>Request ID</th> -->
        <th>Amount (Eth)</th>
        <th>Descriptions</th>
        <th>Status</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="request in requestsList" :key="request.id">
        <!-- <td>{{ request.id }}</td> -->
        <td>{{ request.amountWei  }}</td>
        <td>{{ request.details }}</td>
        <td>{{ getStatusLabel(request.status) }}</td>
      </tr>
    </tbody>
  </table>
</div>

<div class="user-deposits">
  <h1 class="title">Deposits</h1>
  <table class="table table-bordered table-hover table-dark table-lg">
    <thead>
      <tr>
        <th>Request ID</th>
        <th>Amount (Ether)</th>
        <th>Details</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="DepositTransaction in depositList" :key="DepositTransaction.id">
        <td>{{ DepositTransaction.id }}</td>
        <td>{{ Number(DepositTransaction.amount.toString()) / 1e18 }}</td>
        <td>{{ DepositTransaction.details }}</td>
      </tr>
    </tbody>
  </table>
</div>
</div>

    <div v-if="isCEO">
    <div class="intro">
      <div class="intro-card">
        <p>{{ mainAccountBalance }} Ether</p>
        <h5>Main account Balance</h5>
      </div>
      <div class="intro-card">
        <p>{{ NumberOfUser }}</p>
        <h5>Total Registered Users</h5>
      </div>
      <div class="intro-card">
        <p>{{ TotalTransactions }}</p>
        <h5>Total Transactions</h5>
      </div>
    </div>
    <hr>
    <h1 class="title">Income & Salaries</h1>
    <div class="salaries">
      <div class="salaries-card">
        <p>{{ TotalSalariesAmount }} Ether</p>
        <h5>Total Amount of Salaries Distributed</h5>
      </div>
      <div class="salaries-card">
        <p>{{ TotalSalaryTransactions }}</p>
        <h5>Total Salaries Transactions</h5>
      </div>
      <div class="salaries-card">
        <p>{{ TotalIncome }} Ether</p>
        <h5>Total Amount of Income</h5>
      </div>
      <div class="salaries-card">
        <p>{{ TotalIncomeTransactions }}</p>
        <h5>Total Income Transactions</h5>
      </div>
    </div>
    <hr>
    <h1 class="title">Requests</h1>
    <div class="requests">
      <div class="request-card">
        <p>{{ TotalAmountRequests }} Ether</p>
        <h5>Total Amount Approved</h5>
      </div>
      <div class="request-card">
        <p>{{ TotalRequests }}</p>
        <h5>Total Requests Transactions</h5>
      </div>
      <div class="request-card">
        <p>{{ ApprovedRequests }}</p>
        <h5>Approved Requests</h5>
      </div>
      <div class="request-card">
        <p>{{ RejectedRequests }}</p>
        <h5>Rejected Requests</h5>
      </div>
      <div class="request-card">
        <p>{{ PendingRequests }}</p>
        <h5>Pending Requests</h5>
      </div>
    </div>
    </div>

  </div>
</template>

<script>
import Web3 from 'web3';
import YourSmartContractABI from '../MainAccountABI.js'; // Adjust the path accordingly
const contractAddress = '0xDc5E208a8883047C8BcFa58c19dC45B18c926F1d'; // contract address

export default {
  name: 'DashboardView',
  data() {
    return {
      depositAmount: 0,
      depositDetails: '',
      mainAccountBalance: 0,
      NumberOfUser: 0,
      TotalTransactions: 0,
      TotalSalariesAmount: 0,
      TotalSalaryTransactions: 0,
      TotalIncome: 0,
      TotalIncomeTransactions: 0,
      TotalAmountRequests: 0,
      TotalRequests: 0,
      ApprovedRequests: 0,
      RejectedRequests: 0,
      PendingRequests: 0,
      newUser: {
        username: '',
        address: '',
        salary: 0,
        role: ''
      },
      requestAmount: 0,
      requestDetails: '',
      deleteUserAddress: '',
      requestsList: [],
      depositList: [],
      allUsers: [],
    };
  },
  computed: {
    isCEO() {
      // Implement logic to determine if the user is a CEO
      return this.$store.state.userRole === 'CEO';
    },
    isAdmin() {
      // Implement logic to determine if the user is an Administrator
      return this.$store.state.userRole === 'admin';
    },
    isUser() {
      // Implement logic to determine if user is the regitered in system
      return this.$store.state.userRole === 'user';
    }
  },


  methods: {

    async checkMetaMaskConnection() {
    if (window.ethereum) {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_accounts' });
        const isConnected = accounts.length > 0;
        this.isMetaMaskConnected = isConnected;
      } catch (error) {
        console.error('Error checking MetaMask connection:', error);
      }
    }
    },

    async connectMetaMask() {
    if (!this.$store.state.userRole) {
      if (window.ethereum) {
        try {
          await window.ethereum.request({ method: 'eth_requestAccounts' });          
          const accounts = await window.ethereum.request({ method: 'eth_accounts' });
          const userAddress = accounts[0];
          const web3 = new Web3(window.ethereum);
          const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

          // Check if the address is registered in the smart contract
          const isRegistered = await contract.methods.isAddressRegistered(userAddress).call();
          
          if (isRegistered) {
          console.log('Address is registered in the smart contract');

          // Fetch user role from the smart contract
          const userRole = await contract.methods.getUserRole(userAddress).call();
          
          // Store user role in Vuex
          this.$store.commit('setUserRole', userRole);

          // Navigate to the Dashboard component
          // this.$router.push('/dashboard');

            // Now you can perform further actions or navigate to the dashboard
          } else {
            window.alert('You are not Registered User')
            console.log('Address is not registered in the smart contract');
            // Handle the case where the address is not registered
          }
        } catch (error) {
          console.error('Error connecting to MetaMask or checking address registration:', error);
        }
      } else {
        window.alert('MetaMask extension not detected');
        console.error('MetaMask extension not detected');
      }
    }
    },

    async fetchAllUsers() {
    try {
        if (window.ethereum) {
            const web3 = new Web3(window.ethereum);
            const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

            // Call the smart contract method to get all registered users
            const allUsers = await contract.methods.viewAllUsers().call();

            // Convert salary from string to number and address to string
            const formattedUsers = allUsers.map(user => {
                return {
                    username: user.username,
                    address: user.userAddress,
                    salary: Number(user.salary),
                    role: user.role
                };
            });

            this.allUsers = formattedUsers;
        } else {
            console.error('MetaMask extension not detected');
        }
    } catch (error) {
        console.error('Error fetching all registered users:', error);
    }
},



   async deleteUser() {
    try {
      if (window.ethereum) {

        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        const userAddress = accounts[0];
        const web3 = new Web3(window.ethereum);
        const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);
        
        // Make a transaction to delete the user
        await contract.methods.deleteUser(this.deleteUserAddress).send({ from: userAddress });

      } else {
        window.alert('MetaMask extension not detected');
        console.error('MetaMask extension not detected');
      }

    } catch (error){
        console.error('Error deleting user:', error);

    } finally {
      this.deleteUserAddress = '';
    }
   },

    async submitRequest() {
      try {
        if (window.ethereum){
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        const userAddress = accounts[0];
        const web3 = new Web3(window.ethereum);
        const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

        // Make a transaction to request money
        await contract.methods.requestMoney(this.requestAmount, this.requestDetails).send({ from: userAddress });

        console.log('Money request submitted successfully!');

        } else {
          window.alert('MetaMask extension not detected');
          console.error('MetaMask extension not detected');
        }
      } catch (error) {
        console.error('Error Requesting Money:', error);
      } finally {
        // Reset the form or perform other actions after submission
        this.requestAmount = 0;
        this.requestDetails = '';
      }
    },

    getStatusLabel(status) {
      switch (parseInt(status)) {
        case 0:
          return 'Pending';
        case 1:
          return 'Approved';
        case 2:
          return 'Rejected';
        default:
          return 'Unknown';
      }
    },


    async approveRequest(requestId) {
        try {
          if (window.ethereum){
            console.log('Approving request with ID:', requestId);
            const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            const userAddress = accounts[0];
            const web3 = new Web3(window.ethereum);
            const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);
            
            // Call the smart contract method to approve the request
            await contract.methods.processRequest(requestId, true).send({ from: userAddress });

            // Fetch the updated list of requests
            this.fetchRequests();
          } else{
          window.alert('MetaMask extension not detected');
          console.error('MetaMask extension not detected');
          }
        } catch (error) {
            console.error('Error approving request:', error);
        }
    },

    async rejectRequest(requestId) {
        try {
          if (window.ethereum){
            const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            const userAddress = accounts[0];
            const web3 = new Web3(window.ethereum);
            const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);
            
            // Call the smart contract method to reject the request
            await contract.methods.processRequest(requestId, false).send({ from: userAddress });

            // Fetch the updated list of requests
            this.fetchRequests();
          } else{
          window.alert('MetaMask extension not detected');
          console.error('MetaMask extension not detected');
          }
        } catch (error) {
            console.error('Error rejecting request:', error);
        }
    },

    async submitUser() {
      try {
        // Check if MetaMask is installed
        if (window.ethereum) {
          // Request account access
          const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });

          // Get user's Ethereum address
          const userAddress = accounts[0];

          // Create a Web3 instance
          const web3 = new Web3(window.ethereum);

          // Load the smart contract
          const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

          // Make a transaction to register the user
          await contract.methods
            .registerUser(
              this.newUser.username,
              this.newUser.address,
              this.newUser.salary,
              this.newUser.role
            )
            .send({ from: userAddress });

          console.log('User registration successful!');
        } else {
          window.alert('MetaMask extension not detected');
          console.error('MetaMask extension not detected');
        }
      } catch (error) {
        console.error('Error registering user:', error);
      } finally {
        // Reset the form or close the modal after submission
        this.newUser = {
          username: '',
          address: '',
          salary: 0,
          role: '',
        };
      }
    },


    async fetchMainAccountBalance() {
      try {
        const web3 = new Web3(window.ethereum);
        const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

        // Fetch main account balance from the smart contract
        const balanceWei = await contract.methods.getBalance().call();
        const balanceEther = web3.utils.fromWei(balanceWei.toString(), 'ether');

        // Fetch Number of Registered Users
        const registeredUsers = await contract.methods.getUserCount().call();

        // Fetch Total Transactions
        const totalTransactions = await contract.methods.TotalTransactions().call();

        // Fetch Total amount of salaries Distributed
        const totalSalariesAmountWei = await contract.methods.TotalSalariesDistributed().call();
        const totalSalariesAmountEther = web3.utils.fromWei(totalSalariesAmountWei.toString(), 'ether');


        // Fetch Total Salary distributed Transactions
        const totalSalaryTransactions = await contract.methods.TotalSalariesTransactions().call();

        // Fetch Total income amount
        const totalIncomeWei = await contract.methods.TotalIncome().call();
        const totalIncomeEther = web3.utils.fromWei(totalIncomeWei.toString(), 'ether');


        // Fetch Total income Transactions
        const totalIncomeTransactions = await contract.methods.TotalIncomeTransactions().call();

        // Fetch Total income Transactions
        const totalAmountRequestsWei = await contract.methods.TotalAmountRequests().call();
        const totalAmountRequests = web3.utils.fromWei(totalAmountRequestsWei.toString(), 'ether');

        // Fetch Total income Transactions
        const totalRequests = await contract.methods.TotalRequests().call();

        // Fetch Total income Transactions
        const approvedRequests = await contract.methods.ApprovedRequests().call();

        // Fetch Total income Transactions
        const rejectedRequests = await contract.methods.RejectedRequests().call();

        // Fetch Total income Transactions
        const pendingRequests = await contract.methods.PendingRequests().call();

        // Update the data property to trigger a re-render
        this.mainAccountBalance = balanceEther;
        this.NumberOfUser = registeredUsers;
        this.TotalTransactions = totalTransactions;
        this.TotalSalariesAmount = totalSalariesAmountEther;
        this.TotalSalaryTransactions = totalSalaryTransactions;
        this.TotalIncome = totalIncomeEther;
        this.TotalIncomeTransactions = totalIncomeTransactions;
        this.TotalAmountRequests = totalAmountRequests;
        this.TotalRequests = totalRequests;
        this.ApprovedRequests = approvedRequests;
        this.RejectedRequests = rejectedRequests;
        this.PendingRequests = pendingRequests;
      } catch (error) {
        console.error('Error fetching main account balance:', error);
      }
    },


    async depositMoney() {
    try {
        if (window.ethereum) {
            const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            const userAddress = accounts[0];
            const web3 = new Web3(window.ethereum);
            const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

            console.log(this.depositDetails, this.depositAmount );
            // Include details when calling the deposit function
            await contract.methods.addFunds(this.depositDetails).send({
                from: userAddress,
                value: web3.utils.toWei(this.depositAmount.toString(), 'ether')
            });

            console.log('Deposit successful!');
        } else {
            window.alert('MetaMask extension not detected');
            console.error('MetaMask extension not detected');
        }
    } catch (error) {
        console.error('Error depositing money:', error);
    }
},




    approvalsCEO() {
      // Implement CEO-specific action
      console.log('CEO-specific action');
    },


    async distributeSalaries() {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        const userAddress = accounts[0];
        const web3 = new Web3(window.ethereum);
        const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

        // Call the distributeSalary function from the smart contract
        await contract.methods.distributeSalary().send({ from: userAddress, });
        console.log('Salaries distributed successfully!');

      } catch (error) {
        console.error('Error distributing salaries:', error);
      }
    },

        async fetchRequests() {
        try {
          if (window.ethereum){
            const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            const userAddress = accounts[0];
            const web3 = new Web3(window.ethereum);
            const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

            const totalRequests = await contract.methods.requestCounter().call();
            const CEO_Address = await contract.methods.CEO().call();
            console.log(totalRequests)

            // Fetch each request individually
            const requests = [];
            for (let i = 1; i <= totalRequests; i++) {
                const request = await contract.methods.requests(i).call();
                // Check if the request belongs to the current user
                if (userAddress.toLowerCase() === CEO_Address.toLowerCase()) {
                    requests.push(request);
                }
                else if (request.user.toLowerCase() === userAddress.toLowerCase()) {
                  requests.push(request);
                }
            }

            // Update the data property with the list of requests
            this.requestsList = requests.reverse(); // Reverse the array to display the latest requests first
            
            console.log('Requests List:', this.requestsList); // Log the entire list to the console
          } else {
          window.alert('MetaMask extension not detected');
          console.error('MetaMask extension not detected');
          }
        } catch (error) {
            console.error('Error fetching requests:', error);
        }
    },


    async fetchDeposits() {
    try {
        if (window.ethereum) {
            const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            const userAddress = accounts[0];
            const web3 = new Web3(window.ethereum);
            const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);
            
            const CEO_Address = await contract.methods.CEO().call();
            const totalDeposits = await contract.methods.totalIncomeTransactions().call();

            // Fetch all deposit transactions
            const deposits = [];
            for (let i = 0; i < totalDeposits; i++) {
                const deposit = await contract.methods.depositTransactions(i).call();
                if (userAddress.toLowerCase() === CEO_Address.toLowerCase()) {
                deposits.push(deposit);
                }
                else if (deposit.depositor.toLowerCase() === userAddress.toLowerCase()) {
                  deposits.push(deposit);
                }

            }

            // Update the data property with the list of deposit transactions
            this.depositList = deposits.reverse(); // Reverse the array to display the latest transactions first

            console.log('Deposits List:', this.depositList); // Log the entire list to the console
        } else {
            window.alert('MetaMask extension not detected');
            console.error('MetaMask extension not detected');
        }
    } catch (error) {
        console.error('Error fetching deposits:', error);
    }
},



  },

  mounted() {

    this.checkMetaMaskConnection();  // Check if MetaMask is already connected
    this.fetchAllUsers();  // Fetch all registered users
    this.fetchMainAccountBalance();  // Fetch main account balance when the component is mounted
    this.fetchRequests();  // Fetch requests when the component is mounted
    this.fetchDeposits(); // Fetch deposits when the component is mounted

    // Check for the user's role when the component is mounted
    if (!this.$store.state.userRole) {
      // If the role is not present, trigger the MetaMask connection process
      this.connectMetaMask();
    }

  },
};
</script>

<style scoped>
#dashboard {
  background-color: #0C356A;
  color: white;
}

.title {
  font-size: 30px;
  color: #BFCFE7;
  font-family: sans-serif;
  text-align: center;
}

.top {
  display: flex;
  justify-content: space-between;
}

.request-btns {
  display: flex;
  align-items: center;
  padding: 20px;
}

.request-btns button {
  margin-right: 10px;
}


.intro,
.salaries,
.requests {
  display: flex;
  justify-content: space-between;
  padding: 20px;
  width: 100%;
  margin-bottom: 10px;
}

.intro-card {
  padding: 10px;
  box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.7);
  width: 31%;
  border-radius: 10px;
  background-color: #BFCFE7;
  color: #0C356A;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.intro-card:hover {
  background-color: #0C356A;
  color: #BFCFE7;
  box-shadow: 0px 5px 150px rgba(255, 255, 255, 0.7);

}

.intro-card p,
.salaries-card p,
.request-card p {
  font-weight: bolder;
  font-size: 20px;
}

.salaries-card {
  padding: 10px;
  box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.7);
  width: 24%;
  text-align: center;
  border-radius: 10px;
  background-color: #BFCFE7;
  color: #0C356A;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.salaries-card:hover {
  background-color: #0C356A;
  color: #BFCFE7;
  box-shadow: 0px 5px 150px rgba(255, 255, 255, 0.7);
}

.request-card {
  padding: 10px;
  box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.7);
  width: 18%;
  text-align: center;
  border-radius: 10px;
  background-color: #BFCFE7;
  color: #0C356A;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.request-card:hover {
  background-color: #0C356A;
  color: #BFCFE7;
  box-shadow: 0px 5px 150px rgba(255, 255, 255, 0.7);
}

.deposits {
  padding: 20px;
  display: flex;
  justify-content: end;
  align-items: center;
}

.deposits input {
  border: none;
  outline: none;
  padding: 8px;
  border-radius: 10px;
  margin-right: 10px;
}

.deposits button {
  margin-right: 10px;
}

.admin-btns {
  padding: 10px;
  padding-right: 20px;
  display: flex;
  align-items: center;
  justify-content: end;
}

.admin-btns button {
  margin-right: 10px;
  margin-left: 10px;
}

#closeIcon {
  background-color: red;
}

.modal-content {
  background-color: #0C356A;
}

.form-footer {
  display: flex;
  justify-content: end;
  margin-top: 10px;
}

.form-group {
  margin-bottom: 10px;
}
#connect{
  display: flex;
  justify-content: center;
  padding-top: 15px;
}
.userTables{
  margin-top: 50px;
  display: flex;
  justify-content: space-around;
}
.user-requests .user-deposits{
  table-layout: fixed;
}
.admin-users{
  padding: 0px 20px 20px;
  display: flex;
  justify-content: start;
}
.adminUsers{
  margin-top: 50px;
}
.table-lg {
  font-size: auto; /* Adjust the font size as needed */
}

</style>
