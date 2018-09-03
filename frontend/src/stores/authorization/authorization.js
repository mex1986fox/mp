const authorization = {
  namespaced: true,
  state: {
    navigationStore: [
      { value: "ui дизайн", link: "/ui", check: false },
      { value: "виджеты", link: "/widgets", check: true },
      { value: "типы", link: "/types", check: false },
      { value: "бренды", link: "/brands", check: false },
      { value: "модели", link: "/models", check: false }
    ]
  },
  mutations: {
    //обновляет transportBrands
    updateNavigationStore(state, newProperty) {
      state.transportBrands = newProperty;
    }
  }
};
export default authorization;
