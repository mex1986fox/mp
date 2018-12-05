import Vue from "vue/dist/vue.js";
const form_album = {
  namespaced: true,
  state: {},
  getters: {
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
export default form_album;
