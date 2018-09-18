<template>
    <div class="wg-form-add">
        <div class="row">
            <div class="col-12">
                <div class="wg-form-add__bar">
                    <div class="ui-header ui-header_2 wg-form-add__header">
                        <span>Редактирование личных данных</span>
                    </div>
                    <button class="ui-button ui-button_circle ui-button_flat wg-form-add__close" @click="isClose">
                        <i class="fa fa-angle-down"></i>
                    </button>
                </div>

                <div class="wg-form-add__content">
                    <form @submit.prevent="update">
                        <div class="wg-form-add__hr">
                            <!-- <i class="fa fa-map-marker" aria-hidden="true"></i> -->
                            Местоположение
                        </div>
                        <div class="row">
                            <div class="col_5">
                                <ui-select name="subject" caption="Субъект" :menu='menuSubjects' @onSelect='isSelectedRegion'>
                                </ui-select>
                            </div>
                            <div class="col_5 col_offset-2">
                                <ui-select name="settlement" caption="Город" :menu='menuSettlements' :disabled='(menuSettlements.length==0?true:false)'>
                                </ui-select>
                            </div>
                        </div>

                        <div class="wg-form-add__hr">
                            Личные данные
                        </div>
                        <div class="row">
                            <div class="col_5">
                                <ui-text name="login" caption="Логин" :value="user.login">
                                </ui-text>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col_5">
                                <ui-text name="name" caption="Имя" :value="user.name">
                                </ui-text>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col_5">
                                <ui-text name="surname" caption="Фамилия" :value="user.surname">
                                </ui-text>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col_3">
                                <ui-datepicker name="birthdate" caption="Дата рождения" :value="user.birthdate">
                                </ui-datepicker>
                            </div>
                        </div>
                        <div class="wg-form-add__hr">
                            Связь
                        </div>
                        <div class="row">
                            <div class="col_4">
                                <ui-phone name="phone" caption="Телефон">
                                </ui-phone>
                            </div>
                            <div class="col_6 col_offset-2">
                                <ui-text name="email" caption="Email">
                                </ui-text>
                            </div>
                        </div>
                        <div class="wg-form-add__buttons">
                            <button class="ui-button ui-button_blue" type="submit">
                                Изменить
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col_12">
                <ui-snackbar :show="showSnackbar" @onHide="showSnackbar=false" :time="20000">
                    {{descSnackbar}}
                </ui-snackbar>
            </div>
        </div>
    </div>

</template>

<script>
export default {
  name: "pg-account-data-form",
  data() {
    return {
      selectedRegion: undefined
    };
  },
  methods: {
    isClose() {
      this.$emit("onHide");
    },
    isSelectedRegion(region) {
      this.selectedRegion = region[0].value;
    },
    update(event) {
      let body = new FormData(event.target);
      body.set("add_id", this.add_id);
      this.$http.post("/api/update/ads", body).then(
        response => {
          this.$store.commit("user/update", response.body.user);
        },
        error => {
          console.log(error);
        }
      );
    },
    update(event) {
      let form = event.target;
      let body = new FormData(form);

      this.$http.post("/api/update/users", body).then(
        response => {
          if (response.body.recovery_key != undefined) {
            this.recovery_key = response.body.recovery_key;
            this.showRecoveryCard = true;
            this.showRegistrationCard = false;
          }
        },
        error => {
          if (error.body.exceptions != undefined) {
            this.registrationEcept = error.body.exceptions;
            this.showSnackbar = true;
            this.descSnackbar = this.registrationEcept.massege;
            this.$refs.captcha.$emit("onRefresh");
          }
        }
      );
    }
  },
  computed: {
    user() {
      if (this.$store.state.user.id != undefined) {
        return this.$store.state.user;
      }
      return undefined;
    },
    menuSubjects() {
      return this.$store.getters["locations/getMenuSubjects"](1, [2]);
    },
    menuSettlements() {
      if (this.selectedRegion != undefined) {
        return this.$store.getters["form_add/getSettlements"](
          this.selectedRegion
        );
      } else {
        return [];
      }
    }
  }
};
</script>
