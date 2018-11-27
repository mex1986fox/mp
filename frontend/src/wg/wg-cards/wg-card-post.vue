<template>
    <div class="wg-card-post">
        <div class="wg-card-post__header">
            <div class="ui-avatar-block wg-card-post__avatar-block">
                <div class="ui-avatar">
                    <img src="/public/img/avatar.jpg" alt="">
                </div>
                <div class="ui-link ui-avatar-block__link">Alisochka Frolova</div>
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
        >Пост про мастодонта Chevrolet Camaro</a>
        <wg-slider
            class="wg-card-post__slider"
            :slide="JSON.parse(JSON.stringify(slides))"
            :select="numberPhoto"
            @onSelect="isSelectPhoto"
            @onZoom="isZoomPhoto"
        ></wg-slider>
        <wg-slider-zoom
            v-if="showZoomSlider"
            :slide="JSON.parse(JSON.stringify(slides))"
            :slideNavigation="JSON.parse(JSON.stringify(slides))"
            :select="numberZoomPhoto"
            :show="showZoomSlider"
            @onHide="showZoomSlider=false"
        ></wg-slider-zoom>
        <transition name="wg-card-post__description">
            <span class="ui-description ui-description_mini wg-card-ad__description">
                Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ab quo earum voluptates harum dolores omnis neque enim facilis quae modi blanditiis tempore esse fuga, expedita maxime iste reiciendis distinctio minima.
                Ipsa sed perferendis quo autem, odit temporibus laudantium, quaerat et unde esse provident animi aliquam tempora in doloribus tempore corrupti quod quidem asperiores placeat. Maxime sunt sed molestias quasi vel?
                Tempora reprehenderit ipsum quos blanditiis sint voluptatum culpa quia soluta doloribus dolorem asperiores eius voluptas a totam unde, perferendis labore, expedita nihil quae reiciendis, praesentium corporis accusamus? Veniam, corporis blanditiis?
            </span>
        </transition>
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
      numberPhoto: 1,
      numberZoomPhoto: 1,
      showZoomSlider: false,
      commentShow: false,
      slides: [
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852445.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852304.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852320.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852338.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852364.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852393.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852424.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852445.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852304.jpg"
        },
        {
          src:
            "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852320.jpg"
        }
      ]
    };
  },
  methods: {
    isDascActive() {
      this.descActive = !this.descActive;
    },
    isSelectPhoto(numberPhoto) {
      this.numberPhoto = numberPhoto;
    },
    isZoomPhoto(numberPhoto) {
      //   console.log(numberPhoto);
      this.showZoomSlider = true;
      this.numberZoomPhoto = numberPhoto;
    }
  }
};
</script>
