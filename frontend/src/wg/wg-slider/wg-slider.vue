<template>
  <transition name="wg-slider" appear>
    <div class="wg-slider" @mouseover="buttonsShow=true" @mouseout="buttonsShow=false">
      <div class="wg-slider__buttons" :style="marginButtons" v-show="buttonsShow">
        <div class="wg-slider__left-button">
          <button
            @click="clickLeft()"
            class="ui-button ui-button_circle ui-button_flat wg-slider__button_flat"
          >
            <i aria-hidden="true" class="fa fa-angle-left"></i>
          </button>
        </div>
        <div class="wg-slider__right-button">
          <button
            @click="clickRight()"
            class="ui-button ui-button_circle ui-button_flat wg-slider__button_flat"
          >
            <i aria-hidden="true" class="fa fa-angle-right"></i>
          </button>
        </div>
      </div>
      <div class="wg-slider__menu" v-show="buttonsShow">
        <div class="wg-slider__numeric">{{positionIndex+1}}/{{dSlides.length}}</div>
      </div>
      <div ref="container" class="wg-slider__container">
        <div class="wg-slider__frame" v-for="(val, key) in dSlides" :key="key" @click="isZoom()">
          <img class="wg-slider__fon" :src="val.src">
          <img class="wg-slider__img" :src="val.src">
        </div>
      </div>
    </div>
  </transition>
</template>
<script>
export default {
  data() {
    return {
      buttonsShow: false,
      dSlides: this.slides,
      sliderWidth: undefined, //длина слайдера
      containerWidth: undefined, //длина контейнера
      positionIndex: this.select,
      marginButtons: {}
    };
  },
  props: {
    // {src:""}
    slides: { type: Array, default: () => [] },
    select: { type: [Number, String], default: 0 }
  },
  watch: {
    slides(newQ) {
      this.dSlides = newQ;
      this.containerWidth = this.dSlides.length * 100;
    },
    select(newQ) {
      this.positionIndex = newQ;
      this.isSelect();
    }
  },
  mounted() {
    this.$refs.container.addEventListener("onTouchLeft", () => {
      this.clickLeft();
    });
    this.$refs.container.addEventListener("onTouchRight", () => {
      this.clickRight();
    });
    this.containerWidth = this.dSlides.length * 100;
    this.sliderWidth = 100 / this.dSlides.length;
    this.$refs.container.style.cssText = "width: " + this.containerWidth + "%;";
    let domSlides = this.$refs.container.querySelectorAll(".wg-slider__frame");
    domSlides.forEach(slide => {
      slide.style.cssText = "width: " + this.sliderWidth + "%;";
      let img = slide.querySelector(".wg-slider__img");
      img.addEventListener("load", () => {
        this.setPositionImg(slide, img);
      });
    });
    this.isSelect();
    this.centerButtons();
  },
  methods: {
    isSelect() {
      this.centerButtons();
      this.dSlides = this.dSlides.map((slide, key) => {
        if (key == this.positionIndex) {
          return { src: slide.src, select: true };
        }
        return { src: slide.src, select: false };
      });
      this.$refs.container.style.cssText =
        "width: " +
        this.containerWidth +
        "%; margin-left: -" +
        this.positionIndex * 100 +
        "%; transition: margin-left 0.6s;";
      this.$emit("onSelect", this.positionIndex, this.dSlides);
    },
    //вызывает событие увеличения фотографий на весь экран
    isZoom() {
      this.$emit("onZoom", this.positionIndex);
    },
    // выравнивает кнопки по центру
    centerButtons() {
      if (this.$refs.container.clientHeight > 66) {
        this.marginButtons = {
          marginTop: this.$refs.container.clientHeight / 2 + "px"
        };
      } else {
        this.marginButtons = {};
      }
    },
    // листает слайдер влево
    clickLeft() {
      if (this.dSlides.length < this.positionIndex + 2) {
        this.positionIndex = 0;
      } else {
        this.positionIndex++;
      }
      this.isSelect();
    },
    // вправо
    clickRight() {
      if (1 > this.positionIndex) {
        this.positionIndex = this.dSlides.length - 1;
      } else {
        this.positionIndex--;
      }
      this.isSelect();
    },
    //опредляет расположение горизонтальное или вертикальное
    locSlide(elem) {
      if (elem.clientWidth - elem.clientHeight >= 0) {
        return "hor";
      }
      return "ver";
    },
    locImg(elem) {
      if (elem.naturalWidth - elem.naturalHeight >= 0) {
        return "hor";
      }
      return "ver";
    },
    //устанавливает выравнивание картинки относительно блока
    setPositionImg(slide, img) {
      if (this.locSlide(slide) == "hor" && this.locImg(img) == "hor") {
        img.className = "wg-slider__img wg-slider__img_vertical";
      }
      if (this.locSlide(slide) == "hor" && this.locImg(img) == "ver") {
        img.className = "wg-slider__img wg-slider__img_vertical";
      }
      if (this.locSlide(slide) == "ver" && this.locImg(img) == "hor") {
        img.className = "wg-slider__img wg-slider__img_horizon";
      }
      if (this.locSlide(slide) == "ver" && this.locImg(img) == "ver") {
        img.className = "wg-slider__img wg-slider__img_vertical";
      }
    }
  }
};
</script>
