<template>
  <ui-blind :show="showFormPhotos" @onHide="showFormPhotos=false" animate="right">
    <div v-if="showFormPhotos" class="container container_right">
      <div class="row">
        <div
          class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
        >
          <div class="wg-form-add" ref="form">
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
                    <ui-tabs-tab id="basick" :checked="tabs=='basick'" @onFocus="isTabs">Альбом</ui-tabs-tab>
                    <ui-tabs-tab id="photo" :checked="tabs=='photo'" @onFocus="isTabs">Фотографии</ui-tabs-tab>
                    <ui-tabs-tab
                      id="excess"
                      :checked="tabs=='excess'"
                      @onFocus="isTabs"
                    >Дополнительно</ui-tabs-tab>
                  </ui-tabs>
                </div>
                <div v-show="tabs=='basick'">
                  <form v-if="album_id==undefined" id="formCreatePhotos" @submit.prevent="create">
                    <div class="wg-form-add__content">
                      <div class="wg-form-add__hr">Альбом</div>
                      <div class="row">
                        <div class="col_6">
                          <ui-text name="name" caption="Название нового альбома"></ui-text>
                        </div>
                      </div>
                    </div>
                    <div class="wg-form-add__buttons">
                      <button class="ui-button ui-button_blue" type="submit">Добавить альбом</button>
                    </div>
                  </form>
                  <form
                    v-if="album_id!=undefined"
                    id="formUpdatePhotos"
                    @submit.prevent="updateAlbum"
                  >
                    <div class="wg-form-add__content">
                      <div class="wg-form-add__hr">Альбом</div>
                      <div class="row">
                        <div class="col_6">
                          <ui-text name="name" caption="Новое название альбома"></ui-text>
                        </div>
                      </div>
                    </div>
                    <div class="wg-form-add__buttons">
                      <button class="ui-button ui-button_blue" type="submit">Изменить альбом</button>
                    </div>
                  </form>
                </div>
                <div v-show="tabs=='photo'">
                  <div class="wg-form-add__content">
                    <div class="wg-form-add__hr">
                      <!-- <i class="fa fa-camera" aria-hidden="true"></i> -->
                      Фотографии
                    </div>
                    <div v-if="slide!=undefined">
                      <wg-slider
                        class="wg-card-photo__slider"
                        :slides="slide"
                        :select="selectPhoto"
                        @onSelect="isSelectPhoto"
                      ></wg-slider>
                      <div
                        @click="deletePhotos"
                        class="ui-button ui-button_circle ui-button_flat wg-form-add__delete wg-slider__button_flat"
                      >
                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                      </div>
                      <wg-slider-navig
                        class="wg-card-photo__slider-navig"
                        :slides="slide"
                        :select="selectPhoto"
                        @onSelect="isSelectPhoto"
                      ></wg-slider-navig>
                    </div>
                    <form
                      id="formLoadPhotos"
                      enctype="multipart/form-data"
                      @submit.prevent="loadPhotos"
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
                  <div class="wg-form-add__buttons"></div>
                </div>
                <div v-show="tabs=='excess'">
                  <form
                    v-if="album_id!=undefined"
                    id="formUpdateExcess"
                    @submit.prevent="updateAlbum"
                  >
                    <div class="wg-form-add__content">
                      <div class="wg-form-add__hr">
                        <!-- <i class="fa fa-camera" aria-hidden="true"></i> -->
                        Дополнительно
                      </div>
                      <div class="row">
                        <div class="col_12">
                          <wg-select-location caption="Страна, регион, город"></wg-select-location>
                        </div>
                        <div class="col_12">
                          <wg-select-transport caption="Тип транспорта, марка, модель"></wg-select-transport>
                        </div>
                        <div class="col_3">
                          <ui-select name="year" caption="Год выпуска" :menu="menuYear"></ui-select>
                        </div>
                      </div>
                    </div>
                    <div class="wg-form-add__buttons">
                      <button class="ui-button ui-button_blue" type="submit">Добавить данные</button>
                    </div>
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
  name: "wg-form-photos",
  data() {
    return {
      showFormPhotos: this.show,
      tabs: "basick",
      descSnackbar: "",
      showSnackbar: false,
      selectPhoto: 0,
      selectPhotoObj: undefined,
      rirendLoader: false,
      percentFL: undefined,
      photoLincks: undefined,
      album_id: undefined
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
      this.showFormPhotos = newQ;
      this.autoHeight();
    }
  },
  mounted() {
    window.addEventListener("resize", () => {
      this.autoHeight();
    });
    this.autoHeight();
  },
  methods: {
    isClose() {
      this.$emit("onHide");
    },
    isTabs(id) {
      this.tabs = id;
    },
    // устанавливает  длину контейнера контетнта
    autoHeight() {
      setTimeout(() => {
        if (this.$refs.form != undefined) {
          let height = window.document.body.clientHeight - 259;
          let contents = this.$refs.form.querySelectorAll(
            ".wg-form-add__content"
          );
          contents.forEach(content => {
            content.style.cssText = "min-height: " + height + "px";
          });
        }
      }, 4);
    },
    isSelectPhoto(nPhoto, objPhoto) {
      this.selectPhoto = nPhoto;
      if (objPhoto != undefined) {
        this.selectLinck = undefined;
        objPhoto.forEach(photo => {
          if (photo.select == true) {
            this.selectLinck = photo.src;
            return;
          }
        });
      }
    },
    create(event) {
      let body = new FormData(event.target);
      this.$http.post("/api/create/albums", body).then(
        response => {
          this.tabs = "photo";
          this.album_id = response.body.id;
          this.showSnackbar = false;
          this.showSnackbar = true;
          this.descSnackbar =
            "Альбом успешно создан. Можете добавить фотографии.";
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
    updateAlbum() {
      let body = new FormData(event.target);
      body.set("session_id", this.$cookie.get("PHPSESSID"));
      body.set("user_id", this.$cookie.get("user_id"));
      body.set("album_id", this.album_id);

      this.$http.post("/api/update/albums", body).then(
        response => {
          this.tabs = "photo";
          this.album_id = response.body.id;
          this.showSnackbar = false;
          this.showSnackbar = true;
          this.descSnackbar = "Альбом успешно изменен.";
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
    loadPhotos() {
      this.numberFL = 1;
      let form = document.getElementById("formLoadPhotos");
      let body = new FormData(form);
      body.set("session_id", this.$cookie.get("PHPSESSID"));
      body.set("user_id", this.$cookie.get("user_id"));
      body.set("album_id", this.album_id);
      this.$http
        .post(this.$hosts.photosAlbums + "/api/create/photos", body, {
          progress: function(e) {
            if (e.lengthComputable) {
              this.percentFL = (e.loaded / e.total) * 100;
            }
          }.bind(this)
        })
        .then(
          response => {
            this.descSnackbar = "Фотографии успешно добавлены. ";
            this.updatePhotoLincks();
          },
          error => {}
        );
    },
    deletePhotos() {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        session_id: this.$cookie.get("PHPSESSID"),
        user_id: this.$cookie.get("user_id"),
        album_id: this.album_id,
        linck: this.selectLinck
      };
      this.$http
        .post(this.$hosts.photosAlbums + "/api/delete/photos", params, headers)
        .then(
          response => {
            this.descSnackbar = "Фотография успешно удалена.";
            this.updatePhotoLincks();
          },
          error => {}
        );
    },
    updatePhotoLincks() {
      let params = { album_id: this.album_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.photosAlbums + "/api/show/photos", params, headers)
        .then(
          response => {
            this.photoLincks = undefined;
            this.rirendLoader = true;
            setTimeout(() => {
              this.percentFL = undefined;
              this.rirendLoader = false;
              this.photoLincks = response.body.albums[0].lincks;
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
    },
    menuYear() {
      return this.$store.getters["form_album/getYears"];
    }
  }
};
</script>

