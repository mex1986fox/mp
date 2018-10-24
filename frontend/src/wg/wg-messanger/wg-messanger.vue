<template>
	<div class="wg-messanger"
	     :style="{'height':heightMessanger+'px'}">

		<div class="wg-messanger__bar">
			<div class="ui-header ui-header_2 wg-messanger__header">
				<span>Messanger</span>
			</div>
			<button class="ui-button ui-button_circle ui-button_flat wg-form-add__close"
			        @click="isClose">
				<i class="fa fa-times-thin"
				   aria-hidden="true"></i>
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
			<div v-if="!showContacts"
			     @click="showContacts=true"
			     class="ui-button ui-button_circle wg-messanger__button-contacts">
				<i class="fa fa-users"
				   aria-hidden="true"></i>
			</div>
		</transition>
		<transition name="wg-messanger__button-contacts">
			<div v-if="showContacts"
			     @click="showContacts=false"
			     class="ui-button ui-button_circle  wg-messanger__button-contacts wg-messanger__button-contacts_right">
				<i aria-hidden="true"
				   class="fa fa-angle-left"></i>
			</div>
		</transition>
		<div v-if="sumNewMessages!=undefined && !showContacts"
		     class="ui-notific-mes wg-messanger__notific-mes">
			{{sumNewMessages}}
		</div>
		<transition name="wg-messanger__contacts">
			<div class="wg-messanger__contacts"
			     v-show="showContacts">
				<div class="wg-messanger__contacts-menu">
					<div v-if="val.user"
					     v-for="(val, key) in dialogs"
					     :key="key"
					     class="ui-avatar-block wg-messanger__avatar-block">
						<ui-avatar class="ui-avatar"
						           :lable="val.user.login">
							<img :src="val.user.avatar"
							     alt="">
						</ui-avatar>
						<a class="ui-link ui-avatar-block__link">
							{{val.user.name+" "+val.user.surname}}
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

			<div class="wg-messanger__messages-block"
			     :style="{'height':heightMessanger-heightForm-130+'px'}">

				<div v-for="(val, key) in messages"
				     :key="key"
				     class="ui-avatar-block wg-messanger__message-block">
					<div v-if="user_id==val.user_id">
						<ui-avatar v-if="val.user"
						           class="wg-messanger__avatar"
						           :lable="val.user.login">
							<img :src="val.user.avatar"
							     alt="">
						</ui-avatar>
						<div class="wg-messanger__message">{{val.date_created}}
							{{val.message}}
						</div>
					</div>
					<div v-if="user_id!=val.user_id">
						<ui-avatar v-if="val.user"
						           class="wg-messanger__avatar-apponent"
						           :lable="val.user.login">
							<img :src="val.user.avatar"
							     alt="">
						</ui-avatar>
						<div class="wg-messanger__message-apponent">{{val.date_created}}
							{{val.message}}
						</div>
					</div>

				</div>

			</div>

			<div ref="form"
			     class="wg-messanger__messages-form">
				<ui-textarea :value="message"
				             @onInput="isInputMassage"
				             caption="Ваше сообщение"
				             :autoresize="60"
				             :focus="true">
				</ui-textarea>
				<button @click="createMessage"
				        v-show="message!=undefined"
				        class="ui-button ui-button_blue ui-button_circle ui-button_circle_mini wg-messanger__messages-form-button">
					<i class="fa fa-paper-plane-o"
					   aria-hidden="true"></i>
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
      users: this.$store.state.users.buffer,
      showContacts: false,
      heightForm: 105,
      message: undefined,
      messages: undefined,
      dialogs: undefined,
      apponent_id: this.apponent,
      socket: undefined,
      newMessage: undefined
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
      this.socket.close();
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
            this.SetUnreadMessage();
          },
          error => {}
        );
    },
    createWebSocket() {
      let user_id = this.$cookie.get("user_id");
      let session_id = this.$cookie.get("PHPSESSID");
      this.socket = new WebSocket(
        this.$hosts.wsmessages +
          "/ws?session_id=" +
          session_id +
          "&user_id=" +
          user_id
      );
      this.socket.onopen = () => {
        // alert("Соединение установлено.");
        this.GetUnreadMessages();
      };
      this.socket.onmessage = event => {
        this.newMessage = JSON.parse(event.data);
      };
    },
    GetUnreadMessages() {
      let json = {
        name: "GetUnreadMessages",
        params: [{ name: "userId", val: String(this.$cookie.get("user_id")) }]
      };
      this.socket.send(JSON.stringify(json));
    },
    SetUnreadMessage() {
      let json = {
        name: "SetUnreadMessage",
        params: [{ name: "apponentID", val: String(this.apponent_id) }]
      };
      this.socket.send(JSON.stringify(json));
    },
    showDialogs() {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        user_id: this.$cookie.get("user_id"),
        session_id: this.$cookie.get("PHPSESSID")
      };
      this.description = undefined;
      this.$http
        .post(this.$hosts.messages + "/api/show/dialogs", params, headers)
        .then(
          response => {
            this.dialogs = response.body.dialogs;
            let users = [];
            this.dialogs.forEach(mes => {
              users.push(mes.apponent_id);
            });
            this.$store.dispatch("users/add", users);
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
            let users = [];
            this.messages.forEach(mes => {
              users.push(mes.user_id);
            });
            this.$store.dispatch("users/add", users);
          },
          error => {}
        );
    }
  },
  mounted() {
    this.createWebSocket();
    this.showDialogs();
    this.showMessages();
  },
  watch: {
    usersFUpdate(newQ, oldQ) {
      if (newQ != oldQ) {
        let newMes = [];
        this.messages.forEach(mes => {
          mes.user = this.users[mes.user_id];
          newMes.push(mes);
        });
        this.messages = [];
        this.messages = newMes;

        let newDial = [];
        this.dialogs.forEach(dial => {
          dial.user = this.users[dial.apponent_id];
          newDial.push(dial);
        });
        this.dialogs = [];
        this.dialogs = newDial;
      }
    }
  },
  computed: {
    usersFUpdate() {
      return this.$store.state.users.flagUpdate;
    },
    sumNewMessages() {
      if (this.newMessage != undefined) {
        let i = 0;
        for (var key in this.newMessage) {
          if (key != this.user_id) {
            i = i + this.newMessage[key];
          }
        }
        return i;
      }
      return undefined;
    },
    heightMessanger() {
      return document.body.clientHeight;
    }
  }
};
</script>

