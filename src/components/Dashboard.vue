<template>
  <div id="dashboard">
    <div class="admin-btns">
      <!-- Specific Features for Admin -->
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">Register
        User</button>
      <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">Delete
        User</button>

      <!-- Modal -->
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
              <!-- Input fields for user information -->
              <form @submit.prevent="">
                <div class="form-group">
                  <label for="address">Address:</label>
                  <input type="text" class="form-control" id="address" v-model="newUser.address" required>
                </div>
                <div class="form-footer">
                  <button type="submit" class="btn btn-danger">Delete</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>


      <!-- Modal -->
      <div class="modal fade" id="myModal" role="dialog">
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
                  <input type="text" class="form-control" id="role" v-model="newUser.role" placeholder="if CEO write CEO"
                    required>
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
    <div class="top">
      <div class="request-btns">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#requestModal">Request Money</button>
        <!-- Specific Features for CEO -->
        <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#approvalModal">Approvals</button>
        <!-- Specific Features for CEO -->
        <button class="btn btn-danger" @click="distributeSalaries">Distribute Salaries</button>



        <!-- Modal -->
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
                <!-- Input fields for user information -->
                <form @submit.prevent="">
                  <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" class="form-control" id="username" v-model="newUser.username" required>
                  </div>
                  <div class="form-group">
                    <label for="salary">Amount:</label>
                    <input type="number" class="form-control" id="salary" v-model="newUser.salary" step="0.01" min="0"
                      placeholder="Ether Amount in Ether" required>
                  </div>
                  <div class="form-group">
                    <label for="address">Details of Request</label>
                    <input type="text" class="form-control" id="address" v-model="newUser.address" required>
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
      <!-- v-if="isCEO" -->
      <div class="deposits">
        <!-- <label for="depositAmount">Enter Amount (in Ether): </label> -->
        <input type="number" id="depositAmount" v-model="depositAmount" step="0.01" min="0"
          placeholder="Deposit Amount in Ether" />
        <!-- Deposit Button (Common Feature) -->
        <button class="btn btn-success" @click="depositMoney">Deposit Money</button>
        <!-- Request Money Button (Common Feature) -->
      </div>
    </div>

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
        <p>5</p>
        <h5>Total Amount Approved</h5>
      </div>
      <div class="request-card">
        <p>5</p>
        <h5>Total Requests Transactions</h5>
      </div>
      <div class="request-card">
        <p>5</p>
        <h5>Approved Requests</h5>
      </div>
      <div class="request-card">
        <p>5</p>
        <h5>Pending Requests</h5>
      </div>
      <div class="request-card">
        <p>5</p>
        <h5>Rejected Requests</h5>
      </div>
    </div>


  </div>
</template>

<script>
import Web3 from 'web3';
import YourSmartContractABI from '../MainAccountABI.js'; // Adjust the path accordingly
const contractAddress = '0xBAfC48A283F5e57620Ff1F4451fCB795bC445E54'; // contract address

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
  background-color: white;
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
</style>
