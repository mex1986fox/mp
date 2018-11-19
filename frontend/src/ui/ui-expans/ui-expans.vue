<template>
  <div v-show="show" class="ui-expans" @mouseover="show=false" @onTouchTab="show=false">
    <div>{{device}}</div>
    <br>
    <div>{{"W: "+ width}}</div>
    <div>{{"H: "+ height}}</div>
  </div>
</template>
<script>
export default {
  name: "ui-expans",
  data() {
    return {
      width: window.document.body.clientWidth,
      height: window.document.body.clientHeight,
      show: true
    };
  },
  computed: {
    device() {
      if (this.width > 1190) {
        return "Компьютер";
      }
      if (this.width < 1190 && this.width > 990) {
        return "Ноутбук";
      }
      if (this.width < 990 && this.width > 770) {
        return "Планшет";
      }
      if (this.width < 770) {
        return "телефон";
      }
    }
  },
  watch: {
    show(newQ) {
      if (newQ == false) {
        setTimeout(() => {
          this.show = true;
        }, 5000);
      }
    }
  },
  mounted() {
    window.document.body.onresize = () => {
      this.width = window.document.body.clientWidth;
      this.height = window.document.body.clientHeight;
    };
  }
};
</script>
<style lang="scss" scoped>
.ui-expans {
  position: fixed;
  height: 100px;
  width: 100px;
  background-color: #000000b3;
  z-index: 1000;
  text-align: center;
  color: #fff;
}
</style>
