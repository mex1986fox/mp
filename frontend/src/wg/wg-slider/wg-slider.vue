<template>
  <div class="wg-slider"
    @mouseover="buttonsShow=true"
    @mouseout="buttonsShow=false">
    <div class="wg-slider__buttons"
      :style="marginButtons"
      v-show="buttonsShow">
      <div class="wg-slider__left-button"
        @click="leafLeft">
        <button class="ui-button ui-button_circle ui-button_flat wg-slider__button_flat">
          <i aria-hidden="true"
            class="fa fa-angle-left"></i>
        </button>
      </div>
      <div class="wg-slider__right-button"
        @click="leafRight">
        <button class="ui-button ui-button_circle ui-button_flat wg-slider__button_flat">
          <i aria-hidden="true"
            class="fa fa-angle-right"></i>
        </button>
      </div>
    </div>
    <div class="wg-slider__menu"
      v-show="buttonsShow">
      <div class="wg-slider__numeric">
        {{dSlide[0].number}} / {{dSlide.length}}
      </div>
    </div>
    <div ref="container"
      class="wg-slider__container">
      <div ref="frame"
        @click="isZoom(val.number)"
        class="wg-slider__frame"
        v-for="(val, key) in dSlide"
        :key="key"
        v-if="key<3">

        <img class="wg-slider__fon"
          :src="val.src"
          alt="">
        <img ref="photo"
          class="wg-slider__img"
          :class="val.style"
          :src="val.src"
          alt="">
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      buttonsShow: false,
      marginButtons: {},
      dSlide: JSON.parse(JSON.stringify(this.slide)),
      dInsertNumber: 0,
      dSelect: this.select,
      noOpacity: true
    };
  },

  methods: {
    //чистит dSlide
    clearDSlide() {
       for (let key in this.dSlide) {
        this.dSlide[key].style = undefined;
      }
    },
    //выравнивает кнопки по центру
    centerButtons() {
      if (this.$refs.container.clientHeight > 66) {
        this.marginButtons = {
          marginTop: this.$refs.container.clientHeight / 2 + "px"
        };
      } else {
        this.marginButtons = {};
      }
    },
    //устанавливает главную фотку в свою позицию
    setPosition() {
      for (let key in this.dSlide) {
        if (this.dSlide[key].number == this.dSelect && key != 0) {
          let elem = this.dSlide.splice(key, this.dSlide.length - key);
          this.dSlide = elem.concat(this.dSlide);
          break;
        }
      }
    },
    //номерует фотки
    setNumbers() {
      for (let key in this.dSlide) {
        this.dSlide[key].number = Number(key) + 1;
      }
    },
    // определяет номер выбранной фотки
    isSelect() {
      this.$emit("onSelect", this.dSlide[1].number);
    },
    //вызывает событие увеличения фотографий на весь экран
    isZoom(number) {
      let n = number != 1 ? number - 1 : this.dSlide.length;
      this.$emit("onZoom", n);
      this.setStyleImg();
      for(let k in this.dSlide){
        }
    },
    //листает слайдер влево
    leafLeft() {
      if (this.animate != "none") {
        let frameWidtch = this.$refs.frame[0].clientWidth + "px";
        this.$refs.container.style.cssText =
          "transform: translateX(-" +
          frameWidtch +
          "); transition: transform 0.5s;";
        // "margin-left: -200%;  transition: margin-left 0.4s;";
        setTimeout(() => {
          this.$refs.container.style.cssText = "";
          this.dSlide.push(this.dSlide.shift());
          this.noOpacity = true;
        }, 600);
      } else {
        this.$refs.container.style.cssText = "";
        this.dSlide.push(this.dSlide.shift());
        this.noOpacity = true;
      }
    },
    leafRight() {
      if (this.animate != "none") {
        let frameWidtch = this.$refs.frame[0].clientWidth + "px";
        this.$refs.container.style.cssText =
          "transform: translateX(" +
          frameWidtch +
          "); transition: transform 0.5s;";
        // "margin-left: 0%;  transition: margin-left 0.4s;";
        setTimeout(() => {
          this.$refs.container.style.cssText = "";
          this.dSlide.unshift(this.dSlide.pop());
          this.noOpacity = true;
        }, 600);
      } else {
        this.$refs.container.style.cssText = "";
        this.dSlide.unshift(this.dSlide.pop());
        this.noOpacity = true;
      }
    },
    //lобавляет клас к dSlide
    setClassImg(src, style) {
      for (let key in this.dSlide) {
        if (src.indexOf(this.dSlide[key].src) !== -1) {
          this.dSlide[key].style = style;
        }
      }
    },
    searchClass(src) {
      for (let key in this.dSlide) {
        if (
          src.indexOf(this.dSlide[key].src) != -1 &&
          this.dSlide[key].style === undefined
        ) {
          return true;
          break;
        }
      }
      return false;
    },
    // Устанавливает стиль для фотографий
    setStyleImg() {
      for (let k in this.$refs.photo) {
        if (this.searchClass(this.$refs.photo[k].src)==true) {
          this.$refs.photo[k].onload = function(event) {
            let photo = event.target;
            let container = this.$refs.frame[0];
            let locContainer = container.clientHeight / container.clientWidth;
            let locPhoto = photo.naturalHeight / photo.naturalWidth;
            if (locPhoto < locContainer) {
              this.setClassImg(photo.src, "wg-slider__img_horizon");
              photo.className = "wg-slider__img wg-slider__img_horizon";
            } else {
              this.setClassImg(photo.src, "wg-slider__img_vertical");
              photo.className = "wg-slider__img wg-slider__img_vertical";
            }
          }.bind(this);
        }
      }
    }
  },

  beforeMount() {
    this.clearDSlide();
    this.setNumbers();
    this.setPosition();
  },
  mounted() {

    this.$el.style.transition = "opacity 0.6s";
    this.$el.style.opacity = 0;
    setTimeout(() => {
      this.$el.style.transition = "opacity 0.6s";
      this.$el.style.opacity = 1;
    }, 600);
    this.setStyleImg();

    setTimeout(() => {
      this.centerButtons();
    }, 100);
    this.isSelect();
  },
  updated() {
    this.setStyleImg();
    this.isSelect();
  },
  props: {
    slide: { type: Array, default: () => [] },
    select: {
      type: Number,
      default: 1
    },
    animate: {
      type: String,
      default: undefined
    }
  },
  watch: {
    select(newQ) {
      this.dSelect = JSON.parse(JSON.stringify(newQ));
      for (let key in this.dSlide) {
        if (this.dSlide[key].number == this.dSelect && key >= 1) {
          let elem = this.dSlide.splice(key - 1, this.dSlide.length - key + 1);
          this.dSlide = elem.concat(this.dSlide);
          break;
        }
        if (this.dSlide[key].number == this.dSelect && key == 0) {
          this.dSlide.unshift(this.dSlide.pop());
          break;
        }
      }
      if (this.noOpacity == false && this.animate != "none") {
        this.$refs.container.style.cssText = "opacity: 0;";
        setTimeout(() => {
          this.$refs.container.style.cssText =
            "opacity: 1;  transition: opacity 0.5s;";
        }, 100);
      }
      this.noOpacity = false;
    }
  }
};
// dSlide: [
//         { src: "/static/img/photo_car1.jpg", show: true },
//         { src: "/static/img/photo_car2.jpg" },
//         { src: "/static/img/photo_car3.jpg" },
//         { src: "/static/img/photo_car4.jpg" }
//       ]
</script>
<style lang="scss">
</style>