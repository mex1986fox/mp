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
      }else{
				 context.commit("drop");
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
          error => {}
        );
      }
    },
  }
};
export default user;
