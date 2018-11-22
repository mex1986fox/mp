import Vue from "vue/dist/vue.js";
const filter_add = {
  namespaced: true,
  state: {
    sortBy: [
      { value: 1, name: "Цене (сначала дорогие)" },
      { value: 2, name: "Цене (сначала дешевые)" },
      { value: 3, name: "Объему (сначала большие)" },
      { value: 4, name: "Объему (сначала маленькие)" },
    ],
    helms: [
      { value: 1, name: "левый" },
      { value: 2, name: "правый" }
    ],
    filter: {}
  },
  getters: {
    getSortBy: (state, getters, rootState, rootGetters) => {
      let sortBy = [];
      if (
        state.sortBy
      ) {
        for (let sort of state.sortBy) {
          sortBy.push({
            value: sort.id,
            option: sort.name,
          });
        }
      }
      return sortBy;
    },
    getHelms: (state, getters, rootState, rootGetters) => {
      let helms = [];
      if (
        state.helms
      ) {
        for (let helm of state.helms) {
          helms.push({
            value: helm.id,
            option: helm.name,
          });
        }
      }
      return helms;
    },
    getFuels: (state, getters, rootState, rootGetters) => {
      let fuels = [];
      if (
        rootState.transports.fuels
      ) {
        for (let fuel of rootState.transports.fuels) {
          fuels.push({
            value: fuel.id,
            option: fuel.name,
            group: "Топливо"
          });
        }
      }
      return fuels;
    },
    getDrives: (state, getters, rootState, rootGetters) => {
      let drives = [];
      if (
        rootState.transports.drives
      ) {
        for (let drive of rootState.transports.drives) {
          drives.push({
            value: drive.id,
            option: drive.name,
          });
        }
      }
      return drives;
    },
    getTransmissions: (state, getters, rootState, rootGetters) => {
      let transmissions = [];
      if (rootState.transports.transmissions) {
        for (let transmission of rootState.transports.transmissions) {
          transmissions.push({
            value: transmission.id,
            option: transmission.name
          });
        }
      }
      return transmissions;
    },
    getBodies: (state, getters, rootState, rootGetters) => {
      let bodies = [];
      if (rootState.transports.bodies) {
        for (let body of rootState.transports.bodies) {
          bodies.push({
            value: body.id,
            option: body.name,
            group: body.name[0]
          });
        }
      }
      return bodies;
    },
    getYears: (state, getters, rootState, rootGetters) => {
      let maxDate = new Date().getFullYear();
      let minDate = 1935;
      let menu = [];
      while (minDate != maxDate) {
        menu.push({
          value: maxDate,
          option: maxDate,
          group: "Года",
          selected: false
        });
        maxDate--;
      }
      return menu;
    },
    getYearsBef: (state, getters, rootState, rootGetters) => {
      let maxDate = new Date().getFullYear();
      let minDate = 1935;
      let menu = [];
      while (minDate != maxDate) {
        menu.push({
          value: maxDate,
          option: maxDate,
          group: "Года",
          selected: false
        });
        maxDate--;
      }
      return menu;
    }
  },
  mutations: {
    setFilter(state, filter) {
      let stateFilter = state.filter;
      stateFilter[filter.name] = filter.filter;
      state.filter = stateFilter;
      // console.dir(state.filter);
    }
  },
  actions: {}
};
export default filter_add;
