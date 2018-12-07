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
        <ul class="wg-card-album__menu">
          <li class="wg-card-album__menu-li">Комментарии</li>
          <li class="wg-card-album__menu-li">Пожаловаться</li>
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
    <ui-blind
      ref="blind"
      :show="commentShow"
      @onHide="commentShow=false"
      :centering="true"
      animate="opacity"
    >
      <div class="container">
        <div class="row">
          <div class="col_8 col_offset-2">
            <button
              @click="commentShow=false"
              class="ui-button ui-button_circle ui-button_circle_big ui-button_flat wg-card-ad__comments-close"
            >
              <i aria-hidden="true" class="fa fa-times"></i>
            </button>
            <wg-comments></wg-comments>
          </div>
        </div>
      </div>
    </ui-blind>
  </div>
</template>
<script>
export default {
  name: "wg-card-album",
  data() {
    return {
      showMenu: false,
      descActive: false,
      numberPhoto: 0,
      numberZoomPhoto: 1,
      showZoomSlider: false,
      commentShow: false,
      dAlbum: this.album,
      dSlide: undefined
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
    }
  }
};
</script>
