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
							<div class="col_12">
								<wg-select-location caption="Страна, регион, город" :selectedSettlement="user.settlement_id">

								</wg-select-location>
							</div>
						</div>
						<!-- <div class="row">
							<div class="col_12">
								<wg-multiple-location caption="Страна, регион, город" :pSettlement="[user.settlement_id]">
								</wg-multiple-location>
							</div>
						</div> -->
						<div class="wg-form-add__hr">
							Личные данные
						</div>
						<div class="row">
							<div class="col_5 col-phone_6">
								<ui-text name="login" caption="Логин" :value="user.login">
								</ui-text>
							</div>
						</div>
						<div class="row">
							<div class="col_5 col-phone_6">
								<ui-text name="name" caption="Имя" :value="user.name">
								</ui-text>
							</div>
							<div class="col_6 col_offset-1 col-phone_6 col-phone_offset-0">
								<ui-text name="surname" caption="Фамилия" :value="user.surname">
								</ui-text>
							</div>
						</div>
						<div class="row">
							<div class="col_3 col-phone_6">
								<ui-datepicker name="birthdate" caption="Дата рождения" :value="user.birthdate">
								</ui-datepicker>
							</div>
						</div>
						<div class="wg-form-add__hr">
							Связь
						</div>
						<div class="row">
							<div class="col_4 col-phone_6">
								<ui-phone name="phone" :value="user.phone" caption="Телефон">
								</ui-phone>
							</div>
							<div class="col_6 col_offset-2 col-phone_6 col-phone_offset-0">
								<ui-text name="email" :value="user.email" caption="Email">
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
      showSnackbar: false,
      descSnackbar: ""
    };
  },
  methods: {
    isClose() {
      this.$emit("onHide");
    },
    update(event) {
      let body = new FormData(event.target);
      this.$http.post("/api/update/users", body).then(
        response => {
          this.$store.commit("user/update", response.body.user);
          this.isClose();
        },
        error => {
          this.descSnackbar = error.body.exceptions.massege;
          this.showSnackbar = true;
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
    }
  }
};
</script>
