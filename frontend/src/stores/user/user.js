import Vue from "vue/dist/vue.js";
const user = {
  namespaced: true,
  state: {
    id: undefined,
    name: undefined,
    surname: undefined,
    login: undefined,
    birthdate: undefined,
    settlement_id: undefined,
    phone: undefined,
    email: undefined
  },
  getters: {},
  mutations: {
    update(state, user) {
      state.id = user.id;
      state.name = user.name;
      state.surname = user.surname;
      state.login = user.login;
      state.birthdate = user.birthdate;
      state.settlement_id = user.settlement_id;
      state.phone = user.phone;
      state.email = user.email;
    },
    drop(state, user) {
      state.id = undefined;
      state.name = undefined;
      state.surname = undefined;
      state.login = undefined;
      state.birthdate = undefined;
      state.settlement_id = undefined;
      state.phone = undefined;
      state.email = undefined;
    }
  },
  actions: {
    authentication(context) {
      let user_id = Vue.cookie.get("user_id");
      if (user_id != undefined) {
        let body = { user_id: user_id };
        Vue.http.post("/api/authentication/users", body).then(
          () => {
            context.dispatch("setUser");
          },
          () => {
            context.commit("drop");
          }
        );
      } else {
        context.commit("drop");
      }
    },
    logout(context) {
      let user_id = Vue.cookie.get("user_id");
      if (user_id != undefined) {
        let body = { id: user_id };
        Vue.http.post("/api/logout/users", body).then(
          response => {
            context.commit("drop");
          },
          error => { }
        );
      }
    },
    setUser(context) {
      let user_id = Vue.cookie.get("user_id");
      if (user_id != undefined) {
        let body = { id: user_id };
        Vue.http.post("/api/show/users", body).then(
          response => {
            context.commit("update", response.body.users[0]);
          },
          error => { }
        );
      }
    }
  }
};
export default user;
