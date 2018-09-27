import Vue from "vue/dist/vue.js";
const locations = {
  namespaced: true,
  state: {
    countries: undefined,
    settlements: undefined,
    subjects: undefined
  },
  getters: {
    getCountry: (state, getters, rootState, rootGetters) => id => {
      for (let country of state.countries) {
        if (id == country.id) {
          return country;
        }
      }
      return undefined;
    },
    getSettlement: (state, getters, rootState, rootGetters) => id => {
      for (let settlement of state.settlements) {
        if (id == settlement.id) {
          return settlement;
        }
      }
      return undefined;
    },
    getSubject: (state, getters, rootState, rootGetters) => id => {
      if (state.subjects != undefined) {
        for (let subject of state.subjects) {
          if (id == subject.id) {
            return subject;
          }
        }
      }
      return undefined;
    },
    getSettlements: (state, getters, rootState, rootGetters) => idSubj => {
      for (let settlement of state.settlements) {
        if (idSubj == settlement.subject_id) {
          return settlement;
        }
      }
      return undefined;
    },
    getSubjects: (state, getters, rootState, rootGetters) => idCont => {
      return state.subjects.filter(subj => {
        return subj.country_id == idCont;
      });
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
          error => { }
        );
      }
    }
  }
};
export default locations;
