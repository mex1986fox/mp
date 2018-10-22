const Hosts = {
  install(Vue, options) {
    // 1. добавление глобального метода или свойства
    Vue.prototype.$hosts = {
      photosAds: "http://photos-ads.ru",
      photosUsers: "http://photos-users.ru",
      likes: "http://likes.ru",
      comments: "http://comments.ru",
      messages: "http://messages.ru",
      wsmessages: "ws://127.0.0.1:8085"
    };
  }
};
export default Hosts;
