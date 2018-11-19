<template>
  <div ref="block"
       class="ui-fixed-block">
    <div ref="scroll"
         class="ui-fixed-block__scroll">
      <slot></slot>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      scrollTop: undefined,
      top: 0,
      topbuf: 0
    };
  },
  mounted() {
    window.document.body.onscroll = () => {
      this.scrollTop = window.pageYOffset
        ? window.pageYOffset
        : document.documentElement.scrollTop
          ? document.documentElement.scrollTop
          : document.body.scrollTop;
    };
  },
  watch: {
    scrollTop(newQ, oldQ) {
      let blockScrollHeight = window.document.body.scrollHeight - 170;
      let blockClientHeight = window.document.body.clientHeight;
      let scrollClientHeight = this.$refs.scroll.clientHeight;

      this.$refs.block.style.cssText = "height: " + blockScrollHeight + "px";
      if (newQ > oldQ) {
        this.topbuf = 0;
        this.top = "-" + (scrollClientHeight - blockClientHeight);
        this.$refs.scroll.style.cssText = "top: " + this.top + "px";
      } else {
        this.topbuf = this.topbuf + (oldQ - newQ);
        if (this.topbuf > 170) {
          this.topbuf = 170;
        }
      }
    }
  }
};
</script>
<style lang="scss">
.ui-fixed-block {
  background: #4faa93;
  &__scroll {
    background: #af1414;
    position: sticky;
    top: 0;
    height: auto;
  }
}
</style>

