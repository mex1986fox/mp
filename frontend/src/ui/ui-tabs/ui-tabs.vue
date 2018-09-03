<template>
    <nav class="ui-tabs">
        <div ref="line" class="ui-tabs__line">
            <div class="ui-tabs__button ui-tabs__button_left" @click="clickLeft" v-if="dShowBut">
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </div>
            <div class="ui-tabs__button ui-tabs__button_right" @click="clickRight" v-if="dShowBut">
                <i class="fa fa-angle-right" aria-hidden="true"></i>
            </div>
            <slot></slot>
        </div>
    </nav>
</template>
<script>
export default {
  name: "ui-tabs",
  data() {
    return {
      nOffset: 0,
      dShowBut: false
    };
  },
  methods: {
    clickLeft() {
      let marg = 0;
      let child;
      let length = this.$children.length - 1;
      for (let k in this.$children) {
        child = this.$children[k];
        if (child.$options._componentTag == "ui-tabs-tab") {
          marg = child.$el.clientWidth;
          if (k == this.nOffset && length != k) {
            this.$children[k].$el.style.marginLeft = "-" + marg + "px";
            this.nOffset = this.nOffset + 1;
            break;
          }
        }
      }
    },
    clickRight() {
      let marg = 0;
      let child;
      for (let k in this.$children) {
        child = this.$children[k];
        if (child.$options._componentTag == "ui-tabs-tab") {
          marg = child.$el.clientWidth;
          if (k == this.nOffset - 1) {
            this.$children[k].$el.style.marginLeft = "";
            this.nOffset = this.nOffset - 1;
            break;
          }
        }
      }
    },
    showButtons() {
      let lineW = this.$el.clientWidth;
      let childW = 0;
      for (let child of this.$children) {
        if (child.$options._componentTag == "ui-tabs-tab") {
          childW = childW + child.$el.clientWidth;
        }
      }
      this.$refs.line.style.marginLeft = lineW < childW ? "60px" : "";
      this.dShowBut = lineW < childW ? true : false;
    }
  },
  watch: {
    dShowBut(newQ) {
      if (newQ == false) {
        for (let child of this.$children) {
          if (child.$options._componentTag == "ui-tabs-tab") {
            child.$el.style.marginLeft = "";
          }
        }
      }
    }
  },
  mounted() {
    this.showButtons();
    window.addEventListener("resize", () => {
      this.showButtons();
    });
  }
};
</script>
        