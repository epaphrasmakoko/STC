<template>
  <div>
    <button class="btn" @click="connectMetaMask"><strong>Connect To STC network</strong></button>
  </div>
</template>

<script>
export default {
  name: "ConnectNetwork",
  methods: {
    connectMetaMask() {
      // Check if MetaMask is installed
      if (window.ethereum) {
          window.alert("MetaMask volaaaa connected");
        // // Request account access
        // window.ethereum
        //   .request({ method: "eth_requestAccounts" })
        //   .then((accounts) => {
        //     // User connected, 'accounts' contains an array of user accounts
        //     const userAddress = accounts[0];
        //     // Store user's Ethereum address in your application's state
        //     this.$store.commit("setUserAddress", userAddress);
        //   })
        //   .catch((error) => {
        //     console.error(error);
        //   });
      } else {
        window.alert("MetaMask extension not detected");
      }
    },
  },
};
</script>

<style scoped>
button {
  margin-top: 60px;
  width: 500px;
  background-color: black;
  color: aliceblue;
}
button:hover {
  box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24),
    0 17px 50px 0 rgba(0, 0, 0, 0.19);
  background-color: aqua;
  color: black;
  transition-duration: 0.8s;
}
button {
  background-color: green;
}
</style>