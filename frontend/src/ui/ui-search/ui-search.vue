<template>
  <div class="ui-search" @click="isClick">
    <input
      :placeholder="placeholder"
      ref="input"
      type="text"
      class="ui-search__input"
      :value="dValue"
      @blur="isBlur"
      @input="isInput"
    >
    <div v-if="!dActive && !dShowMenu" class="ui-search__icon">
      <i class="fa fa-search" aria-hidden="true"></i>
    </div>
    <div
      v-if="dActive || dShowMenu"
      @click="isClean"
      class="ui-search__icon ui-search__icon_active"
    >
      <i aria-hidden="true" class="fa fa-times"></i>
    </div>
    <div ref="menu" v-show="dShowMenu" class="ui-search__menu">
      <slot></slot>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      dActive: false,
      dValue: "",
      dShowMenu: this.showMenu
    };
  },
  props: {
    showMenu: {
      type: Boolean,
      default: false
    },
    placeholder: {
      type: String,
      default: ""
    }
  },
  watch: {
    showMenu(newQ) {
      this.dShowMenu = newQ;
      this.$refs.menu.addEventListener("click", event => {
        event.stopPropagation();
      });
    }
  },
  mounted() {
    document.addEventListener("click", event => {
      this.isClean();
    });
  },
  methods: {
    isClean() {
      this.dActive = false;
      if (this.$refs.input != undefined) {
        this.$refs.input.value = "";
      }
      this.dValue = "";
      this.$emit("onInput", this.dValue);
    },
    isClick() {
      this.dActive = true;
      this.$refs.input.focus();
    },
    isBlur() {
      if (this.dValue == "") {
        this.dActive = false;
      }
    },
    isInput() {
      this.dValue = this.$refs.input.value;
      this.$emit("onInput", this.dValue);
    }
  }
};
</script>

