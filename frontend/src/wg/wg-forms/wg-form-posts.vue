<template>
  <ui-blind :show="showFormPosts" @onHide="showFormPosts=false" animate="right">
    <div v-if="showFormPosts" class="container container_right">
      <div class="row">
        <div
          class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
        >
          <div class="wg-form-add" :style="{'min-height': windowHeight+'px'} ">
            <div class="row">
              <div class="col-12">
                <div class="wg-form-add__bar">
                  <div class="ui-header ui-header_2 wg-form-add__header">
                    <span>Форма подачи фотографий</span>
                  </div>
                  <button
                    class="ui-button ui-button_circle ui-button_flat wg-form-add__close"
                    @click="isClose"
                  >
                    <i class="fa fa-angle-right"></i>
                  </button>
                  <ui-tabs class="wg-form-add__tabs">
                    <ui-tabs-tab id="basick" :checked="tabs=='basick'" @onFocus="isTabs">Пост</ui-tabs-tab>
                    <ui-tabs-tab id="photo" :checked="tabs=='photo'" @onFocus="isTabs">Фотографии</ui-tabs-tab>
                  </ui-tabs>
                </div>
                <div class="wg-form-add__content" v-show="tabs=='basick'">
                  <form v-if="post_id==undefined" id="formCreatePosts" @submit.prevent="create">
                    <div class="wg-form-add__hr">Пост</div>
                    <div class="row">
                      <div class="col_6">
                        <ui-text name="name" caption="Название нового поста"></ui-text>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col_12">
                        <ui-textarea name="description" caption="Описание" :autoresize="250"></ui-textarea>
                      </div>
                    </div>
                    <div class="wg-form-add__buttons">
                      <button class="ui-button ui-button_blue" type="submit">Добавить пост</button>
                    </div>
                  </form>
                  <form
                    v-if="post_id!=undefined"
                    id="formUpdatePosts"
                    @submit.prevent="updatePost"
                  >
                    <div class="wg-form-add__hr">Пост</div>
                    <div class="row">
                      <div class="col_6">
                        <ui-text name="name" caption="Новое название поста"></ui-text>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col_12">
                        <ui-textarea name="description" caption="Описание" :autoresize="250"></ui-textarea>
                      </div>
                    </div>
                    <div class="wg-form-add__buttons">
                      <button class="ui-button ui-button_blue" type="submit">Изменить пост</button>
                    </div>
                  </form>
                </div>
                <div class="wg-form-add__content" v-show="tabs=='photo'">
                  <div class="wg-form-add__hr">
                    <!-- <i class="fa fa-camera" aria-hidden="true"></i> -->
                    Фотографии
                  </div>
                  <div v-if="slide!=undefined">
                    <wg-slider
                      class="wg-card-photo__slider"
                      :slides="slide"
                      :select="selectPost"
                      @onSelect="isSelectPost"
                    ></wg-slider>
                    <div
                      @click="deletePosts"
                      class="ui-button ui-button_circle ui-button_flat wg-form-add__delete wg-slider__button_flat"
                    >
                      <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </div>
                    <wg-slider-navig
                      class="wg-card-photo__slider-navig"
                      :slides="slide"
                      :select="selectPost"
                      @onSelect="isSelectPost"
                    ></wg-slider-navig>
                  </div>
                  <form
                    id="formLoadPosts"
                    enctype="multipart/form-data"
                    @submit.prevent="loadPosts"
                  >
                    <ui-file
                      v-if="!rirendLoader"
                      caption="Выберите фотографии"
                      captionCompleted="Выбранные фотографии"
                      :autoresize="300"
                      accept="image/*"
                      :percent="percentFL"
                    ></ui-file>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col_12">
          <ui-snackbar
            :show="showSnackbar"
            @onHide="showSnackbar=false"
            :time="10000"
          >{{descSnackbar}}</ui-snackbar>
        </div>
      </div>
    </div>
  </ui-blind>
