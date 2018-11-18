<template>
	<div style="height:100%">
		<div class="ui-bar">
			<div class="ui-bar__content">
				<div class="container">
					<div class="row">
						<div class="col_12">
							<button @click="showNavigation=true"
							        class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat ui-navigation__burger">
								<i class="fa fa-bars"
								   aria-hidden="true"></i>
							</button>
							<div v-if="user!=undefined"
							     class="ui-bar__user">
								<div @click="logout"
								     class="ui-button ui-button_circle ui-button_flat ui-button_circle_mini ui-bar__user-exit">
									<i class="fa fa-sign-out"
									   aria-hidden="true"></i>
								</div>
								<ui-avatar class="ui-bar__user-avatar"
								           :lable="user.login">
									<img :src="user.avatar"
									     alt="">
								</ui-avatar>
							</div>
							<div v-if="user==undefined"
							     class="ui-bar__user">
								<router-link to="/authorization"
								             class="ui-button ui-button_circle ui-button_flat ui-button_circle_mini ui-bar__user-exit">
									<i class="fa fa-sign-in"
									   aria-hidden="true"></i>
								</router-link>
							</div>
							<div v-if="path=='/ads'"
							     class="ui-bar__user">
								<div @click="isShowFilterAdd"
								     class="ui-button ui-button_circle ui-button_flat ui-button_circle_mini ui-bar__user-exit">
									<i class="fa fa-sliders"
									   aria-hidden="true"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col_12">
					<ui-navigation :show="showNavigation"
					               @onHide="showNavigation=false">
						<div class="ui-navigation__header">
							<router-link to="/">
								<img class="ui-navigation__header__label"
								     src="/public/img/label.png"
								     alt="">
							</router-link>
							<div class="ui-navigation__header__burger">
								<button @click="showNavigation=false"
								        class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat ui-navigation__burger">
									<i aria-hidden="true"
									   class="fa fa-angle-left"></i>
								</button>
							</div>
						</div>
						<div class="ui-navigation__unit">
							<ui-navigation-list :show="true">
								<div slot="header">
									<div class="ui-navigation__unit__header">Кабинет</div>
								</div>
								<div slot="content">
									<router-link to="/authorization"
									             class="ui-navigation__unit__button">
										<div class="ui-navigation__unit__icon">
											<i class="fa fa-th"
											   aria-hidden="true"></i>
										</div>Вход
									</router-link>
									<router-link to="/account/data"
									             class="ui-navigation__unit__button">
										<div class="ui-navigation__unit__icon">
											<i class="fa fa-th"
											   aria-hidden="true"></i>
										</div>Мои данные
									</router-link>
									<router-link to="/account/ads"
									             class="ui-navigation__unit__button">
										<div class="ui-navigation__unit__icon">
											<i class="fa fa-th"
											   aria-hidden="true"></i>
										</div>Мои объявления
									</router-link>
								</div>
							</ui-navigation-list>
						</div>
						<div class="ui-navigation__unit">
							<ui-navigation-list :show="true">
								<div slot="header">
									<div class="ui-navigation__unit__header">Лента</div>
								</div>
								<div slot="content">
									<router-link to="/ads"
									             class="ui-navigation__unit__button">
										<div class="ui-navigation__unit__icon">
											<i class="fa fa-th"
											   aria-hidden="true"></i>
										</div>Объявления
									</router-link>
								</div>
							</ui-navigation-list>
						</div>
					</ui-navigation>
				</div>
			</div>
		</div>
		<slot></slot>
		<!-- Фильтр сообщений -->
		<div class="col_12">
			<ui-blind :show="showFilterAdd"
			          @onHide="showFilterAdd=false"
			          animate="right">
				<div class="container container_right">
					<div class="row">
						<div class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0">
							<wg-filter-add @onHide="showFilterAdd=false"></wg-filter-add>
						</div>
					</div>
				</div>
			</ui-blind>
		</div>
	</div>
</template>
<script>
export default {
  name: "layout",
  data() {
    return {
      showNavigation: false,
      showFilterAdd: false
    };
  },
  computed: {
    user() {
      if (this.$store.state.user.id != undefined) {
        return this.$store.state.user;
      }
      return undefined;
    },
    path() {
      return this.$router.history.current.path;
    }
  },
  methods: {
    isShowFilterAdd() {
      this.showFilterAdd = true;
    },
    logout() {
      this.$store.dispatch("user/logout");
    }
  }
};
</script>
