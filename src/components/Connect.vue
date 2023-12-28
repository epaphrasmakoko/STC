<template>
  <div>
    <button class="btn" @click="connectMetaMask">
      <strong>Connect To Your Metamask Wallet</strong>
    </button>
  </div>
</template>

<script>
import Web3 from 'web3';
import YourSmartContractABI from '/home/fxhacker/Documents/Blockchain/Frontend/Vue/STC/src/MainAccountABI.js'; // Adjust the path accordingly
const contractAddress = '0x30d6A1b5b7C474Ec966191342177A7969a2491Ba'; // contract address

export default {
  name: "ConnectNetwork",
  methods: {
    async connectMetaMask() {
      if (window.ethereum) {
        try {
          // Request account access
          await window.ethereum.request({ method: 'eth_requestAccounts' });
          
          // Fetch the user's Ethereum address
          const accounts = await window.ethereum.request({ method: 'eth_accounts' });
          const userAddress = accounts[0];

          // Create a Web3 instance
          const web3 = new Web3(window.ethereum);

          // Load the smart contract
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
          this.$router.push('/dashboard');

            // Now you can perform further actions or navigate to the dashboard
          } else {
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
    },
  },
};
</script>

<style scoped>
button {
  margin-top: 60px;
  width: 500px;
  background-color: green;
  color: aliceblue;
}
button:hover {
  box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24),
    0 17px 50px 0 rgba(0, 0, 0, 0.19);
  background-color: aqua;
  color: black;
  transition-duration: 0.8s;
}

</style>
