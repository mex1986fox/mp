<template>
  <layout>
    <div class="container">
      <div class="row">
        <!-- левый блок -->
        <div class="col_3 col-tablet_4 col-phone_clean">
          <ui-fixed-block>
            <div class="row">
              <div class="col-12 col-nbook_clean col-desktop_clean">
                <div class="wg-content-frame wg-content-frame_left wg-content-frame__padding">
                  <div
                    @click="isShowFormFotos"
                    class="ui-button ui-button_blue pg-ads__button-add"
                  >добавить фотографии</div>
                </div>
                <div class="wg-content-frame wg-content-frame_left wg-content-frame_no-border">
                  <div @click="showFilterPhotos=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-sliders"></i>
                    </div>Фильтр фотографий
                  </div>
                  <div @click="showMessenger=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-envelope"></i>
                    </div>Мессенджер
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_left">
                  <wg-frame-friends></wg-frame-friends>
                </div>
              </div>
            </div>
          </ui-fixed-block>
        </div>
        <!-- центральный блок -->
        <div class="col_6 col-tablet_8 col-phone_6">
          <div class="row" v-for="(val, key) in albums" :key="key">
            <div class="col-12">
              <div class="wg-content-frame wg-content-frame_center">
                <wg-card-album :album="JSON.parse(JSON.stringify(val))"></wg-card-album>
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
                    @click="isShowFormFotos"
                    class="ui-button ui-button_blue pg-ads__button-add"
                  >добавить фотографии</div>
                </div>
              </div>
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame_no-border">
                  <div @click="showFilterPhotos=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-sliders"></i>
                    </div>Фильтр фотографий
                  </div>
                  <div @click="showMessenger=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-envelope"></i>
                    </div>Мессенджер
                  </div>
                </div>
              </div>
            </div>
          </ui-fixed-block>
        </div>
      </div>
    </div>
    <div class="row">
      <!-- Фильтр фотографий -->
      <div class="col_12">
        <wg-filter-album :show="showFilterPhotos" @onHide="showFilterPhotos=false"></wg-filter-album>
      </div>
      <!-- форма размещения фотографий -->
      <div class="col_12">
        <wg-form-photos
          :show="showFormPhotos"
          @onHide="showFormPhotos=false"
          :key="showFormPhotos+keyForm"
        ></wg-form-photos>
      </div>
      <!-- мессенджер -->
      <div class="col_12">
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
    </div>
    <div class="row">
      <div class="col_12 col-desktop_clean col-nbook_clean col-tablet_clean">
        <transition name="pg-albums__button-show-form-add">
          <div
            v-if="!showFormPhotos"
            @click="isShowFormFotos"
            class="ui-button ui-button_circle pg-albums__button-show-form-add"
            :class="{'pg-albums__button-show-form-add_bottom': buttonShowFormPhotosBottom }"
          >
            <i class="fa fa-plus" aria-hidden="true"></i>
          </div>
        </transition>
        <ui-bar-bottom>
          <div @click="showFilterPhotos=true" class="ui-bar-bottom__tab">
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
    <div class="col_12">
      <ui-snackbar :show="showSnackbar" @onHide="showSnackbar=false" :time="15000">{{descSnackbar}}</ui-snackbar>
    </div>
  </layout>
</template>

<script>
export default {
  name: "pg-photos",
  data() {
    return {
      photos: undefined,
      showFilterPhotos: false,
      showMessenger: false,
      showFormPhotos: false,
      buttonShowFormPhotosBottom: false,
      showSnackbar: false,
      descSnackbar: "",
      keyForm: 0,
      albums: undefined
    };
  },
  computed: {},
  methods: {
    isShowFormFotos() {
      if (this.$store.state.user.id != undefined) {
        this.keyForm++;
        this.showFormPhotos = true;
      } else {
        this.descSnackbar =
          "Добавлять фотографии могут только авторизованные пользователи. Войдите или зарегистрируйтесь.";
        this.showSnackbar = true;
      }
    },
    loadFilter() {
      this.$http.post("/api/show/albumsFilter").then(
        response => {
          let filter = response.body.filter;
          this.$store.commit("filter_album/setFilters", JSON.parse(filter));
          this.loadAlbums();
        },
        error => {
          this.loadAlbums();
        }
      );
    },
    loadAlbums() {
      // console.dir(this.$store.state.filter_add.filter);
      let params = this.$store.state.filter_album.filter;
      let headers = { "Content-Type": "multipart/form-data" };
      this.$http.post("/api/show/albums", params, headers).then(
        response => {
          this.albums = response.body.albums;
          this.loadPhotosAlbums();
        },
        error => {}
      );
    },
    loadPhotosAlbums() {
      let albums_id = [];
      this.albums.forEach(element => {
        albums_id.push(element.id);
      });
      let params = { albums_id: albums_id };
      let headers = { "Content-Type": "multipart/form-data" };
      this.$http
        .post(this.$hosts.photosAlbums + "/api/show/photos", params, headers)
        .then(
          response => {
            let lincks = response.body.albums;
            lincks.forEach(linck => {
              this.albums = this.albums.map((ad, key) => {
                if (ad.id == linck.id) {
                  ad.slide = linck.lincks.map(src => {
                    return { src: src };
                  });
                }
                return ad;
              });
            });
            this.loadUsers();
          },
          error => {}
        );
    },
    loadUsers() {
      let users_id = [];
      this.albums.forEach(element => {
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
            this.albums = this.albums.map((ad, key, arr) => {
              if (ad.user_id == user.id) {
                arr[key].user = user;
              }
              return ad;
            });
          });

          this.loadUsersAvatars();
        },
        error => {}
      );
    },
    loadUsersAvatars() {
      let users_id = [];
      this.albums.forEach(element => {
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
              this.albums = this.albums.map((ad, key, arr) => {
                if (ad.user_id == avatar.user_id) {
                  arr[key].user.avatar = avatar.lincks[0];
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
    document.addEventListener("onTouchTop", () => {
      this.buttonShowFormPhotosBottom = false;
    });
    document.addEventListener("onTouchBottom", () => {
      this.buttonShowFormPhotosBottom = true;
    });
    this.loadFilter();
  }
};
</script>