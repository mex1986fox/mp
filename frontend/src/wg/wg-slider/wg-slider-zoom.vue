<template>
	<ui-blind ref="blind"
	          class="wg-slider-zoom__blind"
	          :show="dShow"
	          @onHide="dShow=false">
		<div class="container">
			<div class="row">
				<div class="col_12">
					<button @click="dShow=false"
					        class="ui-button ui-button_circle ui-button_flat wg-slider-zoom__button-exit">
						<i class="fa fa-times"
						   aria-hidden="true"></i>
					</button>
					<div class="wg-slider-zoom" v-if="dShow">
						<wg-slider ref="slider"
						           class="wg-slider-zoom__slider"
						           :slide="dSlide"
						           :select="numberPhoto"
						           @onSelect="isSelectPhoto"
                       animate="none">
						</wg-slider>
						<wg-slider-navig class="wg-slider-zoom__slider-navig"
						                 :slide="dSlideNav"
						                 :select="numberPhoto"
						                 @onSelect="isSelectPhoto">
						</wg-slider-navig>
					</div>
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
      numberPhoto: this.select,
      dSlide: JSON.parse(JSON.stringify(this.slide)),
      dSlideNav: JSON.parse(JSON.stringify(this.slideNavigation)),
      dShow: this.show
    };
  },
  mounted(){
    this.numberPhoto=this.select;
    
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
    slide(newQ) {
      this.dSlide = JSON.parse(JSON.stringify(newQ));
    },
    slideNavigation(newQ) {
      this.dSlideNav = JSON.parse(JSON.stringify(newQ));
    }
  },
  props: {
    slide: {
      type: Array,
      default: () => []
    },
    slideNavigation: {
      type: Array,
      default: () => []
    },
    select: {
      type: Number,
      default: 1
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
