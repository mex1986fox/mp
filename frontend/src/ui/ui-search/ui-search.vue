<template>
  <div class="ui-search" @click="isClick">
    <input ref="input" type="text" class="ui-search__input" @blur="isBlur" @input="isInput"/>
    <div class="ui-search__icon" :class="{'ui-search__icon_active': dActive}">
      <i class="fa fa-search" aria-hidden="true"></i>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      dActive: false,
      dValue: ""
    };
  },
  methods: {
    isClick() {
      this.dActive = true;
      this.$refs.input.focus()
    },
    isBlur(){
      this.dActive = false;
    },
    isInput(){
      this.dValue=this.$refs.input.value;
      this.$emit("onInput", this.dValue);
    }
  }
};
</script>

