<template>
  <div class="wg-card-album">
    <div class="wg-card-album__header">
      <div class="ui-avatar-block wg-card-album__avatar-block">
        <ui-avatar :lable="dAlbum.user ? dAlbum.user.login:''">
          <img :src="dAlbum.user && dAlbum.user.avatar ? dAlbum.user.avatar:''" alt>
        </ui-avatar>
        <div
          class="ui-link ui-avatar-block__link"
        >{{dAlbum.user ? dAlbum.user.name+' '+dAlbum.user.surname:''}}</div>
        <div class="ui-avatar-block__title">{{parseDate(dAlbum.date_create)}}</div>
      </div>

      <button
        @click="showMenu=true"
        class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-card-album__header-button"
      >
        <i class="fa fa-ellipsis-v" aria-hidden="true"></i>
      </button>
      <ui-menu :show="showMenu" @onHide="showMenu=false" position="left-bottom">
        <ul
          v-if="user_id!=undefined && dAlbum.user!=undefined && user_id==dAlbum.user.id"
          class="wg-card-ad__menu"
        >
          <li class="wg-card-ad__menu-li" @click="(showMenu=false, showEditor=true)">Редактировать</li>
          <li class="wg-card-ad__menu-li" @click="(showMenu=false, showDroper=true)">Удалить</li>
        </ul>
        <ul v-else class="wg-card-ad__menu">
          <li
            @click="(showMenu=false, showDroper=true)"
            class="wg-card-ad__menu-li"
          >Показать контакты</li>
          <li
            @click="(showMenu=false, showMessenger=true)"
            class="wg-card-ad__menu-li"
          >Написать сообщение</li>
        </ul>
      </ui-menu>
    </div>

    <a
      class="ui-link wg-card-album__link"
      href="http://google.com"
    >{{dAlbum.name!=undefined?dAlbum.name:""}}</a>
    <template v-if="dSlide!=undefined">
      <wg-slider
        class="wg-card-album__slider"
        :slides="JSON.parse(JSON.stringify(dSlide))"
        @onSelect="isSelectPhoto"
        @onZoom="isZoomPhoto"
        :select="numberPhoto"
      ></wg-slider>
      <wg-slider-navig
        class="wg-card-album__slider-navig"
        :slides="JSON.parse(JSON.stringify(dSlide))"
        :select="numberPhoto"
        @onSelect="isSelectPhoto"
      ></wg-slider-navig>

      <wg-slider-zoom
        v-if="showZoomSlider"
        :slides="JSON.parse(JSON.stringify(dSlide))"
        :select="numberZoomPhoto"
        :show="showZoomSlider"
        @onHide="showZoomSlider=false"
      ></wg-slider-zoom>
    </template>

    <div class="wg-card-album__buttons">
      <button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
        <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
      </button>
      <span class="wg-card-ad__counter">123 000</span>
      <button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
        <i class="fa fa-thumbs-o-down" aria-hidden="true"></i>
      </button>
      <span class="wg-card-ad__counter">9 990</span>
      <button
        @click="commentShow=true"
        class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat"
      >
        <i class="fa fa-comments-o" aria-hidden="true"></i>
      </button>
      <span class="wg-card-ad__counter">296</span>
    </div>
       <div class="wg-card-ad__comments" v-if="commentShow">
      <wg-comments :service_id="dAlbum.id" :service_type="'albums'" @onHide="commentShow=false"></wg-comments>
    </div>
    <!-- редактор альбома -->
    <wg-editor-photos :id="dAlbum.id" :show="showEditor" @onHide="showEditor=false"></wg-editor-photos>
    <!-- окно удаления -->
    <ui-blind
      @onHide="showDroper=!showDroper"
      :show="showDroper"
      animate="opacity"
      centering
      :selector="'.ui-modal-window'"
      class="pg-authorization__blind"
    >
      <div class="container">
        <div class="row">
          <div class="col_6 col_offset-3 col-phone_6 col-phone_offset-0">
            <div class="row">
              <div class="col_12">
                <div class="ui-modal-window">
                  <div class="ui-modal-window__header">
                    <button
                      @click="showDroper=false"
                      class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat ui-modal-window__header__button"
                    >
                      <i class="fa fa-times" aria-hidden="true"></i>
                    </button>
                    Удаление альбома
                  </div>
                  <div class="ui-modal-window__content">
                    <div
                      class="ui-description ui-description_mini"
                    >Вы действительно хотите удалить альбом?</div>
                  </div>
                  <div class="ui-modal-window__footer-buttons">
                    <div class="ui-button ui-button_blue" @click="dropAlbum">Удалить</div>
                    <div class="ui-button ui-button_flat" @click="showDroper=false">Отмена</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </ui-blind>
    <div class="row">
			<div class="col_12">
				<ui-snackbar :show="showSnackbar" @onHide="showSnackbar=false" :time="20000">{{descSnackbar}}</ui-snackbar>
			</div>
		</div>
  </div>
</template>
<script>
export default {
  name: "wg-card-album",
  data() {
    return {
      user_id: this.$cookie.get("user_id"),
      showEditor: false,
      showDroper: false,
      showMenu: false,
      descActive: false,
      numberPhoto: 0,
      numberZoomPhoto: 1,
      showZoomSlider: false,
      commentShow: false,
      dAlbum: this.album,
      dSlide: undefined,
      showSnackbar: false,
      descSnackbar: undefined
    };
  },
  props: {
    album: {
      type: Object,
      default: () => {}
    }
  },
  watch: {
    album(newQ) {
      this.dAlbum = newQ;
      let slides = JSON.parse(newQ.lincks).lincks;
      this.dSlide = undefined;
      this.dSlide = slides.map(slide => {
        return { src: slide };
      });
    }
  },
  methods: {
    isDascActive() {
      this.descActive = !this.descActive;
    },
    isSelectPhoto(numberPhoto, obj) {
      this.numberPhoto = numberPhoto;
      // console.log(this.numberPhoto)
    },
    isZoomPhoto(numberPhoto) {
      // console.log(numberPhoto);
      this.showZoomSlider = true;
      this.numberZoomPhoto = numberPhoto;
    },
    addZero(i) {
      if (i < 10) {
        i = "0" + i;
      }
      return i;
    },
    parseDate(date) {
      let newDate = new Date(date);

      return (
        newDate.getFullYear() +
        "-" +
        newDate.getMonth() +
        "-" +
        newDate.getDate() +
        " " +
        this.addZero(newDate.getHours()) +
        ":" +
        this.addZero(newDate.getMinutes())
      );
    },
    dropAlbum() {
      let params = {
        album_id: this.album.id,
        user_id: this.user_id,
        session_id: this.$cookie.get("PHPSESSID")
      };
      let headers = { "Content-Type": "multipart/form-data" };
      this.$http
        .post(this.$hosts.albums + "/api/delete/albums", params, headers)
        .then(
          response => {
            this.showSnackbar=true;
            this.showDroper=false;
            this.descSnackbar="Альбом удален успешно";
            this.$emit("onDeleteAlbum", this.dAlbum);
          },
          error => {}
        );
    }
  }
};
</script>
