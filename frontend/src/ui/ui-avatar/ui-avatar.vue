<template>
    <div class="ui-avatar">
        <span v-if="simbol"
              class="ui-avatar__simbol">
            {{simbol}}
        </span>
        <slot>

        </slot>
    </div>
</template>
<script>
export default {
  name: "UiAvatar",
  data() {
    return {};
  },
  props: {
    lable: {
      type: String,
      default: ""
    }
  },
  computed: {
    simbol() {
      return this.lable[0];
    }
  }
};
</script>
