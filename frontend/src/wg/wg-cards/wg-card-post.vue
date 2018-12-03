<template>
  <div class="wg-card-post">
    <div class="wg-card-post__header">
      <div class="ui-avatar-block wg-card-post__avatar-block">
        <ui-avatar :lable="dPost.user ? dPost.user.login:''">
          <img :src="dPost.user && dPost.user.avatar ? dPost.user.avatar:''" alt>
        </ui-avatar>
        <div
          class="ui-link ui-avatar-block__link"
        >{{dPost.user ? dPost.user.name+' '+dPost.user.surname:''}}</div>
        <div class="ui-avatar-block__title">25/17/2018</div>
      </div>

      <button
        @click="showMenu=true"
        class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-card-post__header-button"
      >
        <i class="fa fa-ellipsis-v" aria-hidden="true"></i>
      </button>
      <ui-menu :show="showMenu" @onHide="showMenu=false" position="left-bottom">
        <ul class="wg-card-post__menu">
          <li class="wg-card-post__menu-li">Комментарии</li>
          <li class="wg-card-post__menu-li">Пожаловаться</li>
        </ul>
      </ui-menu>
    </div>

    <a
      class="ui-link wg-card-post__link"
      href="http://google.com"
    >{{dPost.name!=undefined?dPost.name:""}}</a>
    <template v-if="dPost.slide!=undefined">
      <wg-slider
        class="wg-card-post__slider"
        :slides="JSON.parse(JSON.stringify(dPost.slide))"
        @onSelect="isSelectPhoto"
        @onZoom="isZoomPhoto"
        :select="numberPhoto"
      ></wg-slider>
      <wg-slider-navig
        class="wg-card-post__slider-navig"
        :slides="JSON.parse(JSON.stringify(dPost.slide))"
        :select="numberPhoto"
        @onSelect="isSelectPhoto"
      ></wg-slider-navig>

      <wg-slider-zoom
        v-if="showZoomSlider"
        :slides="JSON.parse(JSON.stringify(dPost.slide))"
        :select="numberZoomPhoto"
        :show="showZoomSlider"
        @onHide="showZoomSlider=false"
      ></wg-slider-zoom>
    </template>

    <span class="ui-description ui-description_mini wg-card-ad__description">
      {{dPost.description}}
    </span>

    <div class="wg-card-post__buttons">
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
  name: "wg-card-post",
  data() {
    return {
      showMenu: false,
      descActive: false,
      numberPhoto: 0,
      numberZoomPhoto: 1,
      showZoomSlider: false,
      commentShow: false,
      dPost: this.post
    };
  },
  props: {
    post: {
      type: Object,
      default: () => {}
    }
  },
  watch: {
    post(newQ) {
      this.dPost = newQ;
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
    }
  }
};
</script>
