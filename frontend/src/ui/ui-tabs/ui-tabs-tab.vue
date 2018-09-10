<template>
  <transition name="ui-tabs__tab_active">
    <div class="ui-tabs__tab" :class="{'ui-tabs__tab_active':dChecked, 'ui-tabs__tab_disabled':disabled}" @click="isClick">
      <slot>

      </slot>
    </div>
  </transition>
</template>
<script>
export default {
  name: "pg-tabs",
  data() {
    return {
      dChecked: this.checked,
      dId: this.id
    };
  },
  props: {
    checked: {
      type: Boolean,
      default: false
    },
    id: {
      type: [String, Number],
      default: ""
    },
    disabled: {
      stype: Boolean,
      default: false
    }
  },
  watch:{
    checked(newQ){
      this.dChecked=newQ;
    }
  },
  methods: {
    isClick() {
      if (this.disabled != true) {
        let checked = this.dChecked;
        let brath = this.$parent.$children;
        for (let br in brath) {
          if (brath[br].dName == this.dName) {
            brath[br].dChecked = false;
            this.$emit("onBlur", this.dId);
          }
        }
        this.dChecked = true;
        this.$emit("onFocus", this.dId);
      }
    }
  },
  mounted() {
    if (this.dChecked == true) {
      let brath = this.$parent.$children;
      for (let br in brath) {
        if (brath[br].dName == this.dName) brath[br].dChecked = false;
      }
      this.dChecked = true;
    }
  }
};
</script>
        