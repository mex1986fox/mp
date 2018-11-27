<template>
    <div class="wg-card-users">
        <div class="wg-card-users__avatar-block">
            <ui-avatar class="wg-card-users__avatar" :lable="user.login">
                <img v-if="user.avatar!=undefined" :src="user.avatar" alt="">
            </ui-avatar>
        </div>
        <div class="wg-card-users__description">
            <span class="wg-card-users__login">{{user.login}}</span>
            <span class="wg-card-users__name">{{user.name+" "+user.surname}}</span>
            <span class="wg-card-users__col ui-description">
                Место проживания:
                <span
                    v-if="user.settlement_id!=undefined"
                    class="wg-card-users__col_desc"
                >{{country.name+" "+subject.name+" "+ settlement.name}}</span>
                <span v-else class="wg-card-users__col_desc">не указал</span>
            </span>
            <span class="wg-card-users__col ui-description">
                Дата рождения:
                <span class="wg-card-users__col_desc">{{user.birthdate}}</span>
            </span>
            <span class="wg-card-users__col ui-description">
                Последний визит:
                <span class="wg-card-users__col_desc">10/15/2015</span>
            </span>
        </div>
        <button
            @click="showMenu=true"
            class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-card-users__header-button"
        >
            <i class="fa fa-ellipsis-v" aria-hidden="true"></i>
        </button>
        <ui-menu :show="showMenu" @onHide="showMenu=false" position="left-bottom">
            <ul class="wg-card-ad__menu">
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
  },
  props: {
    user: {
      type: Object,
      default: () => {}
    }
  },
  computed: {
    settlement() {
      if (
        this.user.settlement_id != undefined &&
        this.$store.state.locations.settlements != undefined
      ) {
        return this.$store.getters["locations/getSettlement"](
          this.user.settlement_id
        );
      } else {
        return { name: "" };
      }
    },
    subject() {
      if (
        this.user.settlement_id != undefined &&
        this.$store.state.locations.settlements != undefined
      ) {
        return this.$store.getters["locations/getSubject"](
          this.settlement.subject_id
        );
      } else {
        return { name: "" };
      }
    },
    country() {
      if (
        this.user.settlement_id != undefined &&
        this.$store.state.locations.settlements != undefined
      ) {
        return this.$store.getters["locations/getCountry"](
          this.subject.country_id
        );
      } else {
        return { name: "" };
      }
    }
  }
};
</script>

