<template>
    <div @click="onClick" class="ui-click-feedback">
        <div ref="after" class="ui-click-feedback__after"></div>
    </div>
</template>
<script>
export default {
  methods: {
    onClick() {
      let after = this.$refs.after;
      after.style
    }
  }
};
</script>
