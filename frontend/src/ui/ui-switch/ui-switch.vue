<template>
  <div class="ui-switch" v-on:click="isClick()">
      <input class="ui-switch__checkbox" type="checkbox" :disabled="dDisabled" :value="dValue" :name="dName" :checked="dChecked">
      <div class="ui-switch__track"
            :class="{ 'ui-switch__track_active': dChecked,
                      'ui-switch__track_disabled': dDisabled }"></div>
      <div class="ui-switch__thumb"
            :class="{ 'ui-switch__thumb_active': dChecked,
                      'ui-switch__thumb_disabled': dDisabled }"></div>
      <span  class="ui-switch__caption" 
        :class="{'ui-switch__caption_disabled': dDisabled}">
        <slot></slot>
      </span>               
  </div>
</template>
<script>
export default {
  name: "uiSwitch",
  data() {
    return {
      dChecked: this.checked,
      dName: this.name,
      dValue: this.value,
      dDisabled: this.disabled
    };
  },
  props: {
    name:{
      type: String,
      default: ""
    },
    value:{
      type: String,
      default: ""
    },
    checked:{
      type: Boolean,
      default: false
    },
    disabled:{
      type: Boolean,
      default: false
    } 
  },
 methods: {
    isClick() {
      if(this.dDisabled==false){
        this.dChecked = !this.dChecked;
        this.$emit("onClick", this.dChecked);
      }
    }
  }
};
</script>
