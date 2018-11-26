import Vue from "vue/dist/vue.js";
import Router from "vue-router";

import Authorization from "../pages/authorization/authorization.vue";
import AccountData from "../pages/account/data/data.vue";

import Users from "../pages/users/users.vue";
import Ads from "../pages/ads/ads.vue";
Vue.use(Router);
export default new Router({
  mode: "history", // приводит к нормальным URL без #
  routes: [
    { path: "/authorization", component: Authorization },
    { path: "/account/data", component: AccountData },
    { path: "/users", component: Users },
    { path: "/ads", component: Ads }
  ],
  beforeDestroy: function () {
    this.choicesSelect.destroy()
  }
});
