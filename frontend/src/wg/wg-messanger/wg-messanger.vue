<template>
    <div class="wg-messanger">

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

        <div @click="showContacts=true" class="ui-button ui-button_circle wg-messanger__button-contacts">
            <i class="fa fa-users" aria-hidden="true"></i>
        </div>
        <div class="wg-messanger__contacts" v-show="showContacts">
            <div class="ui-avatar-block wg-messanger__avatar-block">
                <div class="ui-avatar">
                    <span class="ui-avatar__simbol">
                        T
                    </span>
                    <img alt="" src="http://photos-users.ru/public/photos/avatars/5/image_562409150038081735946.jpg">
                </div>
                <a class="ui-link ui-avatar-block__link">
                    Толян Кузикин
                </a>
                <div class="ui-avatar-block__title">
                    Здесь последнее сообщение
                </div>
                <button class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-messanger__avatar-block-button">
                    <i aria-hidden="true" class="fa fa-ellipsis-v"></i>
                </button>
            </div>
            <div class="ui-avatar-block wg-messanger__avatar-block">
                <div class="ui-avatar">
                    <span class="ui-avatar__simbol">
                        T
                    </span>
                    <img alt="" src="http://photos-users.ru/public/photos/avatars/5/image_562409150038081735946.jpg">
                </div>
                <a class="ui-link ui-avatar-block__link">
                    Толян Кузикин
                </a>
                <div class="ui-avatar-block__title">
                    Здесь последнее сообщение
                </div>
                <button class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-messanger__avatar-block-button">
                    <i aria-hidden="true" class="fa fa-ellipsis-v"></i>
                </button>
            </div>
        </div>
        <div>
            <div class="ui-avatar-block wg-messanger__message-block">
                <div class="ui-avatar">
                    <span class="ui-avatar__simbol">
                        T
                    </span>
                    <img alt="" src="http://photos-users.ru/public/photos/avatars/5/image_562409150038081735946.jpg">
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
                    <img alt="" src="http://photos-users.ru/public/photos/avatars/5/image_562409150038081735946.jpg">
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
                    <img alt="" src="http://photos-users.ru/public/photos/avatars/5/image_562409150038081735946.jpg">
                </div>

            </div>
        </div>
    </div>
</template>
<script>
export default {
  data() {
    return {
      //   tabs: "wg-messanger-contacts"
      showContacts: false
    };
  }
  //   methods: {
  //     isTabs(id) {
  //       this.tabs = id;
  //     }
  //   }
};
</script>

