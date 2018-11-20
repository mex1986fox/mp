<template>
  <layout>
    <div class="container" v-if="showAds">
      <div class="row">
        <div class="col_12">
          <ui-snackbar
            :show="showSnackbar"
            @onHide="showSnackbar=false"
            :time="15000"
          >{{descSnackbar}}</ui-snackbar>
        </div>
        <!-- левый блок -->
        <div class="col_3 col-tablet_4 col-phone_clean">
          <div class="col-nbook_clean col-desktop_clean">
            <div class="row">
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_left wg-content-frame__padding">
                  <div
                    @click="isShowFormAdd"
                    class="ui-button ui-button_red pg-ads__button-add"
                  >добавить объявление</div>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <div class="wg-content-frame wg-content-frame_left wg-content-frame__padding">
                    <div @click="showFilterAdd=true" class="ui-navigation__unit__button">
                      <div class="ui-navigation__unit__icon">
                        <i aria-hidden="true" class="fa fa-sliders"></i>
                      </div>Фильтр объявлений
                    </div>
                    <div @click="showMessenger=true" class="ui-navigation__unit__button">
                      <div class="ui-navigation__unit__icon">
                        <i aria-hidden="true" class="fa fa-envelope"></i>
                      </div>Мессенджер
                    </div>
                    <div class="ui-navigation__unit__button">
                      <div class="ui-navigation__unit__icon">
                        <i aria-hidden="true" class="fa fa-user-o"></i>
                      </div>Друзья
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="wg-content-frame wg-content-frame_left">
                <div class="ui-avatar-block wg-card-ad__avatar-block" v-for="key in 5" :key="key">
                  <div class="ui-avatar">
                    <span class="ui-avatar__simbol">f</span>
                    <img alt="" src="http://photos-users.ru/public/photos/avatars/6/Koala.jpg">
                  </div>
                  <a class="ui-link ui-avatar-block__link">firefox firefox</a>
                  <div class="ui-avatar-block__title">2018-10-17 18:21</div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- центральный блок -->
        <div class="col_6 col-tablet_8 col-phone_6">
          <div class="row">
            <div class="col-12">
              <div
                v-for="(val, key) in cads"
                :key="key"
                class="wg-content-frame wg-content-frame_center"
              >
                <wg-card-ad :object="JSON.parse(JSON.stringify(val))"></wg-card-ad>
              </div>
            </div>
          </div>
        </div>
        <!-- правый блок -->
        <div class="col_3 col-phone_3 col-tablet_clean col-phone_clean">
          <ui-fixed-block>
            <div class="row">
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame__padding">
                  <div
                    @click="isShowFormAdd"
                    class="ui-button ui-button_red pg-ads__button-add"
                  >добавить объявление</div>
                </div>
              </div>
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame__padding">
                  <div @click="showFilterAdd=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-sliders"></i>
                    </div>Фильтр объявлений
                  </div>
                  <div @click="showMessenger=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-envelope"></i>
                    </div>Мессенджер
                  </div>
                  <div class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-user-o"></i>
                    </div>Друзья
                  </div>
                </div>
              </div>
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame__padding">
                  <div
                    @click="isShowFormAdd"
                    class="ui-button ui-button_red pg-ads__button-add"
                  >добавить объявление</div>
                </div>
              </div>
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame__padding">
                  <div
                    @click="isShowFormAdd"
                    class="ui-button ui-button_red pg-ads__button-add"
                  >добавить объявление</div>
                </div>
              </div>
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame__padding">
                  <div
                    @click="isShowFormAdd"
                    class="ui-button ui-button_red pg-ads__button-add"
                  >добавить объявление</div>
                </div>
              </div>
            </div>
          </ui-fixed-block>
        </div>
      </div>
    </div>
    <div class="row">
      <!-- форма добавления объявлений -->
      <div class="col_12">
        <ui-blind :show="showFormAdd" @onHide="showFormAdd=false" animate="right">
          <div class="container container_right">
            <div class="row">
              <div
                class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
              >
                <wg-form-add @onHide="
								     showFormAdd=false
								     "></wg-form-add>
              </div>
            </div>
          </div>
        </ui-blind>
      </div>
      <!-- Фильтр сообщений -->
      <div class="col_12">
        <ui-blind :show="showFilterAdd" @onHide="showFilterAdd=false" animate="right">
          <div class="container container_right">
            <div class="row">
              <div
                class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
              >
                <wg-filter-add @onHide="showFilterAdd=false"></wg-filter-add>
              </div>
            </div>
          </div>
        </ui-blind>
      </div>
      <!-- мессенджер -->
      <ui-blind @onHide="showMessenger=!showMessenger" :show="showMessenger" animate="opacity">
        <div class="container">
          <div class="row">
            <div
              class="col_8 col_offset-2 col-nbook_10 col-nbook_offset-1 col-tablet_12 col-tablet_offset-0 col-phone_6 col-phone_offset-0"
            >
              <wg-messanger @onHide="showMessenger=false"></wg-messanger>
            </div>
          </div>
        </div>
      </ui-blind>
    </div>
    <div class="row">
      <div class="col_12 col-desktop_clean col-nbook_clean col-tablet_clean">
        <transition name="pg-ads__button-show-form-add">
          <div
            v-if="!showFormAdd"
            @click="isShowFormAdd"
            class="ui-button ui-button_circle ui-button_red pg-ads__button-show-form-add"
            :class="{'pg-ads__button-show-form-add_bottom': buttonShowFormAddBottom }"
          >
            <i class="fa fa-plus" aria-hidden="true"></i>
          </div>
        </transition>
        <ui-bar-bottom>
          <div @click="showFilterAdd=true" class="ui-bar-bottom__tab">
            <i aria-hidden="true" class="fa fa-sliders"></i>
            <ui-click-feedback></ui-click-feedback>
          </div>
          <div @click="showMessenger=true" class="ui-bar-bottom__tab">
            <i class="fa fa-envelope" aria-hidden="true"></i>
            <ui-click-feedback></ui-click-feedback>
          </div>
          <div class="ui-bar-bottom__tab">
            <i class="fa fa-user-o" aria-hidden="true"></i>
            <ui-click-feedback></ui-click-feedback>
          </div>
          <div class="ui-bar-bottom__tab">
            <i aria-hidden="true" class="fa fa-sliders"></i>
            <ui-click-feedback></ui-click-feedback>
          </div>
        </ui-bar-bottom>
      </div>
    </div>
  </layout>
