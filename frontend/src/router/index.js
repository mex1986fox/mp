import Vue from "vue/dist/vue.js";
import Router from "vue-router";

import Authorization from "../pages/authorization/authorization.vue";
import AccountData from "../pages/account/data/data.vue";

import Users from "../pages/users/users.vue";
import Posts from "../pages/posts/posts.vue";
import Ads from "../pages/ads/ads.vue";
import Albums from "../pages/albums/albums.vue";
Vue.use(Router);
export default new Router({
  mode: "history", // приводит к нормальным URL без #
  routes: [
    { path: "/authorization", component: Authorization },
    { path: "/account/data", component: AccountData },
    { path: "/users", component: Users },
    { path: "/ads", component: Ads },
    { path: "/albums", component: Albums },
    { path: "/posts", component: Posts }

  ],
  beforeDestroy: function () {
    this.choicesSelect.destroy()
  }
});

