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
                    @click="isShowFormPosts"
                    class="ui-button ui-button_blue pg-ads__button-add"
                  >добавить пост</div>
                </div>
                <div class="wg-content-frame wg-content-frame_left wg-content-frame__padding">
                  <div @click="showFilterPosts=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-sliders"></i>
                    </div>Фильтр постов
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
          <div class="row" v-for=" (val, key) in posts" :key="key">
            <div class="col-12">
              <div class="wg-content-frame wg-content-frame_center">
                <wg-card-post :post="JSON.parse(JSON.stringify(val))"></wg-card-post>
                <!-- <wg-card-posts :post="JSON.parse(JSON.stringify(post))"></wg-card-posts> -->
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
                    @click="isShowFormPosts"
                    class="ui-button ui-button_blue pg-ads__button-add"
                  >добавить пост</div>
                </div>
              </div>
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame__padding">
                  <div @click="showFilterPosts=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-sliders"></i>
                    </div>Фильтр постов
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
      <!-- Фильтр сообщений -->
      <div class="col_12">
        <ui-blind :show="showFilterPosts" @onHide="showFilterPosts=false" animate="right">
          <div class="container container_right">
            <div class="row">
              <div
                class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
              >
                <wg-filter-posts @onHide="showFilterPosts=false"></wg-filter-posts>
              </div>
            </div>
          </div>
        </ui-blind>
      </div>
      <!-- форма размещения постов -->
      <div class="col_12">
        <wg-form-posts :show="showFormPosts" @onHide="showFormPosts=false" :key="'form-posts-'+keyFormPosts"></wg-form-posts>
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
            v-if="!showFormPosts"
            @click="isShowFormPosts"
            class="ui-button ui-button_circle pg-ads__button-show-form-add"
            :class="{'pg-ads__button-show-form-add_bottom': buttonShowFormPostsBottom }"
          >
            <i class="fa fa-plus" aria-hidden="true"></i>
          </div>
        </transition>
        <ui-bar-bottom>
          <div @click="showFilterPosts=true" class="ui-bar-bottom__tab">
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
  name: "pg-posts",
  data() {
    return {
      posts: undefined,
      showFilterPosts: false,
      showMessenger: false,
      showFormPosts: false,
      keyFormPosts: 0,
      buttonShowFormPostsBottom: false
    };
  },
  computed: {},
  methods: {
    isShowFormPosts() {
      this.showFormPosts = true;
      this.keyFormPosts++;
    },
    loadPosts() {
      // console.dir(this.$store.state.filter_add.filter);
      // let params = this.$store.state.filter_add.filter;
      let params = {};
      let headers = { "Content-Type": "multipart/form-data" };
      this.$http.post("/api/show/posts", params, headers).then(
        response => {
          this.posts = response.body.posts;
          this.loadPhotosPosts();
        },
        error => {}
      );
    },
    loadPhotosPosts() {
      let posts_id = [];
      this.posts.forEach(element => {
        posts_id.push(element.id);
      });
      let params = { posts_id: posts_id };
      let headers = { "Content-Type": "multipart/form-data" };
      this.$http
        .post(this.$hosts.photosPosts + "/api/show/photos", params, headers)
        .then(
          response => {
            let lincks = response.body.posts;
            lincks.forEach(linck => {
              this.posts = this.posts.map((ad, key) => {
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
      this.posts.forEach(element => {
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
            this.posts = this.posts.map((ad, key, arr) => {
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
      this.posts.forEach(element => {
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
              this.posts = this.posts.map((ad, key, arr) => {
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
      this.buttonShowFormPostsBottom = false;
    });
    document.addEventListener("onTouchBottom", () => {
      this.buttonShowFormPostsBottom = true;
    });
    this.loadPosts();
  }
};
</script>