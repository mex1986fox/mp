<template>
  <transition
    name="ui-blind"
    :enter-class="enter+'_'+animate"
    :leave-class="leave+'_'+animate"
    :enter-active-class="enterAct+'_'+animate"
    :leave-active-class="leaveAct+'_'+animate"
    :enter-to-class="enterTo+'_'+animate"
    :leave-to-class="leaveTo+'_'+animate"
  >
    <div class="ui-blind" v-if="show" @click="isClick">
      <div ref="content" class="ui-blind__content" @click="isClick">
        <slot></slot>
      </div>
    </div>
  </transition>
</template>
<script>
export default {
  name: "UiBlind",
  data() {
    return {
      dScrollHeight: 0,
      enter: "ui-blind_enter",
      leave: "ui-blind_leave",
      enterAct: "ui-blind_enter-act",
      leaveAct: "ui-blind_leave-act",
      enterTo: "ui-blind_enter-to",
      leaveTo: "ui-blind_leave-to"
    };
  },
  props: {
    show: {
      type: Boolean,
      default: false
    },
    centering: {
      type: Boolean,
      default: false
    },
    selector: {
      type: String,
      default: ".ui-blind__content"
    },
    animate: {
      type: String,
      default: "left"
    }
  },

  methods: {
    isClick(event) {
      if (event.target == this.$el || event.target == this.$refs.content) {
        this.$emit("onHide");
      }
    },
    isCentering() {
      if (this.centering && this.show) {
        setTimeout(() => {
          let wHeight = document.documentElement.clientHeight;
          let el = this.$el.querySelectorAll(this.selector)[0];
          el.style.overflow = "hidden";
          let elHeight = el.offsetHeight;
          el.style.overflow = "visible";
          if (wHeight > elHeight) {
            el.style.cssText = "margin-top: " + (wHeight - elHeight) / 2 + "px";
          }
        }, 100);
      }
    }
  },
  mounted() {
    this.isCentering();
  },
  updated() {
    this.isCentering();
  },
  computed: {
    // autoMargin() {
    //   return this.centering != true ? { margin: this.dMargin + " 0" } : {};
    // }
  }
};
</script>
