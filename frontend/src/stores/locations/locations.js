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
    },
    getSubject: (state, getters, rootState, rootGetters) => id => {
      for (let subject of state.subjects) {
        if (id == subject.id) {
          return subject;
        }
      }
      return undefined;
    },
    getMenuSubjects: (state, getters, rootState, rootGetters) => (country_id, selected_id = []) => {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let subjects = state.subjects.filter((subject) => {
        return subject.country_id == country_id;
      });

      let menu = subjects.map((subject) => {
        // console.log("selected:"+selected_id.some((sel) => { return sel == subject.id }));
        
        return {
          value: subject.id,
          option: subject.name,
          group: subject.name[0],
          selected: selected_id.some((sel) => { return sel == subject.id })
        }
      });
      // console.log(menu);
      return menu;
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
