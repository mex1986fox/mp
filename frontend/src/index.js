require("./ui/index.scss");
require("./wg/index.scss");
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
//import Vue from 'vue'
import Vue from "vue/dist/vue.js";
import router from "./router/index.js";
import store from "./stores/index.js";


// подключаем библиотеку UI-простейшие компоненты
import "./ui/index.js";
// подключаем библиотеку WG-компоненты виджетов
import "./wg/index.js";
// подключаем лейаут
import Layout from "./pages/layout.vue";
Vue.component("layout", Layout);

//подключаем библиотеку для работы с куками
var VueCookie = require('vue-cookie');
Vue.use(VueCookie);

//подключаем библиотеку AJAX запросов
import Resourсe from "vue-resource";
Vue.use(Resourсe);
// Vue.http.headers.common['Authorization'] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImRkYjRkOGZkZDg4MWFmODg0YWE2NDQ3NjNhMTczNzIxNjU1Nzk4ZWU4N2I0MjA5YjM4MDM4MDA4NWNhNjQwZjNhNDc0NWU3M2Y0OWM5NjhiIn0.eyJhdWQiOiI0IiwianRpIjoiZGRiNGQ4ZmRkODgxYWY4ODRhYTY0NDc2M2ExNzM3MjE2NTU3OThlZTg3YjQyMDliMzgwMzgwMDg1Y2E2NDBmM2E0NzQ1ZTczZjQ5Yzk2OGIiLCJpYXQiOjE1MjE0NDk3NjAsIm5iZiI6MTUyMTQ0OTc2MCwiZXhwIjoxNTUyOTg1NzYwLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.l-VKBTy3ZTky_h7o__H87yr1dYmMVsgNwoWJ_RVhen209PRZlcAV0uw0AcrZvEO2j6jcegcvYP1caqUCdQL6C-5W8h2XmLViOAADtVKS2E872Sea1R3gHopFDipScpkcKgrJT1kd8w8RUe4-EN7E2nNkDBvK5F5F2AzQ2mwz8Ao3iA2J7Ijx3DphCio5FGgfLZlRsHSiElmyX3k0D7EeDJ4yvQpfQ2liYEbQ0a6G-PHnfdKFw6om-aw7a9YJFR5pKrRlbxYREdvp9eaJ4fkiOyq2pwUdtIZz4AtnWUgX5K_b0Uw82207MfTZ1VspB7MJxjUeXF1Z-nSNVhcmgtMLl-Czw89DbLVa9diGcUk9H7JrCA-B5jAXOVpMIOw4vR0VATkW3ojBnYZC3KkSdr-9uoMChSqXO7roy608YpgNuNrn-uNbAp4tJ0gRearabfYpQHWPjFboriNuF9tKSD6vnL2RZiUqW1qexVmOp2Arj03w22Xj_mK2lfPThtonBebBU4age9Y883B23mquXXw2U2ZJ6NI36gbZ50kiuESe7kdcNcdDnpCnm4TS-WmUPAkAy0qN9HubaRQGb27MEhn99Xp7c_GkZYygWvM5H3l52Vml1WZA4KGw9IpjsSpRQK6_h29K2RNXY7PlAW7H0xMaPK_KtgF1e0Bnr3KOn65hIJc";

//создаем глобальную шину событий
// Object.defineProperty(
//   Vue.prototype,
//   "$eventBus",
//   {
//     get: function () { return this.$root.eventBus; }
//   }
// );
// const EventBus=new Vue({});

// Vue.config.productionTip = false

/* eslint-disable no-new */
const vue = new Vue({
  router,
  store,
  //   //глобальная шина событий
  //   data: {
  //     eventBus: EventBus
  //   },
  //   created() {
  //     //загружаем типы транспорта в глобальное хранилище
  //     store.dispatch('download');
  //   }
  mounted() {
    this.$store.dispatch("locations/loadLocations");
    this.$store.dispatch("transports/loadTransports");
  }
}).$mount("#app");
