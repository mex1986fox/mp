<template>
  <div>
    <div class="wg-comment__comment">
      <div v-if="comment.user!=undefined">
        <ui-avatar
          :class="{'wg-comment__avatar':!ansver,'wg-answer__avatar':ansver,}"
          :lable="comment.user.login"
        >
          <img :src="comment.user.avatar" alt>
        </ui-avatar>
      </div>
      <div class="wg-comment__description">
        <div class="wg-comment__login" v-if="comment.user!=undefined">
          <a class="ui-link" href>{{comment.user.name+" "+comment.user.surname}}</a>
        </div>
        <div class="wg-comment__date">{{comment.date_create}}</div>
        <div class="ui-description ui-description_mini">{{comment.description}}</div>
        <div class="wg-comment__buttons">
          <!-- <button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
            <i aria-hidden="true" class="fa fa-thumbs-o-up"></i>
          </button>
          <div class="ui-counter">{{comment.likes}}</div>
          <button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
            <i aria-hidden="true" class="fa fa-thumbs-o-down"></i>
          </button>
          <div class="ui-counter">{{comment.dislikes}}</div>-->
          <button
            @click="showForm=true"
            class="ui-button ui-button_mini ui-button_flat"
            style="margin-top: 10px;"
          >Ответить</button>
          <div v-if="!dShowComments && comment.ansversLength!=undefined">
            <button
              @click="isShowComments"
              class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat"
            >
              <i aria-hidden="true" class="fa fa-comments-o"></i>
              <!-- <i v-if="dShowComments" aria-hidden="true" class="fa fa-angle-up"></i> -->
            </button>
            <div class="ui-counter">{{comment.ansversLength}}</div>
          </div>
        </div>
        <div v-if="showForm" class="wg-comment__form">
          <ui-textarea
            @onBlur="isBlurComment"
            @onInput="isInputComment"
            :caption="'Ваш ответ'"
            :autoresize="100"
            :focus="true"
          ></ui-textarea>
          <button
            v-show="description!=undefined"
            @click="createComment"
            class="ui-button ui-button_blue ui-button_mini wg-comments__form-button"
          >Ответить</button>
        </div>
      </div>
    </div>
    <transition name="wg-comment__ansvers">
      <div v-show="dShowComments!=false" :class="{'wg-comment__ansvers':!ansver}">
        <wg-comment
          :ansver="true"
          :service_type="service_type"
          :service_id="service_id"
          v-if="comments.length>0"
          v-for="(val, key) in comments"
          :key="key"
          :comment="JSON.parse(JSON.stringify(val))"
        ></wg-comment>
        <div v-if="showMoreButtons" class="wg-comment__ansvers-buttons">
          <div
            class="ui-button ui-button_mini ui-button_flat"
            @click="showMoreComments"
          >{{'еще ответы для '+comment.user.login}}</div>
        </div>
      </div>
    </transition>
  </div>
</template>
<script>
export default {
  name: "wg-comment",
  data() {
    return {
      comments: [],
      dShowComments: false,
      showAnswers: false,
      showForm: false,
      description: undefined,
      showMoreButtons: false
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
    isBlurComment() {
      if (this.description == undefined) {
        this.showForm = false;
      }
    },
    isShowComments() {
      this.showComments();
    },
    createComment() {
      this.showForm = false;
      if (this.description != undefined) {
        let headers = { "Content-Type": "multipart/form-data" };
        let params = {
          comment_id: this.comment.id,
          user_id: this.$cookie.get("user_id"),
          session_id: this.$cookie.get("PHPSESSID"),
          id: this.service_id,
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
              this.comments = undefined;
              setTimeout(() => {
                this.showComments();
              }, 100);
              // this.showComments();
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
        comment_id: this.comment.id,
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
            this.comments = response.body.comments;
            if (response.body.comments.length < 2) {
              this.showMoreButtons = false;
            } else {
              this.showMoreButtons = true;
            }
            this.updateUsers();
            this.dShowComments = true;
          },
          error => {}
        );
      this.dShowComments = false;
    },
    showMoreComments() {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        comment_id: this.comment.id,
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
            if (response.body.comments.length < 2) {
              this.showMoreButtons = false;
            } else {
              this.showMoreButtons = true;
            }
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
    },
    ansver: {
      type: Boolean,
      default: false
    }
  }
};
</script>
