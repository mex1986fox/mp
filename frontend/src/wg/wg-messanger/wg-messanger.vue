<template>
	<div class="wg-messanger"
	     :style="{'height':heightMessanger+'px'}">

		<div class="wg-messanger__bar">
			<div class="ui-header ui-header_2 wg-messanger__header">
				<span>Messanger</span>
			</div>

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
		<transition name="wg-messanger__contacts">
			<div class="wg-messanger__contacts"
			     v-show="showContacts">
				<div class="wg-messanger__contacts-menu">
					<div class="ui-avatar-block wg-messanger__avatar-block">
						<div class="ui-avatar">
							<span class="ui-avatar__simbol">
								T
							</span>
							<img alt=""
							     src="http://photos-users.ru/public/photos/avatars/1/25668.jpg">
						</div>
						<a class="ui-link ui-avatar-block__link">
							Толян Кузикин
						</a>
						<div class="ui-avatar-block__title">
							Здесь последнее сообщение
						</div>
						<button class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-messanger__avatar-block-button">
							<i aria-hidden="true"
							   class="fa fa-ellipsis-v"></i>
						</button>
					</div>
					<div class="ui-avatar-block wg-messanger__avatar-block">
						<div class="ui-avatar">
							<span class="ui-avatar__simbol">
								T
							</span>
							<img alt=""
							     src="http://photos-users.ru/public/photos/avatars/1/25668.jpg">
						</div>
						<a class="ui-link ui-avatar-block__link">
							Толян Кузикин
						</a>
						<div class="ui-avatar-block__title">
							Здесь последнее сообщение
						</div>
						<button class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-messanger__avatar-block-button">
							<i aria-hidden="true"
							   class="fa fa-ellipsis-v"></i>
						</button>
					</div>
				</div>

			</div>
		</transition>
		<div class="wg-messanger__messages">
			<div class="ui-avatar-block wg-messanger__message-block">
				<div class="ui-avatar">
					<span class="ui-avatar__simbol">
						T
					</span>
					<img alt=""
					     src="http://photos-users.ru/public/photos/avatars/1/25668.jpg">
				</div>
				<div class="wg-messanger__message-apponent">
					сообщение
				</div>
			</div>
			<div class="ui-avatar-block wg-messanger__message-block">
				<div class="ui-avatar">
					<span class="ui-avatar__simbol">
						T
					</span>
					<img alt=""
					     src="http://photos-users.ru/public/photos/avatars/1/25668.jpg">
				</div>
				<div class="wg-messanger__message-apponent">
					сообщение Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi, nulla neque natus possimus vitae sit. Doloremque aspernatur vero deleniti facilis, ex suscipit, optio mollitia perferendis molestias placeat commodi, quis aut!
				</div>
			</div>
			<div class="ui-avatar-block wg-messanger__message-block">
				<div class="wg-messanger__message">
					сообщение ex suscipit, optio mollitia perferendis molestias placeat commodi, quis aut!
				</div>
				<div class="ui-avatar">
					<span class="ui-avatar__simbol">
						T
					</span>
					<img alt=""
					     src="http://photos-users.ru/public/photos/avatars/1/25668.jpg">
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
				<button v-show="message!=undefined"
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
      showContacts: false,
      message: undefined
    };
  },
  methods: {
    isInputMassage(val) {
      this.message = val != "" ? val : undefined;
    }
  },

  computed: {
    heightMessanger() {
      if (document.body.clientWidth > 770) {
        return document.body.clientHeight - 60;
      } else {
        return document.body.clientHeight;
      }
    }
  }
};
</script>

