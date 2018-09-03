<template>
    <div class="ui-select__menu-list ui-list__item ui-list__caption" @click="setSelect()">
      <slot></slot>
    </div>
</template>
<script>
export default {
  data() {
    return {
      dValue: this.value,
      dSelected: this.selected
    };
  },
  props: {
    value: {
      type: [String, Number],
      default: ""
    },
    selected: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    setSelect() {
      this.dSelected = !this.dSelected;
      // задать событие в родителя
      this.$parent.$parent.$emit("onSetSelect", {
        value: this.dValue,
        text: this.$slots.default[0].elm.data
      });
    }
  }
};
</script>
