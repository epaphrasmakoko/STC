<template>
  <div>
    <button class="btn" @click="connectMetaMask">
      <strong>Connect To Your Metamask Wallet</strong>
    </button>
  </div>
</template>

<script>
import Web3 from 'web3';
import YourSmartContractABI from '../MainAccountABI.js'; 
const contractAddress = '0xEC8548075D7543722bc451DDf1dbd498EDed7D56'; 

export default {
  name: "ConnectNetwork",
  methods: {
    async connectMetaMask() {
      if (window.ethereum) {
        try {
          await window.ethereum.request({ method: 'eth_requestAccounts' });
          const accounts = await window.ethereum.request({ method: 'eth_accounts' });
          const userAddress = accounts[0];
          const web3 = new Web3(window.ethereum);
          const contract = new web3.eth.Contract(YourSmartContractABI, contractAddress);

          const isRegistered = await contract.methods.isAddressRegistered(userAddress).call();

          if (isRegistered) {

            // Fetch user role from the smart contract
            const userRole = await contract.methods.getUserRole(userAddress).call();

            // Store user role in Vuex
            this.$store.commit('setUserRole', userRole);

            // // Navigate to the Dashboard component
            // this.$router.push('/dashboard');

          } else {
            console.log('Address is not registered in the smart contract');
          }
        } catch (error) {
          console.error('Error connecting to MetaMask or checking address registration:', error);
        }
      } else {
        window.alert('MetaMask extension not detected');
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