</template>
<script>
export default {
  name: "wg-form-posts",
  data() {
    return {
      showFormPosts: this.show,
      windowHeight: document.body.clientHeight,
      tabs: "basick",
      descSnackbar: "",
      showSnackbar: false,
      selectPost: 0,
      selectPostObj: undefined,
      rirendLoader: false,
      percentFL: undefined,
      photoLincks: undefined,
      post_id: undefined
    };
  },
  props: {
    show: {
      type: Boolean,
      default: false
    }
  },
  watch: {
    show(newQ) {
      this.showFormPosts = newQ;
    }
  },
  methods: {
    isClose() {
      this.$emit("onHide");
    },
    isTabs(id) {
      this.tabs = id;
    },
    isSelectPost(nPost, objPost) {
      this.selectPost = nPost;
      if (objPost != undefined) {
        this.selectLinck = undefined;
        objPost.forEach(photo => {
          if (photo.select == true) {
            this.selectLinck = photo.src;
            return;
          }
        });
      }
    },
    create(event) {
      let body = new FormData(event.target);
      this.$http.post("/api/create/posts", body).then(
        response => {
          this.tabs = "photo";
          this.post_id = response.body.id;
          this.showSnackbar = false;
          this.showSnackbar = true;
          this.descSnackbar =
            "Пост успешно создан. Можете добавить фотографии.";
        },
        error => {
          let massege = error.body.exceptions.massege;

          if (massege != undefined) {
            this.showSnackbar = false;
            this.showSnackbar = true;
            this.descSnackbar = massege;
          }
        }
      );
    },
    updatePost() {
      let body = new FormData(event.target);
      body.set("session_id", this.$cookie.get("PHPSESSID"));
      body.set("user_id", this.$cookie.get("user_id"));
      body.set("post_id", this.post_id);

      this.$http.post("/api/update/posts", body).then(
        response => {
          this.tabs = "photo";
          this.post_id = response.body.id;
          this.showSnackbar = false;
          this.showSnackbar = true;
          this.descSnackbar =
            "Пост успешно изменен. Можете добавить фотографии.";
        },
        error => {
          let massege = error.body.exceptions.massege;

          if (massege != undefined) {
            this.showSnackbar = false;
            this.showSnackbar = true;
            this.descSnackbar = massege;
          }
        }
      );
    },
    loadPosts() {
      this.numberFL = 1;
      let form = document.getElementById("formLoadPosts");
      let body = new FormData(form);
      body.set("session_id", this.$cookie.get("PHPSESSID"));
      body.set("user_id", this.$cookie.get("user_id"));
      body.set("post_id", this.post_id);
      this.$http
        .post(this.$hosts.photosPosts + "/api/create/photos", body, {
          progress: function(e) {
            if (e.lengthComputable) {
              this.percentFL = (e.loaded / e.total) * 100;
            }
          }.bind(this)
        })
        .then(
          response => {
            this.descSnackbar = "Фотографии успешно добавлены. ";
            this.updatePostLincks();
          },
          error => {}
        );
    },
    deletePosts() {
      console.dir("delete")
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        session_id: this.$cookie.get("PHPSESSID"),
        user_id: this.$cookie.get("user_id"),
        post_id: this.post_id,
        linck: this.selectLinck
      };
      this.$http
        .post(this.$hosts.photosPosts + "/api/delete/photos", params, headers)
        .then(
          response => {
            this.descSnackbar = "Фотография успешно удалена.";
            this.updatePostLincks();
          },
          error => {}
        );
    },
    updatePostLincks() {
      let params = { post_id: this.post_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.photosPosts + "/api/show/photos", params, headers)
        .then(
          response => {
            this.photoLincks = undefined;
            this.rirendLoader = true;
            setTimeout(() => {
              this.percentFL = undefined;
              this.rirendLoader = false;
              this.photoLincks = response.body.posts[0].lincks;
              this.showSnackbar = false;
              this.showSnackbar = true;
            }, 4);
          },
          error => {}
        );
    }
  },
  computed: {
    slide() {
      if (this.photoLincks != undefined) {
        return this.photoLincks.map(function(slide) {
          return { src: slide };
        });
      }
      return undefined;
    }
  }
};
</script>

