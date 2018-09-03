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
    }
  },
  mutations: {
    update(state, transport) {}
  },
  actions: {}
};
export default form_add;
