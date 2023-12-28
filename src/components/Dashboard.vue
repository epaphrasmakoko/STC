<template>
  <div id="dashboard">
    <br>
    <h2 style="color: blanchedalmond;">Welcome, <strong>User</strong> to STC</h2>
    <br>

    <div class="flex-container">
      <div>
        <p style="color:rgb(0, 255, 0);">{{ mainAccountBalance }} Ether</p>
        <h5>Main account Balance</h5>
      </div>
      <div>
        <p style="color:rgb(0, 255, 0);">{{ NumberOfUser }}</p>
        <h5>Total Registered Users</h5>
      </div>
      <div>
        <p style="color:rgb(0, 255, 0);">{{ TotalTransactions }}</p>
        <h5>Total Transactions</h5>
      </div>
    </div>
    <hr style="color:rgb(0, 255, 0);">

    <div class="flex-container">
      <div>
        <p style="color:rgb(255, 230, 0);">{{ TotalSalariesAmount }} Ether</p>
        <h5>Total Amount of Salaries Distributed</h5>
      </div>
      <div>
        <p style="color:rgb(255, 230, 0);">{{ TotalSalaryTransactions }}</p>
        <h5>Total Salaries Transactions</h5>
      </div>
      <div>
        <p style="color:rgb(255, 230, 0);">{{ TotalIncome }} Ether</p>
        <h5>Total Amount of Income</h5>
      </div>
      <div>
        <p style="color:rgb(255, 230, 0);">{{ TotalIncomeTransactions }}</p>
        <h5>Total Income Transactions</h5>
      </div>
    </div>
    <hr style="color:rgb(255, 230, 0);">
    <div class="flex-container">
      <div>
        <p style="color:rgb(255, 60, 0);">5</p>
        <h5>Total Amount Approved</h5>
      </div>
      <div>
        <p style="color:rgb(255, 60, 0);">5</p>
        <h5>Total Requests Transactions</h5>
      </div>
      <div>
        <p style="color:rgb(255, 60, 0);">5</p>
        <h5>Approved Requests</h5>
      </div>
      <div>
        <p style="color:rgb(255, 60, 0);">5</p>
        <h5>Pending Requests</h5>
      </div>
      <div>
        <p style="color:rgb(255, 60, 0);">5</p>
        <h5>Rejected Requests</h5>
      </div>
    </div>

    <hr style="color:rgb(255, 60, 0);">
    <br>


    <!-- Request Money Button (Common Feature) -->
    <button class="btn btn-primary" @click="requestMoney">Request Money</button>
    <br><br>
    <!-- Deposit Button (Common Feature) -->
    <button class="btn btn-success" @click="depositMoney">Deposit Money</button>
    <br><br>
    <!-- <label for="depositAmount">Enter Amount (in Ether): </label> -->
    <input type="number" id="depositAmount" v-model="depositAmount" step="0.01" min="0"
      placeholder="Deposit Amount in Ether" />
    <br><br>

    <!-- Specific Features for CEO -->
    <button class="btn btn-secondary" v-if="isCEO" @click="approvalsCEO">Approvals</button>
    <br><br>

    <!-- Specific Features for CEO -->
    <button class="btn btn-danger" @click="distributeSalaries">Distribute Salaries</button>
    <br><br>

    <!-- Specific Features for Admin -->
    <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#myModal">Register User</button>
    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content -->
        <div class="modal-content">
          <div class="modal-header">
            <button id="closeIcon" type="button" class="btn-close" data-bs-dismiss="modal" data-dismiss="modal"></button>
            <h4 class="modal-title">Fill User Information</h4>
          </div>
          <div class="modal-body">
            <!-- Input fields for user information -->
            <form @submit.prevent="submitUser">
              <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" id="username" v-model="newUser.username" required>
              </div>
              <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="address" v-model="newUser.address" required>
              </div>
              <div class="form-group">
                <label for="salary">Salary:</label>
                <input type="number" class="form-control" id="salary" v-model="newUser.salary" step="0.01" min="0"
                  placeholder="Ether Amount in Ether" required>
              </div>
              <div class="form-group">
                <label for="role">Role:</label>
                <input type="text" class="form-control" id="role" v-model="newUser.role" placeholder="if CEO write CEO"
                  required>
              </div>
              <button type="submit" class="btn btn-success">Submit</button>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <br><br>
  </div>
</template>

<script>
import Web3 from 'web3';
import YourSmartContractABI from '/home/fxhacker/Documents/Blockchain/Frontend/Vue/STC/src/MainAccountABI.js'; // Adjust the path accordingly
const contractAddress = '0xCC8D619279C2FCA9Ff49aeE3FDeE2C6764E31466'; // contract address

export default {
  name: 'DashboardView',
  data() {
    return {
      depositAmount: 0,
      mainAccountBalance: 0,
      NumberOfUser: 0,
      TotalTransactions: 0,
      TotalSalariesAmount: 0,
      TotalSalaryTransactions: 0,
      TotalIncome: 0,
      TotalIncomeTransactions: 0,
      newUser: {
        username: '',
        address: '',
        salary: 0,
        role: ''
      },
    };
  },
  computed: {
    isCEO() {
      // Implement logic to determine if the user is a CEO
      return this.$store.state.userRole === 'ceo';
    },
    isAdmin() {
      // Implement logic to determine if the user is an Administrator
      return this.$store.state.userRole === 'admin';
    },
  },


  methods: {
    requestMoney() {
      // Implement logic for requesting money
      console.log('Request money logic');
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
              web3.utils.toWei(this.newUser.salary.toString(), 'ether'),
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

        // Update the data property to trigger a re-render
        this.mainAccountBalance = balanceEther;
        this.NumberOfUser = registeredUsers;
        this.TotalTransactions = totalTransactions;
        this.TotalSalariesAmount = totalSalariesAmountEther;
        this.TotalSalaryTransactions = totalSalaryTransactions;
        this.TotalIncome = totalIncomeEther;
        this.TotalIncomeTransactions = totalIncomeTransactions;
      } catch (error) {
        console.error('Error fetching main account balance:', error);
      }
    },


    async depositMoney() {

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

          // Send funds to the smart contract
          await contract.methods.addFunds().send({
            from: userAddress,
            value: web3.utils.toWei(this.depositAmount.toString(), 'ether'), // Set the amount you want to deposit
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


  },

  mounted() {
    // Fetch main account balance when the component is mounted
    this.fetchMainAccountBalance();
  },
};
</script>

<style scoped>
/* Add your styles as needed */
#dashboard {
  color: black;
}

.btn {
  color: aliceblue;
  background-color: black;
  border-color: black;
}

.flex-container {
  display: flex;
  justify-content: space-around;
  background-color: transparent;
}

.flex-container>div {
  color: bisque;
  background-color: transparent;
  width: 150px;
  margin: 10px;
  text-align: center;
  line-height: 75px;
  font-size: 30px;
}

#closeIcon {
  margin-left: 0px;
}

.form-group {
  text-align: left;
  margin-bottom: 10px;
}
</style>
