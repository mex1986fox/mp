import Vue from "vue/dist/vue.js";
const filter_album = {
  namespaced: true,
  state: {
    sort: [
      { id: 1, name: "дате (новые)" },
      { id: 2, name: "дате (старые)" },
      { id: 5, name: "году (новые)" },
      { id: 6, name: "году (старые)" }
    ],
    filter: {}
  },
  getters: {
    getSort: (state, getters, rootState, rootGetters) => {
      let menu = [];
      state.sort.filter(sort => {
        let selected = false;
        if (state.filter.sort != undefined) {
          selected =
            state.filter.sort.filter(fil => {
              return fil == sort.id ? 1 : 0;
            }).length == 1
              ? true
              : false;
        }
        menu.push({
          value: sort.id,
          option: sort.name,
          selected: selected
        });
      });
      return menu;
    },
    getTransports: (state, getters, rootState, rootGetters) => {
      let transports = [];
      if (state.filter.transports != undefined) {
        transports = state.filter.transports.map(trans => {
          return trans;
        });
      }
      return transports;
    },
    getModels: (state, getters, rootState, rootGetters) => {
      let models = [];
      if (state.filter.models != undefined) {
        models = state.filter.models.map(trans => {
          return trans;
        });
      }
      return models;
    },
    getBrands: (state, getters, rootState, rootGetters) => {
      let transports = [];
      if (state.filter.brands != undefined) {
        transports = state.filter.brands.map(trans => {
          return trans;
        });
      }
      return transports;
    },
    getCountries: (state, getters, rootState, rootGetters) => {
      let countries = [];
      if (state.filter.countries != undefined) {
        countries = state.filter.countries.map(count => {
          return count;
        });
      }
      return countries;
    },
    getSettlements: (state, getters, rootState, rootGetters) => {
      let settlements = [];
      if (state.filter.settlements != undefined) {
        settlements = state.filter.settlements.map(count => {
          return count;
        });
      }
      return settlements;
    },
    getSubjects: (state, getters, rootState, rootGetters) => {
      let subjects = [];
      if (state.filter.subjects != undefined) {
        subjects = state.filter.subjects.map(count => {
          return count;
        });
      }
      return subjects;
    },
    getYears: (state, getters, rootState, rootGetters) => {
      let maxDate = new Date().getFullYear();
      let minDate = 1935;
      let menu = [];
      while (minDate != maxDate) {
        let selected = false;
        if (state.filter.year != undefined) {
          let filter = state.filter.year;
          selected =
            filter.filter(fil => {
              return fil == maxDate ? 1 : 0;
            }).length == 1
              ? true
              : false;
        }
        menu.push({
          value: maxDate,
          option: maxDate,
          group: "Года",
          selected: selected
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
        let selected = false;
        if (state.filter.yearBef != undefined) {
          let filter = state.filter.yearBef;
          selected =
            filter.filter(fil => {
              return fil == maxDate ? 1 : 0;
            }).length == 1
              ? true
              : false;
        }
        menu.push({
          value: maxDate,
          option: maxDate,
          group: "Года",
          selected: selected
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
    },
    setFilters(state, filters) {
      state.filter = undefined;
      state.filter = filters;
      // console.dir(state.filter);
    }
  },
  actions: {}
};
export default filter_album;
