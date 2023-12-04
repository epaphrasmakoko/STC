<template>
    <img id=logo alt="logo" src="./assets/logo.png" />
    <ConnectNetwork/>
    <!-- <router-view /> -->
</template>

<script>
// import DashboardView from './components/Dashboard.vue';
import ConnectNetwork from './components/connect.vue';

export default {
  name: "App",
  components: {
    // DashboardView,
    ConnectNetwork,
    
  },
};
</script>

<style>
@import 'bootstrap/dist/css/bootstrap.min.css';

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
