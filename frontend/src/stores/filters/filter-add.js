import Vue from "vue/dist/vue.js";
const filter_add = {
  namespaced: true,
  state: {
    sortBy: [
      { id: 1, name: "Цене (сначала дорогие)" },
      { id: 2, name: "Цене (сначала дешевые)" },
      { id: 3, name: "Объему (сначала большие)" },
      { id: 4, name: "Объему (сначала маленькие)" },
    ],
    helms: [
      { id: 1, name: "левый" },
      { id: 2, name: "правый" }
    ],
    filter: {}
  },
  getters: {
    getTransports: (state, getters, rootState, rootGetters) => {
      let transports = [];
      if (state.filter.transport.transports != undefined) {
        transports = state.filter.transport.transports.map(trans => { return trans.id });
      }
      return transports;
    },
    getModels: (state, getters, rootState, rootGetters) => {
      let models = [];
      if (state.filter.transport.models != undefined) {
        models = state.filter.transport.models.map(trans => { return trans.id });
      }
      return models;
    },
    getBrands: (state, getters, rootState, rootGetters) => {
      let transports = [];
      if (state.filter.transport.brands != undefined) {
        transports = state.filter.transport.brands.map(trans => { return trans.id });
      }
      return transports;
    },
    getCountries: (state, getters, rootState, rootGetters) => {
      let countries = [];
      if (state.filter.location.countries != undefined) {
        countries = state.filter.location.countries.map(count => { return count.id });
      }
      return countries;
    },
    getSettlements: (state, getters, rootState, rootGetters) => {
      let settlements = [];
      if (state.filter.location.settlements != undefined) {
        settlements = state.filter.location.settlements.map(count => { return count.id });
      }
      return settlements;
    },
    getSubjects: (state, getters, rootState, rootGetters) => {
      let subjects = [];
      if (state.filter.location.subjects != undefined) {
        subjects = state.filter.location.subjects.map(count => { return count.id });
      }
      return subjects;
    },
    getSortBy: (state, getters, rootState, rootGetters) => {
      let sortBy = [];
      if (
        state.sortBy
      ) {
        for (let sort of state.sortBy) {
          if (state.filter.sortBy != undefined) {
            let filter = state.filter.sortBy;
            let selected = filter.filter((fil) => { return fil.value == sort.id ? 1 : 0 }).length == 1 ? true : false;
            sortBy.push({
              value: sort.id,
              option: sort.name,
              selected: selected
            });
          } else {
            sortBy.push({
              value: sort.id,
              option: sort.name,
              selected: false
            });
          }
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
          if (state.filter.helm != undefined) {
            let filter = state.filter.helm;
            let selected = filter.filter((fil) => { return fil.value == helm.id ? 1 : 0 }).length == 1 ? true : false;
            helms.push({
              value: helm.id,
              option: helm.name,
              selected: selected
            });
          } else {
            helms.push({
              value: helm.id,
              option: helm.name,
              selected: false
            });
          }
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
          if (state.filter.fuel != undefined) {
            let filter = state.filter.fuel;
            let selected = filter.filter((fil) => { return fil.value == fuel.id ? 1 : 0 }).length == 1 ? true : false;
            fuels.push({
              value: fuel.id,
              option: fuel.name,
              selected: selected,
            });
          } else {
            fuels.push({
              value: fuel.id,
              option: fuel.name,
              selected: false,
            });
          }
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
          if (state.filter.drive != undefined) {
            let filter = state.filter.drive;
            let selected = filter.filter((fil) => { return fil.value == drive.id ? 1 : 0 }).length == 1 ? true : false;
            drives.push({
              value: drive.id,
              option: drive.name,
              selected: selected,
            });
          } else {
            drives.push({
              value: drive.id,
              option: drive.name,
              selected: false,
            });
          }
        }
      }
      return drives;
    },
    getTransmissions: (state, getters, rootState, rootGetters) => {
      let transmissions = [];
      if (rootState.transports.transmissions) {
        for (let transmission of rootState.transports.transmissions) {
          if (state.filter.transmission != undefined) {
            let filter = state.filter.transmission;
            let selected = filter.filter((fil) => { return fil.value == transmission.id ? 1 : 0 }).length == 1 ? true : false;
            transmissions.push({
              value: transmission.id,
              option: transmission.name,
              selected: selected,
            });
          } else {
            transmissions.push({
              value: transmission.id,
              option: transmission.name,
              selected: false,
            });
          }
        }
      }
      return transmissions;
    },
    getBodies: (state, getters, rootState, rootGetters) => {
      let bodies = [];
      if (rootState.transports.bodies) {
        for (let body of rootState.transports.bodies) {
          let selected = false;
          if (state.filter.body != undefined) {
            let filter = state.filter.body;
            selected = filter.filter((fil) => { return fil.value == body.id ? 1 : 0 }).length == 1 ? true : false;
          }
          bodies.push({
            value: body.id,
            option: body.name,
            selected: selected,
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
        let selected = false;
        if (state.filter.year != undefined) {
          let filter = state.filter.year;
          selected = filter.filter((fil) => { return fil.value == maxDate ? 1 : 0 }).length == 1 ? true : false;
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
          selected = filter.filter((fil) => { return fil.value == maxDate ? 1 : 0 }).length == 1 ? true : false;
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
    getPrice: (state, getters, rootState, rootGetters) => {
      let price = "";
      if (state.filter.price != undefined) {
        price = state.filter.price;
      }
      return price;
    },
    getPriceBef: (state, getters, rootState, rootGetters) => {
      let price = "";
      if (state.filter.priceBef != undefined) {
        price = state.filter.priceBef;
      }
      return price;
    },
    getVolume: (state, getters, rootState, rootGetters) => {
      let volume = "";
      if (state.filter.volume != undefined) {
        volume = state.filter.volume;
      }
      return volume;
    },
    getVolumeBef: (state, getters, rootState, rootGetters) => {
      let volume = "";
      if (state.filter.volumeBef != undefined) {
        volume = state.filter.volumeBef;
      }
      return volume;
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
  actions: {

  }

};
export default filter_add;
