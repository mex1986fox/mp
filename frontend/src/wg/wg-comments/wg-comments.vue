<template>
	<div class="wg-comments">
		<div class="wg-comments__form">
			<div class="ui-avatar wg-comments__form-avatar">
				<img src="/public/img/avatar.jpg"
				     alt="">
			</div>
			<div class="wg-comments__description">
				<ui-textarea value="dfdgd cxasdas"
				             caption="Ваш комментарий"
				             :autoresize="200">
				</ui-textarea>
				<button class="ui-button ui-button_blue ui-button_mini wg-comments__form-button">
					Ok
				</button>
				<button class="ui-button ui-button_mini wg-comments__form-button">
					Отмена
				</button>
			</div>
		</div>

		<wg-comment v-for="key in 20"
		            :key="key">
		</wg-comment>
	</div>
</template>
<script>
export default {
  name: "wg-comments",
  data() {
    return {};
  }
};
</script>
