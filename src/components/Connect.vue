<template>
  <div>
    <button class="btn"><strong>Connect To STC network</strong></button>
  </div>
</template>

<script>
export default {
    name: 'ConnectNetwork',
    
}
</script>

<style scoped>
button {
    margin-top: 60px;
    width: 500px;
    background-color:black;
    color: aliceblue;
}    
button:hover{
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
    background-color:aqua;
    color:black;
    transition-duration: 0.8s;

}
button{
  background-color: green;
}
</style>