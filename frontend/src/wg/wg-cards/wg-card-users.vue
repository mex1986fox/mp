<template>
    <div class="wg-card-users">
        <div class="wg-card-users__avatar-block">
            <ui-avatar class="wg-card-users__avatar" :lable="'figoro'">
                <img
                    :src="'http://photos-users.ru/public/photos/avatars/5/gen1200_285646914.jpg'"
                    alt=""
                >
            </ui-avatar>
        </div>
        <div class="wg-card-users__description">
            <span class="wg-card-users__login">drovito</span>
            <span class="wg-card-users__name">Владимир Пресняков</span>
            <span class="wg-card-users__col ui-description">
                Место проживания:
                <span
                    class="wg-card-users__col_desc"
                >Россия Кемеровская область Кемерово</span>
            </span>
            <span class="wg-card-users__col ui-description">
                Дата рождения:
                <span class="wg-card-users__col_desc">10/15/2015</span>
            </span>
            <span class="wg-card-users__col ui-description">
                Последний визит:
                <span class="wg-card-users__col_desc">10/15/2015</span>
            </span>
        </div>
        <button
            @click="showMenu=true"
            class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-card-ad__header-button"
        >
            <i class="fa fa-ellipsis-v" aria-hidden="true"></i>
        </button>
        <ui-menu :show="showMenu" @onHide="showMenu=false" position="left-bottom">
            <ul сlass="wg-card-ad__menu">
                <li @click="showMenu=false" class="wg-card-ad__menu-li">Добавить в друзья</li>
                <li
                    @click="(showMenu=false, showContacts=true)"
                    class="wg-card-ad__menu-li"
                >Показать контакты</li>
                <li
                    @click="(showMenu=false, showMessenger=true)"
                    class="wg-card-ad__menu-li"
                >Написать сообщение</li>
            </ul>
        </ui-menu>
    </div>
</template>
<script>
export default {
  data() {
    return {
      showMenu: false,
      showContacts: false,
      showMessenger: false
    };
  }
};
</script>

