<template>
	<layout>
		<div class="pg-authorization__fon">
		</div>
		<div class="container">
			<div class="row">
				<div class="col_7 col-phone_6">
					<img class="pg-authorization__logo" src="/public/img/label.png" alt="" srcset="">
					<div class="pg-authorization__remark">
						<span class="pg-authorization__remark-header">
							Социальная сеть для автомобилистов
						</span>
						<br/> Мы нацелены на объединение автомобилистов, автолюбителей, автоманьяков и всех кто хоть как-то связан с автомобилями.
					</div>
				</div>
				<div class="col_5 col-phone_6">
					<form @submit.prevent="authorization">
						<div class="pg-authorization__card" v-if="user==undefined">
							<div class="ui-header_1 pg-authorization__header">Вход на Drovito.ru
							</div>
							<ui-text name="login" :caption="'Ваш логин'" :help="authorizationEcept.login">
							</ui-text>
							<ui-password name="password" :caption="'Ваш пароль'" :help="authorizationEcept.password">
							</ui-password>
							<div class="pg-authorization__padding" />
							<div class="pg-authorization__buttons">
								<button type="submit" class="ui-button ">Войти</button>
								<div class="ui-button ui-button_red" @click="showRegistrationCard=true">Регистрация</div>
							</div>
							<hr class="pg-authorization__hr" />
							<span style="font-size: 12px; float: left; margin-bottom:10px;">Если вы забыли свой пароль, попробуйте его восстановить!</span><br/><br/>
							<a style="font-size: 12px; float: left; width: 100%;" class="ui-link" href="http://www.google.com">Восстановить пароль</a>
						</div>
					</form>
					<div class="pg-authorization__card" v-if="user!=undefined">
						<div class="ui-header_1 pg-authorization__header">
							Вы авторизованны как:
						</div>
						<div class="ui-avatar-block">
							<div class="ui-avatar"><img :src="user.avatar" alt=""></div>
							<a class="ui-link ui-avatar-block__link">
								{{user.login}}
							</a>
							<div class="ui-avatar-block__title">
								{{user.name+" "+user.surname}}
							</div>
						</div>
						<div class="pg-authorization__buttons">
							<button @click="logout" class="ui-button ui-button_blue">Выйти</button>
						</div>

						<br>

					</div>

				</div>
			</div>
		</div>
		<ui-blind @onHide="showRegistrationCard=!showRegistrationCard" :show="showRegistrationCard" animate="right" class="pg-authorization__blind">
			<div class="container">
				<form @submit="registered" action="#">
					<div class="row">
						<div class="col_5 col_offset-7 col-phone_6 col-phone_offset-0">
							<div class="pg-authorization__card-registration">
								<div class="row">
									<div class="col_12">
										<span class="ui-header_2">
											Первый раз на Drovito?
										</span>
										<br/>
										<p class="ui-description">
											Здесь Вам рады. Регистрируйтесь!
										</p>
									</div>
									<div class="col_12">
										<span class="pg-authorization__hr">
											<div class="ui-header_4">1. Личные данные
											</div>
										</span>
									</div>
									<div class="col_5 col-phone_6">
										<ui-text value="" caption="Имя" name="name" :help="registrationEcept.name">
										</ui-text>
									</div>
									<div class="col_5 col_offset-2 col-phone_6 col-phone_offset-0">
										<ui-text value="" caption="Фамилия" name="surname" :help="registrationEcept.surname">
										</ui-text>
									</div>
									<div class="col_5">
										<ui-datepicker :disabled="false" name="birthdate" caption="Дата рождения" :help="registrationEcept.birthdate">
										</ui-datepicker>
									</div>
									<div class="col_12">
										<span class="pg-authorization__hr">
											<div class="ui-header_4">2. Безопасность
											</div>
										</span>
									</div>

									<div class="col_5 col-phone_6">
										<ui-text value="" caption="Логин" name="login" :help="registrationEcept.login">
										</ui-text>
									</div>
									<div class="col_5 col_offset-2 col-phone_6 col-phone_offset-0">
										<ui-password caption="Пароль" name="password" :help="registrationEcept.password">
										</ui-password>
									</div>

									<div class="col_12">
										<span class="pg-authorization__hr">
											<div class="ui-header_4">3. Верификация
											</div>
										</span>
									</div>

									<div class="col_5 col-phone_6">
										<wg-captcha ref="captcha">
										</wg-captcha>
									</div>

									<div class="col_5 col_offset-2 col-phone_6 col-phone_offset-0">
										<ui-text value="" caption="Введите символы" name="captcha" :help="registrationEcept.captcha">
										</ui-text>
									</div>

									<div class="col_12">
										<div class="pg-authorization__buttons">
											<button class="ui-button ui-button_blue" type="submit">готово</button>
											<div class="ui-button ui-button_flat" @click="showRegistrationCard=!showRegistrationCard">Отмена</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>

			</div>
		</ui-blind>
		<ui-blind @onHide="showRecoveryCard=!showRecoveryCard" :show="showRecoveryCard" animate="opacity" centering class="pg-authorization__blind">
			<div class="container">
				<div class="row">
					<div class="col_6 col_offset-3 col-phone_6 col-phone_offset-0">
						<div class="row">
							<div class="col_12">

								<div class="ui-modal-window">
									<div class="ui-modal-window__header ">
										<button @click="showRecoveryCard=false" class="ui-button ui-button_circle ui-button_circle_mini 
                                       ui-button_flat ui-modal-window__header__button">
											<i class="fa fa-times" aria-hidden="true"></i>
										</button>
										Код восстановления
									</div>
									<div class="ui-modal-window__content">
										<span class="ui-header ui-header_1">
											{{recovery_key}}
										</span>
										<br/>
										<span class="ui-description ui-description_mini">
											Обязательно сохраните этот код он вам понадобится в случае восстановления пароля.
										</span>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</ui-blind>
		<div class="container">
			<div class="row">
				<div class="col_12">
					<ui-snackbar :show="showSnackbar" @onHide="showSnackbar=false" :time="20000">
						{{descSnackbar}}
					</ui-snackbar>
				</div>

			</div>
		</div>
	</layout>
</template>

<script>
export default {
  name: "pg-authorization",
  data() {
    return {
      showRegistrationCard: false,
      showRecoveryCard: false,
      showSnackbar: false,
      descSnackbar: "",
      recovery_key: undefined,
      registrationEcept: {},
      authorizationEcept: {}
    };
  },
  computed: {
    user() {
      if (this.$store.state.user.id != undefined) {
        return this.$store.state.user;
      }
      return undefined;
    }
  },
  methods: {
    authorization(event) {
      this.authorizationEcept = {};
      let body = new FormData(event.target);
      this.$http.post("/api/authorization/users", body).then(
        response => {
          this.$store.dispatch("user/authentication");
        },
        error => {
          if (error.body.exceptions != undefined) {
            this.authorizationEcept = error.body.exceptions;
            this.showSnackbar = true;
            this.descSnackbar = this.authorizationEcept.massege;
          }
        }
      );
    },
    logout() {
      this.$store.dispatch("user/logout");
    },
    registered(event) {
      this.registrationEcept = {};
      event.preventDefault();
      let body = {};
      for (let elForm of event.target) {
        if (elForm.name != "") {
          body[elForm.name] = elForm.value;
        }
      }
      this.$http.post("/api/create/users", body).then(
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
  }
};
</script>

