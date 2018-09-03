<template>
	<div class="wg-captcha">
		<div class="wg-captcha__img">
			<img :src="dSrc">
		</div>

		<div @click="refresh"
		     class="ui-button ui-button_circle ui-button_circle_mini">
			<i class="fa fa-refresh"
			   aria-hidden="true"></i>
		</div>
	</div>
</template>
<script>
export default {
  name: "wg-captcha",
  data() {
    return {
      dSrc: "/api/show/captcha?" + Math.random()
    };
  },
  methods: {
    refresh() {
      this.dSrc = "/api/show/captcha?" + Math.random();
    }
  },
  mounted() {
    this.$on("onRefresh", function() {
      this.refresh();
    });
  }
};
</script>
