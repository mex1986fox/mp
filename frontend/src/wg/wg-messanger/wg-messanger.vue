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
      </ui-tabs>-->
    </div>
    <transition name="wg-messanger__button-contacts">
      <div
        v-if="!showContacts"
        @click="showContacts=true"
        class="ui-button ui-button_circle wg-messanger__button-contacts"
      >
        <i class="fa fa-users" aria-hidden="true"></i>
      </div>
    </transition>
    <transition name="wg-messanger__button-contacts">
      <div
        v-if="showContacts"
        @click="showContacts=false"
        class="ui-button ui-button_circle wg-messanger__button-contacts wg-messanger__button-contacts_right"
      >
        <i aria-hidden="true" class="fa fa-angle-left"></i>
      </div>
    </transition>
    <div
      v-if="sumNewMessages!=undefined && sumNewMessages!=0 && !showContacts"
      class="ui-notific-mes wg-messanger__notific-mes"
    >{{sumNewMessages}}</div>
    <transition name="wg-messanger__contacts">
      <div class="wg-messanger__contacts" v-show="showContacts">
        <div class="wg-messanger__contacts-menu">
          <div
            v-if="val.user"
            v-for="(val, key) in dialogs"
            :key="key"
            class="ui-avatar-block wg-messanger__avatar-block"
            @click="isClickContact(val.apponent_id, val.dialog_id)"
          >
            <ui-avatar class="ui-avatar" :lable="val.user.login">
              <img :src="val.user.avatar" alt="">
            </ui-avatar>
            <div
              v-if="newMessage!=undefined && newMessage[val.user.id]!=undefined && newMessage[val.user.id]!=0"
              class="ui-notific-mes wg-messanger__notific-mes-cont"
            >{{newMessage[val.user.id]}}</div>
            <a class="ui-link ui-avatar-block__link">{{val.user.name+" "+val.user.surname}}</a>
            <div class="ui-avatar-block__title">Здесь последнее сообщение</div>
            <!-- <button class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-messanger__avatar-block-button">
							<i aria-hidden="true"
							   class="fa fa-ellipsis-v"></i>
            </button>-->
          </div>
        </div>
      </div>
    </transition>
    <div class="wg-messanger__messages">
      <div
        ref="messages"
        class="wg-messanger__messages-block"
        :style="{'height':heightMessanger-heightForm-130+'px'}"
      >
        <div
          v-for="(val, key) in messages"
          :key="key"
          class="ui-avatar-block wg-messanger__message-block"
          :class="{'wg-messanger__message-block_noread': !val.status_read && user_id==val.user_id,
             'wg-messanger__message-block_newread': !val.status_read && user_id!=val.user_id}"
        >
          <div v-if="user_id==val.user_id">
            <ui-avatar v-if="val.user" class="wg-messanger__avatar" :lable="val.user.login">
              <img :src="val.user.avatar" alt="">
            </ui-avatar>
            <div class="wg-messanger__message">
              <span class="wg-messanger__message-date-create">
                {{val.date_created}}
                <div
                  @click="(showMenu=true, idDelMess=val._id.$oid)"
                  class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat wg-messanger__message-but-menu"
                >
                  <i class="fa fa-ellipsis-h" aria-hidden="true"></i>
                </div>
              </span>
              <div v-html="val.message"></div>
            </div>
          </div>
          <div v-if="user_id!=val.user_id">
            <ui-avatar
              v-if="val.user"
              class="wg-messanger__avatar-apponent"
              :lable="val.user.login"
            >
              <img :src="val.user.avatar" alt="">
            </ui-avatar>
            <div class="wg-messanger__message-apponent">
              <span class="wg-messanger__message-date-create">{{val.date_created}}</span>
              <div v-html="val.message"></div>
            </div>
          </div>
        </div>
      </div>
      <ui-loader
        class="wg-messanger__loader"
        v-if="flagLoadingHistory==true || flagLoadingMessages==true"
      ></ui-loader>
      <ui-menu :show="showSmiles" @onHide="showSmiles=false" position="left-top">
        <wg-smiles @onClick="isClickSmile"></wg-smiles>
      </ui-menu>
      <div ref="form" class="wg-messanger__messages-form">
        <ui-contenteditable
          ref="contenteditable"
          @onInput="isInputMassage"
          caption="Ваше сообщение"
          :autoresize="60"
          :focus="true"
        ></ui-contenteditable>
        <div class="wg-messanger__messages-form-button">
          <div @click="showSmiles=true" class="ui-button ui-button_circle ui-button_circle_mini">
            <i class="fa fa-smile-o" aria-hidden="true"></i>
          </div>
          <button
            @click="createMessage"
            v-show="message!=undefined"
            class="ui-button ui-button_blue ui-button_circle ui-button_circle_mini"
          >
            <i class="fa fa-paper-plane-o" aria-hidden="true"></i>
          </button>
        </div>
      </div>
    </div>
    <ui-menu
      :show="showMenu"
      @onHide="(showMenu=false, dCrMessage=undefined)"
      position="left-bottom"
    >
      <ul class="wg-card-ad__menu">
        <li @click="deletedMessage" class="wg-card-ad__menu-li">Удалить сообщение</li>
      </ul>
    </ui-menu>
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
      dialogs: undefined,
      apponent_id: this.apponent,
      socket: undefined,
      newMessage: undefined,
      showSmiles: false,
      activeBrauzer: true,
      showMenu: false,
      idDelMess: undefined,
      dialog_id: undefined,
      lastMes: undefined,
      stopFrame: false,
      oldScrollHeight: undefined,
      flagLoadingHistory: false,
      flagLoadingMessages: false,
      flagScroll: true
    };
  },
  props: {
    apponent: {
      type: [String, Number],
      default: undefined
    }
  },
  methods: {
    isClickSmile(sm) {
      let smile = "<img src='" + sm[1] + "' class='wg-smiles__smile'> ";
      this.$refs.contenteditable.$emit("onAddNode", smile);
      this.showSmiles = false;
    },
    isClose() {
      this.$emit("onHide");
      this.socket.close();
    },
    isClickContact(apponent_id, dialog_id) {
      this.showContacts = false;
      this.apponent_id = apponent_id;
      this.dialog_id = dialog_id;
      if (this.markReadMessage() == false) {
        this.messages = [];
        this.stopFrame = false;
        this.lastMes = undefined;
        this.oldScrollHeight = undefined;
        this.showMessages();
      }
    },
    addNewMessages(newMessages) {
      let flagPush;
      if (this.messages != undefined) {
        newMessages.forEach(newMes => {
          flagPush = true;
          this.messages.forEach(oldMes => {
            if (oldMes._id.$oid == newMes._id.$oid) {
              oldMes.status_read = newMes.status_read;
              flagPush = false;
            }
          });
          if (flagPush == true) {
            this.messages.push(newMes);
          }
        });
      } else {
        this.messages = newMessages;
      }
      this.messages = this.messages.sort(
        (a, b) => (a.date_created < b.date_created ? -1 : 1)
      );
    },
    //добавляет юзеров в сообщения
    addUsersToMessages() {
      //  = [];
      this.messages.forEach(mes => {
        mes.user = this.users[mes.user_id];
      });
      let newMes = this.messages;
      this.messages = undefined;
      this.messages = newMes;
    },
    // добавляет юзеров в диалоги
    addUsersToDialogs() {
      let newDial = [];
      this.dialogs.forEach(dial => {
        dial.user = this.users[dial.apponent_id];
        newDial.push(dial);
      });
      this.dialogs = [];
      this.dialogs = newDial;
    },
    isInputMassage(val) {
      this.heightForm = this.$refs.form.clientHeight;
      this.message = val != "" ? val : undefined;
    },
    // отправляет новое сообщение
    // для его создания
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
            this.message = "";
            this.$refs.contenteditable.$emit("onAddValue", this.message);
            this.SetUnreadMessage();
            this.showMessages();
          },
          error => {}
        );
    },
    deletedMessage() {
      this.showMenu = false;
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        user_id: this.$cookie.get("user_id"),
        session_id: this.$cookie.get("PHPSESSID"),
        apponent_id: this.apponent_id,
        message_id: this.idDelMess
      };
      this.description = undefined;
      this.$http
        .post(this.$hosts.messages + "/api/delete/messages", params, headers)
        .then(
          response => {
            this.flagScroll = false;
            this.messages = this.messages.filter(mes => {
              return mes._id.$oid != response.body.message_id;
            });
            this.SetUnreadMessage();
            this.showMessages();
          },
          error => {}
        );
    },
    // создает соединение с сервером
    // вебсоккетов
    // который присылает уведомления о новых сообщениях
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
        alert("Соединение установлено.");
        this.GetUnreadMessages();
      };
      this.socket.onmessage = event => {
        this.newMessage = undefined;
        setTimeout(() => {
          // console.log(event.data);
          this.newMessage = JSON.parse(event.data);
          // this.showMessages();
          //отметит сообщение прочитанным
          // если не отметит просто прочитает новые сообщения
          if (this.markReadMessage() == false) {
            this.showMessages();
          }

          // console.log(this.newMessage);
        }, 4);
      };
    },
    // запрос к серверу вебсоккетов
    // для получения новых сообщений
    GetUnreadMessages() {
      let json = {
        name: "GetUnreadMessages",
        params: [{ name: "userId", val: String(this.$cookie.get("user_id")) }]
      };
      this.socket.send(JSON.stringify(json));
    },
    // запрос к вебсокету
    // что бы аппоненту пришло уведомление
    // что есть непрочитанные сообщения для него
    SetUnreadMessage() {
      let json = {
        name: "SetUnreadMessage",
        params: [{ name: "apponentID", val: String(this.apponent_id) }]
      };
      this.socket.send(JSON.stringify(json));
    },
    //скачает диалоги какие есть для юзера
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
            for (const key in this.dialogs) {
              users.push(this.dialogs[key].apponent_id);
            }
            this.$store.dispatch("users/add", users);
            this.addUsersToDialogs();
          },
          error => {}
        );
    },
    // покажет сообщения для юзера
    showMessages(lastMes) {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        user_id: this.$cookie.get("user_id"),
        session_id: this.$cookie.get("PHPSESSID"),
        apponent_id: this.apponent_id
      };
      if (lastMes != undefined) {
        params.last_mes = this.lastMes = lastMes;
      } else {
        this.lastMes = undefined;
      }
      this.description = undefined;
      this.flagLoadingMessages = true;
      this.$http
        .post(this.$hosts.messages + "/api/show/messages", params, headers)
        .then(
          response => {
            this.flagLoadingMessages = false;
            this.flagLoadingHistory = false;
            this.oldScrollHeight = this.$refs.messages.scrollHeight;
            this.addNewMessages(response.body.messages);
            if (response.body.last_frame == true) {
              this.stopFrame = true;
            }
            let users = [];
            for (const key in this.messages) {
              users.push(this.messages[key].user_id);
            }
            this.$store.dispatch("users/add", users);
            this.addUsersToMessages();

            setTimeout(() => {
              if (this.lastMes == undefined && this.flagScroll == true) {
                this.$refs.messages.scrollTop = this.$refs.messages.scrollHeight;
              } else {
                if (this.$refs.messages.scrollHeight > this.oldScrollHeight) {
                  this.$refs.messages.scrollTop =
                    this.$refs.messages.scrollHeight - this.oldScrollHeight;
                }
                this.flagScroll = true;
              }
              if (this.fMoutn == true) {
                this.isClickContact(this.apponent_id, this.dialog_id);
                this.fMoutn = false;
              }
            }, 4);
          },
          error => {}
        );
    },
    // пометит сообщения прочитанными
    markReadMessage() {
      for (var key in this.newMessage) {
        if (key == this.apponent_id && this.activeBrauzer == true) {
          let headers = { "Content-Type": "multipart/form-data" };
          let params = {
            user_id: this.$cookie.get("user_id"),
            session_id: this.$cookie.get("PHPSESSID"),
            dialog_id: this.dialog_id
          };
          this.description = undefined;
          this.$http
            .post(
              this.$hosts.messages + "/api/markRead/messages",
              params,
              headers
            )
            .then(
              response => {
                // this.message = response.body.message;
                // console.log("отметил чтопрочитал сообщение");
                this.SetUnreadMessage();
                this.GetUnreadMessages();
                this.showMessages();
              },
              error => {
                // console.log(error);
              }
            );
          return true;
        }
      }
      return false;
    }
  },
  mounted() {
    this.createWebSocket();
    this.showDialogs();
    if (this.apponent != undefined) {
      this.showMessages();
    } else {
      this.showContacts = true;
    }
    this.fMoutn = true;
    window.addEventListener("focus", () => {
      this.activeBrauzer = true;
    });
    window.addEventListener("blur", () => {
      this.activeBrauzer = false;
    });
    this.$refs.messages.addEventListener("scroll", () => {
      if (
        this.flagLoadingHistory != true &&
        this.stopFrame == false &&
        this.$refs.messages.scrollTop == 0
      ) {
        this.showMessages(this.messages[0]._id.$oid);
        this.flagLoadingHistory = true;
      }
    });
  },
  watch: {
    // usersFUpdate(newQ, oldQ) {
    //   if (newQ != oldQ) {
    //     this.addUsersToMessages();
    //     this.addUsersToDialogs();
    //   }
    // },
    activeBrauzer(newQ, oldQ) {
      if (newQ == true) {
        setTimeout(() => {
          if (this.activeBrauzer == true) {
            this.markReadMessage();
          }
        }, 4000);
      }
    },
    users(newQ, oldQ) {
      if (this.apponent != undefined) {
        this.addUsersToMessages();
      }
      this.addUsersToDialogs();
    }
  },
  computed: {
    // usersFUpdate() {
    //   return this.$store.state.users.flagUpdate;
    // },
    sumNewMessages() {
      if (this.newMessage != undefined) {
        // console.log(this.newMessage)
        let i = 0;
        for (let key in this.newMessage) {
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
    },
    users() {
      return this.$store.state.users.buffer;
    }
  }
};
</script>

