<template>
<div id="app">
    <img id=logo alt="logo" src="./assets/logo.png" />
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

html,body {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  padding:0;
  margin:0;
  text-align: center;
  background: url('./assets/back2.jpg') ;
  background-size: cover;
}
#logo {
  margin-top: 60px;
  height: 120px;
}
</style>
