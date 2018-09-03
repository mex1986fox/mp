<template>
	<div class="wg-comment__comment">
		<div class="ui-avatar wg-comment__avatar">
			<img src="/public/img/canvas2.jpg"
			     alt="">
		</div>
		<div class="wg-comment__description">
			<div class="wg-comment__login">
				<a class="ui-link"
				   href="">Heruvim Neili</a>

			</div>
			<div class="wg-comment__date">
				21-12-2018
			</div>
			<div class="ui-description ui-description_mini">
				Просто по личному опыту, почти все встречавшиеся мне в жизни бизнесмены, даже весьма успешные среди них, были людьми довольно спокойными и рассудительными, даже скучноватыми, примерно как парень на интервью в видео. А на инфотренингах все выглядят так, будто их оса
			</div>
			<div class="wg-comment__buttons">
				<button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
					<i aria-hidden="true"
					   class="fa fa-thumbs-o-up"></i>
				</button>
				<div class="ui-counter">
					123 369
				</div>
				<button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
					<i aria-hidden="true"
					   class="fa fa-thumbs-o-down"></i>
				</button>
				<div class="ui-counter">
					123 369
				</div>
				<button @click="showAnswers=!showAnswers"
				        class="ui-button ui-button_circle ui-button_flat ui-button_circle_mini">
					<i aria-hidden="true"
					   class="fa fa-angle-down"></i>
				</button>
				<div class="ui-counter">
					Ответы: 25
				</div>
			</div>

			<wg-answers v-if="showAnswers">

			</wg-answers>
		</div>
	</div>
</template>
<script>
export default {
  name: "wg-comment",
  data() {
    return {
      showAnswers: false
    };
  }
};
</script>
