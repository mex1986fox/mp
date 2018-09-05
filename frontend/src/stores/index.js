import Vue from "vue/dist/vue.js";
import Vuex from "vuex";
Vue.use(Vuex);

//импорт хранилищь vuex
import User from "./user/user.js";
import Locations from "./locations/locations.js";
import Transports from "./transports/transports.js";
import Form_add from "./forms/form-add.js";
const store = new Vuex.Store({
  // строгий режим для отслеживания ошибок
  // в продакшине отключить!!!
  strict: true,
  modules: {
    user: User,
    locations: Locations,
    transports: Transports,
    form_add: Form_add
  },
  state: {},
  getters: {},
  mutations: {},
  actions: {}
});
export default store;
