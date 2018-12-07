<template>
  <div class="wg-slider-navig">
    <div ref="container" class="wg-slider-navig__container">
      <div
        ref="slide"
        @click="isClick(val.number)"
        class="wg-slider-navig__slide"
        :style="{'width':dWidthSlide}"
        :class="{'wg-slider-navig__slide_active':val.number==select}"
        v-for="(val, key) in dSlide"
        :key="key"
      >
        <img class="wg-slider__fon" :src="val.src">
        <img ref="photo" class="wg-slider__img" :src="val.src">
      </div>
    </div>
  </div>
</template>
    <script>
export default {
  name: "wg-slider-navig",
  data() {
    return {
      dSlide: this.slides,
      dWidthSlide: "0px",
      dMarginSlide: "0px"
    };
  },
  props: {
    slides: {
      type: Array,
      default: () => []
    },
    select: {
      type: Number,
      default: 1
    }
  },
  watch: {
    slides(newQ) {
      this.dSlide = newQ;
      this.setNumbers();
    }
  },
  beforeMount() {
    this.setNumbers();
  },
  mounted() {
    this.computedWidth();
    this.computedMLeft();
    this.setStyleImg();
  },
  updated() {
    this.computedMLeft();
    this.setStyleImg();
  },
  methods: {
    //   вычисляет ширину слайдов
    computedWidth() {
      this.dWidthSlide = (this.$refs.container.clientHeight * 16) / 9 + "px";
    }, // устанавливает отступ первого слайда
    computedMLeft() {
      // ширина контейнера
      let wContainer = this.$refs.container.clientWidth; // ширина слайда
      let wSlide = (this.$refs.container.clientHeight * 16) / 9; // количество слайдов помещающихся в контейнер
      let lengthSlids = Math.floor(wContainer / (wSlide + 2)); // центральный слайд
      let centerSlide = Math.floor(lengthSlids / 2);
      if (centerSlide < this.getPosition(this.select)) {
        this.dMarginSlide =
          this.getPosition(this.select) * (wSlide + 2) -
          centerSlide * (wSlide + 2) +
          "px";
      }
      if (this.getPosition(this.select) < centerSlide) {
        this.dMarginSlide = "0px";
      }
      if (
        this.dSlide.length - this.getPosition(this.select) <=
        lengthSlids - centerSlide
      ) {
        this.dMarginSlide =
          (this.dSlide.length - lengthSlids) * (wSlide + 2) + "px";
      }

      if (this.$refs.slide) {
        this.$refs.slide[0].style.marginLeft = "-" + this.dMarginSlide;
        this.$refs.container.style.marginLeft =
          (this.$refs.container.clientWidth - (wSlide + 2) * lengthSlids) / 2 +
          "px";
      }
    },

    getPosition(number) {
      for (let k in this.dSlide) {
        if (this.dSlide[k].number == number) {
          return k;
          break;
        }
      }
    },
    setNumbers() {
      for (let key in this.dSlide) {
        this.dSlide[key].number = Number(key);
      }
    },
    isClick(number) {
      this.$emit("onSelect", number);
    },
    // Устанавливает стиль для фотографий
    setStyleImg() {
      let interval = [];
      for (let k in this.$refs.photo) {
        this.$refs.photo[k].onload = function(event) {
          let photo = event.target;
          let locPhoto = photo.naturalHeight - photo.naturalWidth;
          if (locPhoto < 0) {
            photo.className = "wg-slider-navig__img_horizon";
          } else {
            photo.className = "wg-slider-navig__img_vertical";
          }
        };
      }
    }
  }
};
// dSlide: [
//         { src: "/static/img/photo_car1.jpg"},
//         { src: "/static/img/photo_car2.jpg" },
//         { src: "/static/img/photo_car3.jpg" },
//         { src: "/static/img/photo_car4.jpg" }
//       ]
</script>