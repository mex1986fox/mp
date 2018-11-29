<template>
  <ui-blind ref="blind" class="wg-slider-zoom__blind" :show="dShow" @onHide="dShow=false">
    <div class="container">
      <div class="row">
        <div class="col_12">
          <button
            @click="dShow=false"
            class="ui-button ui-button_circle ui-button_flat wg-slider-zoom__button-exit"
          >
            <i class="fa fa-times" aria-hidden="true"></i>
          </button>
          <div class="wg-slider-zoom" :style="{height: height+'px'}" v-if="dShow">
            <wg-slider
              ref="slider"
              class="wg-slider-zoom__slider"
              :slides="dSlides"
              :select="numberPhoto"
              @onSelect="isSelectPhoto"
              animate="none"
            ></wg-slider>
          </div>
          <wg-slider-navig
            class="wg-slider-zoom__slider-navig"
            :slides="dSlidesNav"
            :select="numberPhoto"
            @onSelect="isSelectPhoto"
          ></wg-slider-navig>
        </div>
      </div>
    </div>
  </ui-blind>
</template>
<script>
export default {
  name: "wg-slider-zoom",
  data() {
    return {
      height: document.body.clientHeight,
      numberPhoto: this.select,
      dSlides: this.slides,
      dSlidesNav: JSON.parse(JSON.stringify(this.slides)),
      dShow: this.show
    };
  },

  updated() {
    if (this.dShow == true) {
      this.$refs.slider.$el.style.height =
        this.$refs.blind.$el.clientHeight + "px";
    }
  },
  watch: {
    select(newQ) {
      this.numberPhoto = newQ;
    },
    show(newQ) {
      this.dShow = newQ;
    },
    dShow(newQ) {
      if (newQ == false) {
        this.$emit("onHide");
      }
    },
    slides(newQ) {
      this.dSlides = newQ;
      this.dSlidesNav = JSON.parse(JSON.stringify(newQ));
    }
  },
  props: {
    slides: {
      type: Array,
      default: () => []
    },
    slidesNavigation: {
      type: Array,
      default: () => []
    },
    select: {
      type: Number,
      default: 0
    },
    show: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    isSelectPhoto(number) {
      this.numberPhoto = number;
    }
  }
};
</script>
