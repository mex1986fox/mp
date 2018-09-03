<template>
<transition name="ui-tabs__tab_active">
    <div class="ui-tabs__tab" :class="{'ui-tabs__tab_active':dChecked}" @click="isClick">
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
      dDisabled: false,
      dId: this.id
    };
  },
  props: {
    checked: {
      type: Boolean,
      default: false
    },
    id:{
        type: [String, Number],
        default: ""
    }
  },
  methods: {
    isClick() {
      if (this.dDisabled == false) {
        let checked = this.dChecked;
        let brath = this.$parent.$children;
        for (let br in brath) {
          if (brath[br].dName == this.dName) 
          {
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
        