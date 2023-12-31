<template>
  <div id="app">
    <div class="appbar">
      <img id="logo" alt="logo" src="./assets/logo.png" />
      <h1>Smart Transparent Cashier <strong>STC</strong></h1>
      <h2>Welcome, <strong>User</strong></h2>
    </div>
    <router-view />
  </div>
</template>

<script>

// import DashboardView from './components/Dashboard.vue';

export default {
  name: "App",
  components: {
    // ConnectNetwork,

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
