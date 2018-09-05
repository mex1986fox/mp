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
    updateUser(state, user) {
      console.log(user);
      state.id = user.id;
      state.name = user.name;
      state.surname = user.surname;
      state.login = user.login;
    }
  },
  actions: {
    getUser(context) {
      return new Promise((resolve, reject) => {
        let user_id = Vue.cookie.get("user_id");
        if (user_id == undefined) {
          reject();
        } else if (context.state.id != undefined) {
          resolve();
        } else {
          let body = { id: user_id };
          Vue.http.post("/api/show/users", body).then(
            response => {
              context.commit("updateUser", response.body.users[0]);
              resolve();
            },
            error => {}
          );
        }
      });
    }
  }
};
export default user;
