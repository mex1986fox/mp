import Vue from "vue/dist/vue.js";
const filter_add = {
  namespaced: true,
  state: {
    sort: [
      { id: 1, name: "дате (новые)" },
      { id: 2, name: "дате (старые)" },
      { id: 3, name: "цене (дорогие)" },
      { id: 4, name: "цене (дешевые)" },
      { id: 5, name: "году (новые)" },
      { id: 6, name: "оду (старые)" },
      { id: 7, name: "пробегу (маленький)" },
      { id: 8, name: "пробегу (большой)" },
      { id: 9, name: "объему (маленький)" },
      { id: 10, name: "объему (большой)" }
    ],
    wheels: [{ id: 1, name: "левый" }, { id: 2, name: "правый" }],
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

    getWheels: (state, getters, rootState, rootGetters) => {
      let wheels = [];
      if (state.wheels) {
        for (let wheel of state.wheels) {
          if (state.filter.wheel != undefined) {
            let filter = state.filter.wheel;
            let selected =
              filter.filter(fil => {
                return fil == wheel.id ? 1 : 0;
              }).length == 1
                ? true
                : false;
            wheels.push({
              value: wheel.id,
              option: wheel.name,
              selected: selected
            });
          } else {
            wheels.push({
              value: wheel.id,
              option: wheel.name,
              selected: false
            });
          }
        }
      }
      return wheels;
    },
    getFuels: (state, getters, rootState, rootGetters) => {
      let fuels = [];
      if (rootState.transports.fuels) {
        for (let fuel of rootState.transports.fuels) {
          if (state.filter.fuel != undefined) {
            let filter = state.filter.fuel;
            let selected =
              filter.filter(fil => {
                return fil == fuel.id ? 1 : 0;
              }).length == 1
                ? true
                : false;
            fuels.push({
              value: fuel.id,
              option: fuel.name,
              selected: selected
            });
          } else {
            fuels.push({
              value: fuel.id,
              option: fuel.name,
              selected: false
            });
          }
        }
      }
      return fuels;
    },
    getDrives: (state, getters, rootState, rootGetters) => {
      let drives = [];
      if (rootState.transports.drives) {
        for (let drive of rootState.transports.drives) {
          if (state.filter.drive != undefined) {
            let filter = state.filter.drive;
            let selected =
              filter.filter(fil => {
                return fil == drive.id ? 1 : 0;
              }).length == 1
                ? true
                : false;
            drives.push({
              value: drive.id,
              option: drive.name,
              selected: selected
            });
          } else {
            drives.push({
              value: drive.id,
              option: drive.name,
              selected: false
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
            let selected =
              filter.filter(fil => {
                return fil == transmission.id ? 1 : 0;
              }).length == 1
                ? true
                : false;
            transmissions.push({
              value: transmission.id,
              option: transmission.name,
              selected: selected
            });
          } else {
            transmissions.push({
              value: transmission.id,
              option: transmission.name,
              selected: false
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
            selected =
              filter.filter(fil => {
                return fil == body.id ? 1 : 0;
              }).length == 1
                ? true
                : false;
          }
          bodies.push({
            value: body.id,
            option: body.name,
            selected: selected
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
  actions: {}
};
export default filter_add;
