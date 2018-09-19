<template>
    <layout>
        <div class="container">
            <div class="row">
                <div class="col_6 col_offset-3">
                    <div class="row">
                        <div class="col_12">
                            <div class="ui-avatar-block  pg-account-data__avatar-block">
                                <div class="ui-avatar pg-account-data__avatar">
                                    <img src="/public/img/avatar.png" alt="">
                                </div>
                                <span class="ui-avatar-block__link pg-account-data__avatar-linck">Drovito</span>
                                <span class="ui-avatar-block__title  pg-account-data__avatar-title">Максим Сыманович</span>
                            </div>
                            <button @click="showMenu=true" class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini pg-account-data__avatar-button">
                                <i class="fa fa-ellipsis-v" aria-hidden="true"></i>
                            </button>
                            <ui-menu :show="showMenu" @onHide="showMenu=false" position="left-bottom">
                                <ul class="wg-card-ad__menu">
                                    <li class="wg-card-ad__menu-li">Сменить аватар</li>
                                    <li class="wg-card-ad__menu-li" @click="(showFormAdd=true, showMenu=false)">Изменить данные</li>
                                </ul>
                            </ui-menu>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col_12">
                            <div class="wg-content-frame">
                                <ui-table>
                                    <template slot="body">
                                        <tr class="ui-table__tr">
                                            <td class="ui-table__td pg-account-data__td_left">Логин</td>
                                            <td class="ui-table__td pg-account-data__td_right">
                                                {{user.login}}
                                            </td>
                                        </tr>
                                        <tr class="ui-table__tr">
                                            <td class="ui-table__td pg-account-data__td_left">Имя</td>
                                            <td class="ui-table__td pg-account-data__td_right">
                                                {{user.name}}
                                            </td>
                                        </tr>
                                        <tr class="ui-table__tr">
                                            <td class="ui-table__td pg-account-data__td_left">Фамилия</td>
                                            <td class="ui-table__td pg-account-data__td_right">
                                                {{user.surname}}
                                            </td>
                                        </tr>
                                        <tr class="ui-table__tr">
                                            <td class="ui-table__td pg-account-data__td_left">Дата рождения</td>
                                            <td class="ui-table__td pg-account-data__td_right">
                                                {{user.birthdate}}
                                            </td>
                                        </tr>
                                        <tr class="ui-table__tr">
                                            <td class="ui-table__td pg-account-data__td_left">Место проживания</td>
                                            <td class="ui-table__td pg-account-data__td_right">
                                                {{city.name+" "+ region.name}}
                                            </td>
                                        </tr>

                                        <tr class="ui-table__tr">
                                            <td class="ui-table__td pg-account-data__td_left">Телефон</td>
                                            <td class="ui-table__td pg-account-data__td_right">
                                                {{user.phone}}
                                            </td>
                                        </tr>
                                        <tr class="ui-table__tr">
                                            <td class="ui-table__td pg-account-data__td_left">Email</td>
                                            <td class="ui-table__td pg-account-data__td_right">
                                                {{user.email}}
                                            </td>
                                        </tr>
                                    </template>
                                </ui-table>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col_12">

                            <ui-blind :show="showFormAdd" @onHide="showFormAdd=false" animate="bottom" style="background-color: rgba(255, 255, 255, 0);">
                                <div class="container">
                                    <div class="row">
                                        <div class="col_6 col_offset-3 col-tablet_8 col-tablet_offset-2 col-phone_6 col-phone_offset-0">
                                            <pg-account-data-form @onHide="showFormAdd=false">
                                            </pg-account-data-form>
                                        </div>
                                    </div>
                                </div>
                            </ui-blind>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </layout>
</template>

<script>
import dataForm from "./formData.vue";
export default {
  name: "pg-account-data",
  data() {
    return {
      showMenu: false,
      showFormAdd: true
    };
  },
  components: {
    "pg-account-data-form": dataForm
  },
  computed: {
    user() {
      if (this.$store.state.user.id != undefined) {
        return this.$store.state.user;
      }
      return undefined;
    },
    region() {
      return this.$store.getters["locations/getSubject"](this.city.subject_id);
    },
    city() {
      return this.$store.getters["locations/getSettlement"](
        this.user.settlement_id
      );
    }
  }
};
</script>

