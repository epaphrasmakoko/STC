// main.js
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store'; // Import the Vuex store

createApp(App).use(router).use(store).mount('#app');
