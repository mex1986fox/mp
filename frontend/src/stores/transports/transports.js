import Vue from "vue/dist/vue.js";
const transports = {
  namespaced: true,
  state: {
    transports: undefined,
    brands: undefined,
    models: undefined,
    drives: undefined,
    fuels: undefined,
    volums: undefined,
    bodies: undefined
  },
  getters: {
    getBrand: (state, getters, rootState, rootGetters) => id => {
      for (let brand of state.brands) {
        if (id == brand.id) {
          return brand;
        }
      }
      return undefined;
    },
    getModel: (state, getters, rootState, rootGetters) => id => {
      for (let model of state.models) {
        if (id == model.id) {
          return model;
        }
      }
      return undefined;
    }
  },
  mutations: {
    updateTransports(state, transport) {
      state.transports = transport.transports;
      state.brands = transport.brands;
      state.models = transport.models;
      state.drives = transport.drives;
      state.fuels = transport.fuels;
      state.volums = transport.volums;
      state.bodies = transport.bodies;
    }
  },
  actions: {
    loadTransports(context) {
      let state = context.state;
      if (
        state.transports == undefined ||
        state.brands == undefined ||
        state.models == undefined ||
        state.drives == undefined ||
        state.fuels == undefined ||
        state.volums == undefined ||
        state.bodies == undefined
      ) {
        Vue.http.post("/api/show/transports").then(
          response => {
            let transports = response.body;
            context.commit("updateTransports", transports);
          },
          error => { }
        );
      }
    }
  }
};
export default transports;
