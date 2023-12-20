import { createRouter, createWebHistory } from 'vue-router';
import ConnectNetwork from '../components/Connect.vue';
import Dashboard from '../components/Dashboard.vue';

const routes = [
  { path: '/', component: ConnectNetwork },
  { path: '/dashboard', component: Dashboard, /*meta: { requiresAuth: true }*/ },
  // { path: '/dashboard-other', component: DashboardOther, /*meta: { requiresAuth: true, requiresOther: true }*/ },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
