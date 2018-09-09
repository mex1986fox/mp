const Hosts = {
  install(Vue, options) {
    // 1. добавление глобального метода или свойства
    Vue.prototype.$hosts = {
      photosAds: "http://photos-ads.ru"
    };
  }
};
export default Hosts;
