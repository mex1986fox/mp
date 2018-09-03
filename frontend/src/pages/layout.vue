<template>
	<div style="height:100%">
		<div class="ui-app-bar">
			<div class="ui-app-bar__content">
				<div class="container">
					<div class="row">
						<div class="col_12">
							<button @click="showNavigation=true"
							        class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat
                                ui-navigation__burger ">
								<i class="fa fa-bars"
								   aria-hidden="true"></i>
							</button>
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
							<div class="ui-navigation__header__burger ">
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
									<div class="ui-navigation__unit__header">
										Cтраници
									</div>
								</div>
								<div slot="content">
									<router-link to="/authorization"
									             class="ui-navigation__unit__button">
										<div class="ui-navigation__unit__icon">
											<i class="fa fa-th"
											   aria-hidden="true"></i>
										</div>
										Вход
									</router-link>
									<router-link to="/ads"
									             class="ui-navigation__unit__button">
										<div class="ui-navigation__unit__icon">
											<i class="fa fa-th"
											   aria-hidden="true"></i>
										</div>
										Объявления
									</router-link>
								</div>
							</ui-navigation-list>
						</div>

					</ui-navigation>
				</div>
			</div>
		</div>
		<slot>

		</slot>
	</div>
</template>
<script>
export default {
  name: "layout",
  data() {
    return { showNavigation: false };
  }
};
</script>
