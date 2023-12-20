// store.js
import { createStore } from 'vuex';

const store = createStore({
  state: {
    userRole: null,
  },
  mutations: {
    setUserRole(state, role) {
      state.userRole = role;
    },
  },
  // Other properties as needed
});

export default store;
