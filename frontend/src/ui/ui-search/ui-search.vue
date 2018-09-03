<template>
<div>
  <div class="ui-search" @click="($refs.input.focus(), isCaption=false)">
    <span class="ui-search__icon">
      <i class="fa fa-search" aria-hidden="true"></i>
    </span>
    <span v-if="isCaption" class="ui-search__caption">
      <slot name="caption">
        Поиск ...
      </slot>
    </span>
    <input  ref="input"
            class="ui-search__input"
            type="text"
            value=""
            v-model="input" @click="isCaption=false"
            @blur="isBlure($event)">
  </div>
  <ui-menu ref="list" v-if="input">
    <slot name="list">
      <ui-list>
        <li class="ui-list__item">Не найдено...</li>
      </ui-list>
    </slot>
  </ui-menu>
</div>

</template>
<script>
export default {
  name: "uiSearch",
  data() {
    return {
      isCaption: true,
      input: ""
    };
  },
  watch: {
    input(newQ, oldQ) {
      this.$emit("serchInput", [newQ]);
    }
  },
  methods: {
    isBlure() {
      this.isCaption = this.$refs.input.value == "" ? true : false;
    }
  },
  mounted() {
    window.addEventListener(
      "click",
      function(event) {
        let ev = event.target;
        let evFl = false;
        while (ev) {
          if (this.$refs.list!=undefined) {
            if (ev == this.$refs.list.$el) {
              evFl = true;
              break;
            }
          }
          if (ev == undefined) {
            break;
          }
          ev = ev.parentNode;
        }
        if (!evFl) {
          this.input = "";
          isCaption: false;
        }
      }.bind(this),
      true
    );
  }
};
</script>
