<template>
  <div id="app">
    <div class="appbar">
      <img id="logo" alt="logo" src="./assets/logo.png" />
      <h1>Smart Transparent Cashier <strong>STC</strong></h1>
      <h2>Welcome, <strong>{{ registeredUserName }}</strong></h2>
    </div>
    <router-view />
  </div>
</template>

<script>

// import DashboardView from './components/Dashboard.vue';
import Web3 from 'web3';
import YourSmartContractABI from './MainAccountABI.js'; // Adjust the path accordingly
const contractAddress = '0xbde02c17320b53ee3F454C94c8641C5baCDc32Ad'; // contract address

export default {
  name: "App",
  components: {
  },
    data() {
    return {
      registeredUserName: 'Guest',
    };
  },
  mounted() {
    // Assuming you have a method in your Smart Contract to get the registered user's name
    this.fetchRegisteredUserName();
  },
  methods: {
    async fetchRegisteredUserName() {
      try {
        if (window.ethereum) {
          const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
          const userAddress = accounts[0];
          const web3 = new Web3(window.ethereum);
          const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

          // Assuming you have a method in your Smart Contract to get the user's name
          const userName = await contract.methods.getUserName(userAddress).call();
          this.registeredUserName = userName;
          if (this.registeredUserName == ''){
            this.registeredUserName = 'Guest';
          }
        } else {
          console.error('MetaMask extension not detected');
        }
      } catch (error) {
        console.error('Error fetching registered user name:', error);
      }
    },
  },
};
</script>

<style>
#app img {
  padding: 10px;
  width: 70px;
  height: 70px;
  object-fit: contain;
}

.appbar {
  display: flex;
  justify-content: space-between;
  padding: 10px;
  background-color: #11235A;
  align-items: center;
}

.appbar h2,h1 {
  font-size: 24px;
  color: white;
  font-family: sans-serif;
  text-align: center;
}
</style>
