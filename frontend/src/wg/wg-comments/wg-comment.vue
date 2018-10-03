<template>
	<div class="wg-comment__comment">
		<div v-if="comment.user!=undefined">
			<ui-avatar class="wg-comment__avatar" :lable="comment.user.login">
				<img :src="comment.user.avatar" alt="">
			</ui-avatar>
		</div>
		<div class="wg-comment__description">
			<div class="wg-comment__login" v-if="comment.user!=undefined">
				<a class="ui-link" href="">{{comment.user.name+" "+comment.user.surname}}</a>
			</div>
			<div class="wg-comment__date">
				{{comment.date_create}}
			</div>
			<div class="ui-description ui-description_mini">
				{{comment.description}}
			</div>
			<div class="wg-comment__buttons">
				<button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
					<i aria-hidden="true" class="fa fa-thumbs-o-up"></i>
				</button>
				<div class="ui-counter">
					{{comment.likes}}
				</div>
				<button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
					<i aria-hidden="true" class="fa fa-thumbs-o-down"></i>
				</button>
				<div class="ui-counter">
					{{comment.dislikes}}
				</div>
				<button @click="showAnswers=!showAnswers" class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
					<i aria-hidden="true" class="fa fa-comments-o"></i>
				</button>
				<div class="ui-counter">
					25
				</div>
				<button @click="showForm=true" class="ui-button ui-button_mini ui-button_flat" style="margin-top: 10px;">
					Ответить
				</button>

			</div>
			<div v-if="showForm" class="wg-comment__form">
				<ui-textarea @onInput="isInputComment" caption="Ваш комментарий" :autoresize="100">
				</ui-textarea>
				<button v-show="description!=undefined" @click="createComment" class="ui-button ui-button_blue ui-button_mini wg-comments__form-button">
					Комментировать
				</button>
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
      showAnswers: false,
      showForm: false,
      description: undefined
    };
  },
  methods: {
    isInputComment(value) {
      if (value != "") {
        this.description = value;
      } else {
        this.description = undefined;
      }
    },
    createComment() {
      if (this.description != undefined) {
        let headers = { "Content-Type": "multipart/form-data" };
        let params = {
          comment_id: this.comment.id,
          user_id: this.$cookie.get("user_id"),
          session_id: this.$cookie.get("PHPSESSID"),
          ad_id: this.service_id,
          description: this.description
        };
        this.$http
          .post(
            this.$hosts.comments + "/api/create/" + this.service_type,
            params,
            headers
          )
          .then(
            response => {
              this.showComments();
            },
            error => {}
          );
      } else {
        this.showSnackbar = true;
        this.descSnackbar = "Комментарий пустой";
      }
    }
  },
  props: {
    comment: {
      type: Object,
      default: undefined
    },
    service_id: {
      type: [Number, String],
      default: undefined
    },
    service_type: {
      type: String,
      default: undefined
    }
  },
};
</script>
