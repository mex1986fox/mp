import Vue from "vue/dist/vue.js";
const locations = {
  namespaced: true,
  state: {
    countries: undefined,
    settlements: undefined,
    subjects: undefined
  },
  getters: {
    getSettlement: (state, getters, rootState, rootGetters) => id => {
      for (let settlement of state.settlements) {
        if (id == settlement.id) {
          return settlement;
        }
      }
      return undefined;
    }
  },
  mutations: {
    updateLocations(state, transport) {
      state.countries = transport.countries;
      state.settlements = transport.settlements;
      state.subjects = transport.subjects;
    }
  },
  actions: {
    loadLocations(context) {
      let state = context.state;
      if (
        state.countries == undefined ||
        state.settlements == undefined ||
        state.subjects == undefined
      ) {
        Vue.http.post("/api/show/locations").then(
          response => {
            let locations = response.body;
            context.commit("updateLocations", locations);
          },
          error => {}
        );
      }
    }
  }
};
export default locations;
