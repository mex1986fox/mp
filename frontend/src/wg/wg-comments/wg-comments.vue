<template>
  <div class="wg-comments">
    <!-- <button
      @click="isClose"
      class="ui-button ui-button_circle  ui-button_flat ui-button_circle_mini wg-slider__button_flat wg-comments__close"
    >
      <i aria-hidden="true" class="fa fa-times"></i>
    </button>-->
    <div class="wg-comments__container">
      <span
        class="ui-header ui-header_4"
        v-if="flagNoComments==true"
      >Никто не оставил комментариев. Вы можете быть первым!</span>
      <wg-comment
        :service_type="service_type"
        :service_id="service_id"
        v-if="comments.length>0"
        v-for="(val, key) in comments"
        :key="key"
        :comment="JSON.parse(JSON.stringify(val))"
      ></wg-comment>
      <div class="ui-button ui-button_flat" @click="showMoreComments">показать еще</div>
    </div>
    <div ref="form" class="wg-comments__form">
      <!-- <div class="ui-avatar wg-comments__form-avatar">
				<img src="/public/img/avatar.jpg"
				     alt="">
      </div>-->
      <!-- <div class="wg-comments__description"> -->
      <ui-textarea
        :value="description"
        @onInput="isInputComment"
        caption="Ваш комментарий"
        :autoresize="100"
        :focus="false"
      ></ui-textarea>
      <button
        v-show="description!=undefined"
        @click="createComment"
        class="ui-button ui-button_blue ui-button_mini wg-comments__form-button"
      >Комментировать</button>
      <!-- </div> -->
    </div>
    <div class="row">
      <div class="col_12">
        <ui-snackbar
          :show="showSnackbar"
          @onHide="showSnackbar=false"
          :time="20000"
        >{{descSnackbar}}</ui-snackbar>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "wg-comments",
  data() {
    return {
      comments: [],
      description: undefined,
      showSnackbar: false,
      descSnackbar: "",
      flagNoComments: false
    };
  },
  props: {
    service_id: {
      type: [Number, String],
      default: undefined
    },
    service_type: {
      type: String,
      default: undefined
    }
  },
  methods: {
    isClose() {
      this.$emit("onHide");
    },
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
          user_id: this.$cookie.get("user_id"),
          session_id: this.$cookie.get("PHPSESSID"),
          id: this.service_id,
          description: this.description
        };
        this.description = undefined;
        this.$http
          .post(
            this.$hosts.comments + "/api/create/" + this.service_type,
            params,
            headers
          )
          .then(
            response => {
              this.comments = undefined;
              setTimeout(() => {
                this.showComments();
              }, 100);
            },
            error => {}
          );
      } else {
        this.showSnackbar = true;
        this.descSnackbar = "Комментарий пустой";
      }
    },
    showComments() {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        id: this.service_id
      };
      this.$http
        .post(
          this.$hosts.comments + "/api/show/" + this.service_type,
          params,
          headers
        )
        .then(
          response => {
            this.flagNoComments = false;
            this.comments = response.body.comments;
            console.dir(this.comments);
            this.updateUsers();
          },
          error => {
            if (
              error.body.exceptions.massege ==
              "Нет коментариев к данному объявлению"
            ) {
              this.flagNoComments = true;
            }
          }
        );
    },
    showMoreComments() {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        id: this.service_id,
        pagin_id: this.comments[this.comments.length - 1].id
      };
      this.$http
        .post(
          this.$hosts.comments + "/api/show/" + this.service_type,
          params,
          headers
        )
        .then(
          response => {
            let moreComments = response.body.comments;
            let comments = this.comments;
            moreComments.forEach(mComment => {
              comments.push(mComment);
            });
            this.comments = undefined;
            this.comments = comments;
            this.updateUsers();
          },
          error => {
            if (
              error.body.exceptions.massege ==
              "Нет коментариев к данному объявлению"
            ) {
              this.flagNoComments = true;
            }
          }
        );
    },
    updateUsers() {
      let users_id = [];
      this.comments.forEach(element => {
        users_id.push(element.user_id);
      });
      let params = {
        users_id: users_id.filter((e, i, a) => a.indexOf(e) == i)
      };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http.post("/api/show/users", params, headers).then(
        response => {
          let users = response.body.users;
          users.forEach(user => {
            this.comments = this.comments.map((ad, key, arr) => {
              if (ad.user_id == user.id) {
                arr[key].user = user;
              }
              return ad;
            });
          });

          this.updatePhotoAvatars();
        },
        error => {}
      );
    },

    updatePhotoAvatars() {
      let users_id = [];
      this.comments.forEach(element => {
        users_id.push(element.user_id);
      });
      let params = {
        users_id: users_id.filter((e, i, a) => a.indexOf(e) == i)
      };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.photosUsers + "/api/show/avatars", params, headers)
        .then(
          response => {
            let avatars = response.body.avatars;
            avatars.forEach(avatar => {
              this.comments = this.comments.map((ad, key, arr) => {
                if (ad.user_id == avatar.user_id) {
                  arr[key].user.avatar = avatar.lincks[0];
                }
                return ad;
              });
            });
          },
          error => {}
        );
    }
  },
  computed: {
    heightComments() {
      return document.body.clientHeight;
    }
  },
  mounted() {
    this.showComments();
  }
};
</script>
