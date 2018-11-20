<template>
  <div ref="scroll" class="ui-fixed-block">
    <div ref="block" class="ui-fixed-block__scroll">
      <slot></slot>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      scrollTop: 0,
      faultTop: 0,
      scrolling: undefined, //up, down
      fixed: undefined, //top, , bottom, undefined
      margin: 0
    };
  },
  mounted() {
    console.log(this.$refs.block);
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
      if (newQ > oldQ) {
        this.scrolling = "up";
      } else {
        this.scrolling = "down";
      }
    },
    scrolling(newQ, oldQ) {
      this.scrolling = undefined;
      // ширина скролинга
      let scrollHeight = window.document.body.scrollHeight;
      // ширина видимого экрана
      let windowHeight = window.document.body.clientHeight;
      // ширина блока
      let blockHeight = this.$refs.block.scrollHeight;
      //определить короче блок видимой части или нет
      if (windowHeight > blockHeight) {
        this.fixed = "top";
        console.log("зафиксирован на верху");
        return;
      }
      // крутили вверх
      if (newQ == "up") {
        console.log("вверх");
        //открепляем если в верхнем положении
        if (this.fixed == "top") {
          this.fixed = undefined;
          console.log("откреплена верхняя фиксация");
          return;
        }
        //определяем положение незафиксированного блока
        // console.log(
        //   this.scrollTop+" >= "+(blockHeight - windowHeight+170)
        // );
        if (this.scrollTop >= blockHeight - windowHeight) {
          this.fixed = "bottom";
          console.log("зафиксирован внизу");
          return;
        }
      }
      if (newQ == "down") {
        console.log("вниз");

        //открепляем если в верхнем положении
        if (this.fixed == "bottom") {
          this.fixed = undefined;
          this.margin= this.scrollTop-this.$refs.block.scrollHeight;
          console.log("откреплена нижняя фиксация");
          return;
        }
        //определяем положение незафиксированного блока
        // if (this.scrollTop >= blockHeight - windowHeight + 110) {
        //   this.fixed = "bottom";
        //   console.log("зафиксирован внизу");
        //   return;
        // }
      }
    },
    fixed(newQ) {
      if (newQ == "bottom") {
        this.$refs.block.style.cssText = "top: auto; bottom: 20px; position: fixed;";
      }
      if (newQ == undefined) {
        this.$refs.block.style.cssText =
          "margin-top: " + this.margin + "px; position: relative;";
      }
      if (newQ == "top") {
        this.$refs.block.style.cssText = "top: 20px; position: fixed;";
      }
    }
  }
};
</script>
<style lang="scss">
.ui-fixed-block {
  background: #4faa93;
  height: 100%;
  &__scroll {
    background: #af1414;
    top: 0;
  }
}
</style>

