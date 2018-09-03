<template>
	<layout>
		<div class="container">
			<div class="row">
				<div class="col_12">
					<ui-blind :show="showFormAdd"
					          @onHide="showFormAdd=false"
					          animate="top"
					          style="background-color: rgba(255, 255, 255, 0);">
						<div class="container">
							<div class="row">
								<div class="col_6 col_offset-6 col-tablet_8 col-tablet_offset-4 col-phone_6 col-phone_offset-0">
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
	</layout>
</template>

<script>
export default {
  name: "pg-ads",
  data() {
    return {
      showFormAdd: true
    };
  }
};
</script>

<style lang="scss">
@import "./ads.scss";
</style>
