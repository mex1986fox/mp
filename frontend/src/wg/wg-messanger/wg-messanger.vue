<template>
  <div class="wg-messanger" :style="{'height':heightMessanger+'px'}">

    <div class="wg-messanger__bar">
      <div class="ui-header ui-header_2 wg-messanger__header">
        <span>Messanger</span>
      </div>
      <button class="ui-button ui-button_circle ui-button_flat wg-form-add__close" @click="isClose">
       <i class="fa fa-times-thin" aria-hidden="true"></i>
      </button>
      <!-- <ui-tabs class="wg-messanger__tabs">
                <ui-tabs-tab id="wg-messanger-contacts" :checked="tabs=='wg-messanger-contacts'" @onFocus="isTabs">
                    Контакты
                </ui-tabs-tab>
                <ui-tabs-tab id="wg-messanger-message" :checked="tabs=='wg-messanger-message'" @onFocus="isTabs">
                    Переписки
                </ui-tabs-tab>
            </ui-tabs> -->

    </div>
    <transition name="wg-messanger__button-contacts">
      <div v-if="!showContacts" @click="showContacts=true" class="ui-button ui-button_circle wg-messanger__button-contacts">
        <i class="fa fa-users" aria-hidden="true"></i>
      </div>
    </transition>
    <transition name="wg-messanger__button-contacts">
      <div v-if="showContacts" @click="showContacts=false" class="ui-button ui-button_circle  wg-messanger__button-contacts wg-messanger__button-contacts_right">
        <i aria-hidden="true" class="fa fa-angle-left"></i>
      </div>
    </transition>
    <transition name="wg-messanger__contacts">
      <div class="wg-messanger__contacts" v-show="showContacts">
        <div class="wg-messanger__contacts-menu">
          <div class="ui-avatar-block wg-messanger__avatar-block">
            <div class="ui-avatar">
              <span class="ui-avatar__simbol">
                T
              </span>
              <img alt="" src="http://photos-users.ru/public/photos/avatars/1/25668.jpg">
            </div>
            <a class="ui-link ui-avatar-block__link">
              Толян Кузикин
            </a>
            <div class="ui-avatar-block__title">
              Здесь последнее сообщение
            </div>
            <!-- <button class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-messanger__avatar-block-button">
							<i aria-hidden="true"
							   class="fa fa-ellipsis-v"></i>
						</button> -->
          </div>
          <div class="ui-avatar-block wg-messanger__avatar-block">
            <div class="ui-avatar">
              <span class="ui-avatar__simbol">
                T
              </span>
              <img alt="" src="http://photos-users.ru/public/photos/avatars/1/25668.jpg">
            </div>
            <a class="ui-link ui-avatar-block__link">
              Толян Кузикин
            </a>
            <div class="ui-avatar-block__title">
              Здесь последнее сообщение
            </div>
            <!-- <button class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-messanger__avatar-block-button">
							<i aria-hidden="true"
							   class="fa fa-ellipsis-v"></i>
						</button> -->
          </div>
        </div>

      </div>
    </transition>
    <div class="wg-messanger__messages">

      <div class="wg-messanger__messages-block" :style="{'height':heightMessanger-heightForm-130+'px'}">

        <div v-for="(val, key) in messages" :key="key" class="ui-avatar-block wg-messanger__message-block">
          <div v-if="user_id==val.user_id">
            <ui-avatar v-if="val.user" class="wg-messanger__avatar" :lable="val.user.login">
              <img :src="val.user.avatar" alt="">
            </ui-avatar>
            <div class="wg-messanger__message">
              {{val.date_created}}
              {{val.message}}
            </div>
          </div>
          <div v-if="user_id!=val.user_id">
            <ui-avatar v-if="val.user" class="wg-messanger__avatar-apponent" :lable="val.user.login">
              <img :src="val.user.avatar" alt="">
            </ui-avatar>
            <div class="wg-messanger__message-apponent">
              {{val.date_created}}
              {{val.message}}
            </div>
          </div>

        </div>

      </div>

      <div ref="form" class="wg-messanger__messages-form">
        <ui-textarea :value="message" @onInput="isInputMassage" caption="Ваше сообщение" :autoresize="60" :focus="true">
        </ui-textarea>
        <button @click="createMessage" v-show="message!=undefined" class="ui-button ui-button_blue ui-button_circle ui-button_circle_mini wg-messanger__messages-form-button">
          <i class="fa fa-paper-plane-o" aria-hidden="true"></i>
        </button>
      </div>
    </div>

  </div>
</template>
<script>
export default {
  data() {
    return {
      user_id: this.$cookie.get("user_id"),
      showContacts: false,
      heightForm: 105,
      message: undefined,
      messages: undefined,
      apponent_id: this.apponent
    };
  },
  props: {
    apponent: {
      type: [String, Number],
      default: undefined
    }
  },
  methods: {
    isClose() {
      this.$emit("onHide");
    },
    isInputMassage(val) {
      this.heightForm = this.$refs.form.clientHeight;
      this.message = val != "" ? val : undefined;
    },
    createMessage() {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        user_id: this.$cookie.get("user_id"),
        session_id: this.$cookie.get("PHPSESSID"),
        apponent_id: this.apponent_id,
        message: this.message
      };
      this.description = undefined;
      this.$http
        .post(this.$hosts.messages + "/api/create/messages", params, headers)
        .then(
          response => {
            console.log(response.body);
          },
          error => {}
        );
    },
    showMessages() {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        user_id: this.$cookie.get("user_id"),
        session_id: this.$cookie.get("PHPSESSID"),
        apponent_id: this.apponent_id
      };
      this.description = undefined;
      this.$http
        .post(this.$hosts.messages + "/api/show/messages", params, headers)
        .then(
          response => {
            this.messages = response.body.messages;
            this.updateUsers();
          },
          error => {}
        );
    },
    updateUsers() {
      let users_id = [];
      this.messages.forEach(element => {
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
            this.messages = this.messages.map((ad, key, arr) => {
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
      this.messages.forEach(element => {
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
              this.messages = this.messages.map((ad, key, arr) => {
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
  mounted() {
    this.showMessages();
  },

  computed: {
    heightMessanger() {
      return document.body.clientHeight;
    }
  }
};
</script>

