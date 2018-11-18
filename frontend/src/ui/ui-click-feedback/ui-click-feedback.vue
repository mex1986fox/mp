<template>
  <div @touchstart="onClick"
       class="ui-click-feedback">
    <div ref="after"
         class="ui-click-feedback__after"
         :class="{'ui-click-feedback__after_forwards':forward}"></div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      forward: false
    };
  },
  methods: {
    onClick(event) {
      let x = event.changedTouches[0].clientX - 25;
      let y = event.changedTouches[0].clientY - 25;
      this.$refs.after.style.cssText =
        "left: " + x + "px;" + "top: " + y + "px;";
      this.forward = true;
      setTimeout(() => {
        this.forward = false;
        this.$refs.after.style.cssText = "";
      }, 300);
    }
  }
};
</script>
