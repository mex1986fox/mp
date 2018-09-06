import Vue from "vue/dist/vue.js";
const user = {
  namespaced: true,
  state: {
    id: undefined,
    name: undefined,
    surname: undefined,
    login: undefined
  },
  getters: {},
  mutations: {
    update(state, user) {
      state.id = user.id;
      state.name = user.name;
      state.surname = user.surname;
      state.login = user.login;
    },
    drop(state, user) {
      state.id = undefined;
      state.name = undefined;
      state.surname = undefined;
      state.login = undefined;
    }
  },
  actions: {
  }
};
export default user;
