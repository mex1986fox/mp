<template>
	<transition name="ui-snackbar">
		<div v-if="dShow"
		     class="ui-snackbar">
			<button class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini ui-snackbar__button-close"
			        @click="hide()">
				<i class="fa fa-angle-down"></i>

			</button>
			<div class="ui-description ui-snackbar__descripton">
				<slot>

				</slot>
			</div>
		</div>
	</transition>
</template>
<script>
export default {
  data() {
    return {
      timer: undefined
    };
  },
  props: {
    show: {
      type: Boolean,
      default: false
    },
    time: {
      type: Number,
      default: undefined
    }
  },
  data() {
    return {
      dShow: this.show
    };
  },
  watch: {
    show(newQ) {
      this.dShow = newQ;
      this.setTimer();
    }
  },
  mounted() {
    this.setTimer();
  },
  methods: {
    hide() {
      this.dShow = false;
      this.$emit("onHide");
      clearTimeout(this.timer);
    },
    setTimer() {
      if (this.dShow == true && this.time != undefined) {
        this.timer = setTimeout(() => {
          this.hide();
        }, this.time);
      }
    }
  }
};
</script>
