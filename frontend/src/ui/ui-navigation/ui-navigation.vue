<template>
  <div>
    <ui-blind :show="show" @onHide="isHide">
      <div ref="navigation" class="ui-navigation">
        <slot>

        </slot>
      </div>
    </ui-blind>
  </div>
</template>
<script>
export default {
  name: "UiNavigation",
  data() {
    return { dShow: this.show };
  },
  props: {
    show: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    isHide() {
      this.dShow = false;
      this.$emit("onHide");
    }
  },
  updated() {
    let wHeight = document.documentElement.clientHeight;
    if (this.$refs.navigation) {
      this.$refs.navigation.style.minHeight = wHeight + "px";
    }
  },
  watch: {
    show(newQ) {
      this.dShow = newQ;
    }
  }
};
</script>
