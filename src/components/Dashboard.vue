<!-- Dashboard.vue -->

<template>
  <div id=dashboard>
    <br>
    <h2><strong>CEO/Manager Dashboard</strong></h2>
    <br>
    
    <!-- Request Money Button (Common Feature) -->
    <button class="btn btn-primary" @click="requestMoney">Request Money</button>
    <br><br>
    <!-- Deposit Button (Common Feature) -->
    <button class="btn btn-success" @click="depositMoney">Deposit Money</button>
    <br><br>
    <!-- Approval Button (CEO/Manager Specific Feature) -->
    <button class="btn btn-secondary" v-if="isCEOorManager" @click="approveRequests">Approve Requests</button>
    <br>
    <!-- Transaction History (Common Feature) -->
    <div>
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
export default {
  name: 'DashboardView',
  data() {
    return {
      transactions: [
        { id: 1, description: 'Expense payment', amount: -50 },
        { id: 2, description: 'Deposit to main account', amount: 100 },
        // Add more sample transactions as needed
      ],
    };
  },
  computed: {
    isCEOorManager() {
      // Implement logic to determine if the user is a CEO or Manager
      return true; // Replace with actual logic
    },
  },
  methods: {
    requestMoney() {
      // Implement logic for requesting money
      console.log('Request money logic');
    },
    depositMoney() {
      // Implement logic for depositing money
      console.log('Deposit money logic');
    },
    approveRequests() {
      // Implement logic for approving requests
      console.log('Approval logic');
    },
  },
};
</script>

<style scoped>
/* Add your styles as needed */
#dashboard{
    color:black
}
.btn {
  background-color:black;
}
</style>
