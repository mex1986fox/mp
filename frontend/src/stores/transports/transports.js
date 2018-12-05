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
    bodies: undefined,
    transmissions: undefined
  },
  getters: {
    getTransport: (state, getters, rootState, rootGetters) => id => {
      if (state.transports!=undefined) {
        for (let transport of state.transports) {
          if (id == transport.id) {
            return transport;
          }
        }
      } else {
        return undefined;
      }
    },
    getBrand: (state, getters, rootState, rootGetters) => id => {
      if (state.brands!=undefined) {
        for (let brand of state.brands) {
          if (id == brand.id) {
            return brand;
          }
        }
      } else {
        return undefined;
      }
    },
    getModel: (state, getters, rootState, rootGetters) => id => {
      if (state.models != undefined) {
        for (let model of state.models) {
          if (id == model.id) {
            return model;
          }
        }
      } else {
        return undefined;
      }
    },
    getFuel: (state, getters, rootState, rootGetters) => id => {
      if (state.fuels != undefined) {
        for (let fuel of state.fuels) {
          if (id == fuel.id) {
            return fuel;
          }
        }
      } else {
        return undefined;
      }
    },
    getDrive: (state, getters, rootState, rootGetters) => id => {
      if (state.drives != undefined) {
        for (let drive of state.drives) {
          if (id == drive.id) {
            return drive;
          }
        }
      } else {
        return undefined;
      }
    },
    getTransmission: (state, getters, rootState, rootGetters) => id => {
      if (state.transmissions != undefined) {
        for (let transmission of state.transmissions) {
          if (id == transmission.id) {
            return transmission;
          }
        }
      } else {
        return undefined;
      }
    }
  },
  mutations: {
    updateTransports(state, transport) {
      // state.transports = transport.transports;
      // state.brands = transport.brands;
      // state.models = transport.models;
      let transports = transport.transports;
      state.transports = transports.map(transp => {
        transp["extended_name"] =
          transp["name"].charAt(0).toUpperCase() + transp["name"].slice(1);
        return transp;
      });

      let brands = transport.brands;
      state.brands = brands.map(brand => {
        let transp_name = transports.filter(transp => {
          return transp.id == brand.transport_id;
        })[0].name;
        brand["extended_name"] = brand["name"] + " (" + transp_name + ")";
        return brand;
      });

      let models = transport.models;
      state.models = models.map(model => {
        let brand_name = brands.filter(brand => {
          return brand.id == model.brand_id;
        })[0].name;
        model["extended_name"] = model["name"] + " (" + brand_name + ")";
        return model;
      });
      state.drives = transport.drives;
      state.fuels = transport.fuels;
      state.volums = transport.volums;
      state.bodies = transport.bodies;
      state.transmissions = transport.transmissions;
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
        state.bodies == undefined ||
        state.transmissions == undefined
      ) {
        Vue.http.post("/api/show/transports").then(
          response => {
            let transports = response.body;
            context.commit("updateTransports", transports);
          },
          error => {}
        );
      }
    }
  }
};
export default transports;