</template>

<script>
export default {
  name: "pg-ads",
  data() {
    return {
      showFormAdd: false,
      showFilterAdd: false,
      showSnackbar: false,
      showMessenger: false,
      descSnackbar: "",
      ads: undefined,
      buttonShowFormAddBottom: false
    };
  },
  computed: {
    cads() {
      return this.ads;
    },
    showAds() {
      if (
        this.ads != undefined &&
        this.$store.state.transports.brands != undefined &&
        this.$store.state.locations.subjects != undefined
      ) {
        return true;
      }
      return false;
    }
  },
  methods: {
    isShowFormAdd() {
      if (this.$store.state.user.id != undefined) {
        this.showFormAdd = true;
      } else {
        this.descSnackbar =
          "Добавлять объявления могут только авторизованные пользователи. Войдите или зарегистрируйтесь.";
        this.showSnackbar = true;
      }
    },

    show(event) {
      this.$http.post("/api/show/ads").then(
        response => {
          this.ads = response.body.ads;
          this.updateUsers();
        },
        error => {}
      );
    },
    updateUsers() {
      let users_id = [];
      this.ads.forEach(element => {
        users_id.push(element.user_id);
      });
      let params = {
        users_id: users_id.filter((e, i, a) => a.indexOf(e) == i)
      };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http.post("/api/show/users", params, headers).then(
        response => {
          let users = response.body.users;
          users.forEach(user => {
            this.ads = this.ads.map((ad, key, arr) => {
              if (ad.user_id == user.id) {
                arr[key].user = user;
              }
              return ad;
            });
          });

          this.updatePhotoAvatars();
        },
        error => {}
      );
    },

    updatePhotoAvatars() {
      let users_id = [];
      this.ads.forEach(element => {
        users_id.push(element.user_id);
      });
      let params = {
        users_id: users_id.filter((e, i, a) => a.indexOf(e) == i)
      };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.photosUsers + "/api/show/avatars", params, headers)
        .then(
          response => {
            let avatars = response.body.avatars;
            avatars.forEach(avatar => {
              this.ads = this.ads.map((ad, key, arr) => {
                if (ad.user_id == avatar.user_id) {
                  arr[key].user.avatar = avatar.lincks[0];
                }
                return ad;
              });
            });

            this.updatePhotoLincks();
          },
          error => {}
        );
    },
    updatePhotoLincks() {
      let ads_id = [];
      this.ads.forEach(element => {
        ads_id.push(element.id);
      });
      let params = { ads_id: ads_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.photosAds + "/api/show/photos", params, headers)
        .then(
          response => {
            let lincks = response.body.ads;
            lincks.forEach(linck => {
              this.ads = this.ads.map((ad, key) => {
                if (ad.id == linck.id) {
                  ad.slide = linck.lincks.map(src => {
                    return { src: src };
                  });
                }
                return ad;
              });
            });
            this.updateLikes();
          },
          error => {}
        );
    },
    updateLikes() {
      let ads_id = [];
      this.ads.forEach(element => {
        ads_id.push(element.id);
      });
      let params = { ads_id: ads_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.likes + "/api/show/ads", params, headers)
        .then(
          response => {
            let likes = response.body.likes;
            likes.forEach(like => {
              this.ads = this.ads.map((ad, key) => {
                if (ad.id == like.ads_id) {
                  ad.likes = like.likes;
                  ad.dislikes = like.dislikes;
                }
                return ad;
              });
            });
            this.updateComments();
          },
          error => {}
        );
    },
    updateComments() {
      let ads_id = [];
      this.ads.forEach(element => {
        ads_id.push(element.id);
      });
      let params = { ads_id: ads_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.comments + "/api/length/ads", params, headers)
        .then(
          response => {
            let lengths = response.body.lengths;
            lengths.forEach(length => {
              this.ads = this.ads.map((ad, key) => {
                if (ad.id == length.ads_id) {
                  ad.commentsLength = length.length;
                }
                return ad;
              });
            });
          },
          error => {}
        );
    }
  },

  mounted() {
    this.show();

    document.addEventListener("onTouchTop", () => {
      this.buttonShowFormAddBottom = false;
    });
    document.addEventListener("onTouchBottom", () => {
      this.buttonShowFormAddBottom = true;
    });
  }
};
</script>
