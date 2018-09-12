import Vue from "vue/dist/vue.js";
const form_add = {
  namespaced: true,
  state: {},
  getters: {
    getSubjects(state, getters, rootState, rootGetters) {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let subjects = [];

      for (let subject of rootState.locations.subjects) {
        subjects.push({
          value: subject.id,
          option: subject.name,
          group: subject.name[0]
        });
      }
      return subjects;
    },
    getSettlements: (state, getters, rootState, rootGetters) => id => {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let settlements = [];

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
      return settlements;
    },
    getBrands(state, getters, rootState, rootGetters) {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let brands = [];

      for (let brand of rootState.transports.brands) {
        brands.push({
          value: brand.id,
          option: brand.name,
          group: brand.name[0]
        });
      }
      return brands;
    },
    getModels: (state, getters, rootState, rootGetters) => id => {
      // {value:"1",option:"Audi", group:"Область", selected:true}
      let models = [];

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
      return models;
    },
    getFuels: (state, getters, rootState, rootGetters) => {
      let fuels = [];

      for (let fuel of rootState.transports.fuels) {
        fuels.push({
          value: fuel.id,
          option: fuel.name,
          group: "Топливо"
        });
      }
      return fuels;
    },
    getVolums: (state, getters, rootState, rootGetters) => idFuels => {
      let volums = [];
      for (let volum of rootState.transports.volums) {
        if (rootState.transports.fuels[idFuels].name != "электро") {
          volums.push({
            value: volum.id,
            option: volum.value,
            group: "Объем"
          });
        }
      }
      return volums;
    },
    getBodies: (state, getters, rootState, rootGetters) => {
      let bodies = [];
      for (let body of rootState.transports.bodies) {
        bodies.push({
          value: body.id,
          option: body.name,
          group: body.name[0]
        });

      }
      return bodies;
    },

  },
  mutations: {
    update(state, transport) { }
  },
  actions: {}
};
export default form_add;
