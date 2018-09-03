<template>
<transition  name="ui-snackbar">
  <div class="ui-snackbar">
    <button
      class="ui-button ui-button_circle ui-button_mini ui-snackbar__button-close"
      @click="hide()">
      <i class="fa fa-angle-down"></i>

    </button>
    <slot>

    </slot>
  </div>
</transition>
</template>
<script>
export default {
  props: {
    show: Boolean,
    time: Number
  },
  data() {
    return {
      timeSnack: this.time ? this.time : 0,
      setTime: undefined
    };
  },
  watch: {
    show() {
      this.showSnack = this.show;
      if (this.showSnack == true) {
        if (this.timeSnack > 0) {
          this.setTime=setTimeout(() => {
            this.hide();
          }, this.timeSnack);
        }
      }
    },
    time() {
      this.timeSnack = this.time;
    }
  },
  methods: {
    hide() {
      clearTimeout(this.setTime);
      this.showSnack = false;
      this.$emit("onHide");
    }
  }
};
</script>
