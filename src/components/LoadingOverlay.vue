<template>
  <div v-if="isLoading" class="loading-overlay">
    <div id="circle">
      <div class="loader">
        <div class="loader">
          <div class="loader">
            <div class="loader"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
  
<script>
export default {
  props: {
    isLoading: Boolean,
  },
};
</script>
  
<style scoped>
/* Loading overlay styles */
html,
body {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}

body {
  background: #0d161f;
}

#circle {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 150px;
  height: 150px;
}

.loader {
  width: calc(100% - 0px);
  height: calc(100% - 0px);
  border: 8px solid #162534;
  border-top: 8px solid #09f;
  border-radius: 50%;
  animation: rotate 5s linear infinite;
}

@keyframes rotate {
  100% {
    transform: rotate(360deg);
  }
}

.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 59, 99, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 999;
}
</style>
  