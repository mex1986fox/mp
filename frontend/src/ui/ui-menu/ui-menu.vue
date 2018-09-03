<template>
  <ui-blind :show="dShow" @onHide="isHide" class="ui-blind_flat" animate="opacity">
    <div ref="menu" class="ui-menu">
      <slot>

      </slot>
    </div>
  </ui-blind>

</template>
<script>
export default {
  data() {
    return {
      dShow: this.show,
      dX: 0,
      dY: 0,
      dPosition: this.position
    };
  },
  methods: {
    isHide() {
      document.body.style.overflow = "auto";
      this.dShow = false;
      this.enableScrolling();
      this.$emit("onHide");
    },
    disableScrolling() {
      var x = window.scrollX;
      var y = window.scrollY;
      window.onscroll = () => {
        window.scrollTo(x, y);
      };
    },
    enableScrolling() {
      window.onscroll = function() {};
    }
  },
  props: {
    show: {
      type: Boolean,
      default: false
    },
    position: {
      type: String,
      default: "left-bottom"
    }
  },
  watch: {
    show(newQ) {
      this.dShow = newQ;
    }
  },
  mounted() {
    window.addEventListener("click", event => {
      this.dX = event.clientX;
      this.dY = event.clientY;
    });
  },
  updated() {
    if (this.dShow == true) {
       this.disableScrolling();
      let top, left;
      switch (this.dPosition) {
        case "left-bottom":
          top = this.dY;
          left = this.dX - this.$refs.menu.clientWidth;
          break;
        case "right-bottom":
          top = this.dY;
          left = this.dX;
          break;
        case "left-top":
          top = this.dY - this.$refs.menu.clientHeight;
          left = this.dX - this.$refs.menu.clientWidth;
          break;
        case "right-top":
          top = this.dY - this.$refs.menu.clientHeight;
          left = this.dX;
          break;
      }
      this.$refs.menu.style.top = top + "px";
      this.$refs.menu.style.left = left + "px";
    }
  }
};
</script>
