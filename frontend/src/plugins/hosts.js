const Hosts = {
  install(Vue, options) {
    // 1. добавление глобального метода или свойства
    Vue.prototype.$hosts = {
      photosAds: "http://photos-ads.ru",
      photosUsers: "http://photos-users.ru",
      likes:"http://likes.ru",
      comments:"http://comments.ru"
    };
  }
};
export default Hosts;
