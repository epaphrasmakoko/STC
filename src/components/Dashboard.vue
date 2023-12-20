<template>
  <div id="dashboard">
    <br>
    <h2><strong>Dashboard</strong></h2>
    <br>

    <!-- Request Money Button (Common Feature) -->
    <button class="btn btn-primary" @click="requestMoney">Request Money</button>
    <br><br>
    <!-- Deposit Button (Common Feature) -->
    <button class="btn btn-success" @click="depositMoney">Deposit Money</button>
    <br>
    <!-- <label for="depositAmount">Enter Amount (in Ether): </label> -->
    <input type="number" id="depositAmount" v-model="depositAmount" step="0.01" min="0" placeholder="Deposit Amount in Ether" />
    <br><br>

    <!-- Specific Features for CEO -->
    <button class="btn btn-secondary" v-if="isCEO" @click="approvalsCEO">Approvals</button>
    <br><br>

    <!-- Specific Features for Admin -->
    <button class="btn btn-warning" v-if="isAdmin" @click="AdminRegister">Register</button>
    <br><br>

    <!-- Transaction History (Common Feature) -->
    <div style="color:white;">
      <h3>Transaction History</h3>
      <ul>
        <li v-for="transaction in transactions" :key="transaction.id">
          {{ transaction.description }} - {{ transaction.amount }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import Web3 from 'web3';
import YourSmartContractABI from '/home/fxhacker/Documents/Blockchain/Frontend/Vue/STC/src/MainAccountABI.js'; // Adjust the path accordingly
const contractAddress = '0x30d6A1b5b7C474Ec966191342177A7969a2491Ba'; // contract address

export default {
  name: 'DashboardView',
  data() {
    return {
      transactions: [
        { id: 1, description: 'Request Transactions', amount: -50 },
        { id: 2, description: 'Income Transactions', amount: 100 },
        { id: 3, description: 'Salaries Transactions', amount: 7000 },
        { id: 4, description: 'Total Transactions', amount: 1000 },
        // Add more sample transactions as needed
      ],
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


    async depositMoney() 
    {
  
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
    AdminRegister() {
      // Implement Admin-specific action
      console.log('Admin-specific action');
    },
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
}
</style>
