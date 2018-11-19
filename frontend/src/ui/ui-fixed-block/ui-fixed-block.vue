<template>
    <div ref="fixedBlock" class="ui-fixed-block">
        <slot></slot>
    </div>
</template>
<script>
export default {
  mounted() {
    window.document.body.onscroll = () => {
      let heigth = this.$refs.fixedBlock.clientHeight;
      let bHeight = window.document.body.clientHeight;
      //   window.document.body.scrollHeight

      let scrollTop = window.pageYOffset
        ? window.pageYOffset
        : document.documentElement.scrollTop
          ? document.documentElement.scrollTop
          : document.body.scrollTop;
    //   console.log(scrollTop);
      let margin = scrollTop + 20;
      if (heigth < bHeight) {
          this.$refs.fixedBlock.style.cssText = "position:fixed;"
      }
 
    };
  }
};
</script>
