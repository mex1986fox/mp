<template>
	<layout>
		<div class="container">
			<div class="row">
				<div class="col_6 col_offset-3 col-phone_6 col-phone_offset-0">
					<div class="row">
						<div class="col-12">
							<div v-for="(val, key) in ads"
							     :key="key"
							     class="wg-content-frame">
								<wg-card-ad :object="val">
								</wg-card-ad>
							</div>
						</div>
					</div>
				</div>
				<div class="col_12">

					<ui-blind :show="showFormAdd"
					          @onHide="showFormAdd=false"
					          animate="top"
					          style="background-color: rgba(255, 255, 255, 0);">
						<div class="container">
							<div class="row">
								<div class="col_6 col_offset-3 col-tablet_8 col-tablet_offset-2 col-phone_6 col-phone_offset-0">
									<wg-form-add @onHide="
								     showFormAdd=false
								     ">

									</wg-form-add>
								</div>
							</div>
						</div>
					</ui-blind>
				</div>
			</div>
		</div>
		<div v-if="!showFormAdd"
		     @click="showFormAdd=true"
		     class="ui-button ui-button_circle ui-button_red pg-ads__button-show-form-add">
			<i class="fa fa-plus"
			   aria-hidden="true"></i>
		</div>
	</layout>
</template>

<script>
export default {
  name: "pg-ads",
  data() {
    return {
      showFormAdd: false,
      ads: undefined
    };
  },
  methods: {
    show(event) {
      this.$http.post("/api/show/ads").then(
        response => {
          this.ads = response.body.ads;
        },
        error => {}
      );
    }
  },
  mounted() {
    this.show();
  }
};
</script>

<style lang="scss">
@import "./ads.scss";
</style>
