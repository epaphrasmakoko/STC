<!-- DashboardOther.vue -->

<template>
  <div>
    <h2>Normal User Dashboard</h2>
    
    <!-- Request Money Button -->
    <button class="btn btn-primary" @click="requestMoney">Request Money</button>
    <br><br>
    <!-- Deposit Button -->
    <button class="btn btn-success" @click="depositMoney">Deposit Money</button>
    <br><br>
    <!-- Transaction History -->
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
  name: 'Dashboard-other',
  data() {
    return {
      transactions: [
        { id: 1, description: 'Expense payment', amount: -50 },
        { id: 2, description: 'Deposit to main account', amount: 100 },
        // Add more sample transactions as needed
      ],
    };
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
  },
};
</script>

<style scoped>
/* Add your styles as needed */
</style>
