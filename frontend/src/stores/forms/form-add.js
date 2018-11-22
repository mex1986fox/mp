import Vue from "vue/dist/vue.js";
const form_add = {
  namespaced: true,
  state: {},
  getters: {
    getSubjects(state, getters, rootState, rootGetters) {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let subjects = [];
      if (rootState.locations.subjects) {
        for (let subject of rootState.locations.subjects) {
          subjects.push({
            value: subject.id,
            option: subject.name,
            group: subject.name[0]
          });
        }
      }

      return subjects;
    },
    getSettlements: (state, getters, rootState, rootGetters) => id => {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let settlements = [];
      if (rootState.locations.settlements) {
        for (let settlement of rootState.locations.settlements) {
          if (id == settlement.subject_id) {
            settlements.push({
              value: settlement.id,
              option: settlement.name,
              group: settlement.name[0],
              selected: settlements.length == 0 ? true : false
            });
          }
        }
      }

      return settlements;
    },
    getBrands(state, getters, rootState, rootGetters) {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let brands = [];
      if (rootState.transports.brands) {
        for (let brand of rootState.transports.brands) {
          brands.push({
            value: brand.id,
            option: brand.name,
            group: brand.name[0]
          });
        }
      }

      return brands;
    },
    getModels: (state, getters, rootState, rootGetters) => id => {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let models = [];
      if (rootState.transports.models) {
        for (let model of rootState.transports.models) {
          if (id == model.brand_id) {
            models.push({
              value: model.id,
              option: model.name,
              group: model.name[0],
              selected: models.length == 0 ? true : false
            });
          }
        }
      }

      return models;
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
    getVolums: (state, getters, rootState, rootGetters) => idFuels => {
      let volums = [];

      rootState.transports.fuels.forEach(fuel => {
        if (fuel.id == idFuels && fuel.name.toLowerCase() != "электро") {
          rootState.transports.volums.forEach(volum => {
            volums.push({
              value: volum.id,
              option: volum.value,
              group: "Объем"
            });
          });
        }
      });

      return volums;
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
          selected: menu.length == 0 ? true : false
        });
        maxDate--;
      }
      return menu;

    }
  },
  mutations: {
    update(state, transport) { }
  },
  actions: {}
};
export default form_add;
