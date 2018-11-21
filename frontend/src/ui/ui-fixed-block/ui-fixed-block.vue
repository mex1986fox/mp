<template>
  <div ref="block" class="ui-fixed-block">
    <slot></slot>
  </div>
</template>
<script>
export default {
  data() {
    return {
      heightWindow: undefined, //высота окна
      heightBlock: undefined, //высота блока
      widthBlock: undefined,
      scrollTopBody: undefined, //проскроленный верхний отступ body
      scrollTopBlock: undefined, //проскроленный верхний отступ блока
      fixedBlock: "nofixed" //фиксация блока bottom, top, nofixed
    };
  },
  props: {
    paddingBottom: {
      type: Number,
      default: 10
    },
    paddingTop: {
      type: Number,
      default: 72
    }
  },
  mounted() {
    this.scrollTopBody = window.pageYOffset
      ? window.pageYOffset
      : document.documentElement.scrollTop
        ? document.documentElement.scrollTop
        : document.body.scrollTop;
    let block = this.$refs.block;
    this.scrollTopBlock =
      block.getBoundingClientRect().top < 0
        ? block.getBoundingClientRect().top * -1
        : 0;
    this.heightWindow = window.document.body.clientHeight;
    this.heightBlock = this.$refs.block.clientHeight;
    this.widthBlock = this.$refs.block.clientWidth;
    document.addEventListener(
      "scroll",
      () => {
        this.scrollTopBody = window.pageYOffset
          ? window.pageYOffset
          : document.documentElement.scrollTop
            ? document.documentElement.scrollTop
            : document.body.scrollTop;
        this.scrollTopBlock =
          block.getBoundingClientRect().top < 0
            ? block.getBoundingClientRect().top * -1
            : 0;
        this.heightBlock = this.$refs.block.clientHeight;
      },
      true
    );
    window.addEventListener(
      "resize",
      () => {
        this.heightWindow = window.document.body.clientHeight;
        this.heightBlock = this.$refs.block.clientHeight;
        this.widthBlock = this.$refs.block.clientWidth;
      },
      true
    );
  },
  watch: {
    scrollTopBody(newQ, oldQ) {
      if (newQ > oldQ) {
        // прокрутка вниз
        this.scrollingToDown();
      } else {
        // прокрутка вверх
        this.scrollingToUp();
      }
    },
    fixedBlock(newQ, oldQ) {
      if (newQ == "bottom") {
        this.fixedBottom();
      }
      if (newQ == "top") {
        this.fixedTop();
      }
    }
  },
  methods: {
    //выполняется при прокрутке вниз
    scrollingToDown() {
      //если блок шире окна
      //закрепить вверху
      if (this.heightWindow >= this.heightBlock) {
        this.fixedBlock = "top";
      } else {
        //если блок зафиксирован вверху
        if (this.fixedBlock == "top") {
          // расфиксировать
          this.fixedBlock = "nofixed";
          this.fixedTopInNoFixed();
        }
        //если блок не зафиксирован
        if (this.fixedBlock == "nofixed") {
          //проверить на сколько он проскроленн вверх
          if (this.scrollTopBlock > this.heightBlock - this.heightWindow) {
            this.fixedBlock = "bottom";
          }
        }
      }
    },
    //выполняется при прокрутке вверх
    scrollingToUp() {
      //если блок шире окна
      //закрепить вверху
      if (this.heightWindow >= this.heightBlock) {
        this.fixedBlock = "top";
      } else {
        //если блок зафиксирован вверху
        if (this.fixedBlock == "bottom") {
          // расфиксировать
          this.fixedBlock = "nofixed";
          this.fixedBottomInNoFixed();
        }
        // если блок незафиксирован
        if (this.fixedBlock == "nofixed") {
          // проверить на сколько он проскроленн вверх
          if (this.scrollTopBlock <= 0) {
            this.fixedBlock = "top";
          }
        }
      }
    },

    fixedTop() {
      this.$refs.block.style.cssText =
        "top: " +
        this.paddingTop +
        "px; bottom: auto; position: fixed; width: " +
        this.widthBlock +
        "px;";
    },
    fixedBottom() {
      this.$refs.block.style.cssText =
        "top: auto; bottom: " +
        this.paddingBottom +
        "px; position: fixed; width: " +
        this.widthBlock +
        "px;";
    },

    fixedBottomInNoFixed() {
      let margin =
        this.scrollTopBody -
        (this.heightBlock + this.paddingTop - this.heightWindow)+40;
      this.$refs.block.style.cssText =
        "margin-top: " + margin + "px; position: relative; width: auto;";
    },
    fixedTopInNoFixed() {
      let margin = this.scrollTopBody;
      this.$refs.block.style.cssText =
        "margin-top: " + margin + "px; position: relative;width: auto;";
    }
  }
};
</script>



