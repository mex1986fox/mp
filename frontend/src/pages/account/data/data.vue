<template>
	<layout>
		<div class="container" v-if="user!=undefined">
			<div class="row">
				<div class="col_8 col_offset-2 col-phone_6 col-phone_offset-0">
					<div class="row">
						<div class="col_12">
							<div class="ui-avatar-block  pg-account-data__avatar-block">
								<ui-avatar class="pg-account-data__avatar" :lable="user.login">
									<img :src="user.avatar"
									     alt="">
								</ui-avatar>
									<span class="ui-avatar-block__link pg-account-data__avatar-linck">{{user.login}}</span>
									<span class="ui-avatar-block__title  pg-account-data__avatar-title">{{user.name+" "+user.surname}}</span>
							</div>
							<button @click="showMenu=true" class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini pg-account-data__avatar-button">
								<i class="fa fa-ellipsis-v" aria-hidden="true"></i>
							</button>
							<ui-menu :show="showMenu" @onHide="showMenu=false" position="left-bottom">
								<ul class="wg-card-ad__menu">
									<li class="wg-card-ad__menu-li" @click="isShowFormAvatar">Сменить аватар</li>
									<li class="wg-card-ad__menu-li" @click="isShowFormData">Изменить данные</li>
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
												{{(city!=undefined?city.name:'')+" "+ (region!=undefined?region.name:'Не указано')}}
											</td>
										</tr>

										<tr class="ui-table__tr">
											<td class="ui-table__td pg-account-data__td_left">Телефон</td>
											<td class="ui-table__td pg-account-data__td_right">
												{{user.phone?user.phone:"Не указано"}}
											</td>
										</tr>
										<tr class="ui-table__tr">
											<td class="ui-table__td pg-account-data__td_left">Email</td>
											<td class="ui-table__td pg-account-data__td_right">
												{{user.email?user.email:"Не указано"}}
											</td>
										</tr>
									</template>
								</ui-table>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col_12">

							<ui-blind :show="showFormData" :centering="true" selector=".wg-form-add" @onHide="showFormData=false" animate="bottom" style="background-color: rgba(255, 255, 255, 0);">
								<div class="container">
									<div class="row">
										<div class="col_6 col_offset-3 col-tablet_8 col-tablet_offset-2 col-phone_6 col-phone_offset-0">
											<pg-account-data-form @onHide="showFormData=false">
											</pg-account-data-form>
										</div>
									</div>
								</div>
							</ui-blind>
						</div>
					</div>
					<div class="row">
						<div class="col_12">

							<ui-blind :show="showFormAvatar" @onHide="showFormAvatar=false" animate="bottom" :centering="true" selector=".wg-form-add" style="background-color: rgba(255, 255, 255, 0);">
								<div class="container">
									<div class="row">
										<div class="col_6 col_offset-3 col-tablet_8 col-tablet_offset-2 col-phone_6 col-phone_offset-0">
											<pg-account-avatar-form @onHide="showFormAvatar=false">
											</pg-account-avatar-form>
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
import avatarForm from "./formAvatar.vue";
export default {
  name: "pg-account-data",
  data() {
    return {
      showMenu: false,
      showFormData: false,
      showFormAvatar: false
    };
  },
  components: {
    "pg-account-data-form": dataForm,
    "pg-account-avatar-form": avatarForm
  },
  methods: {
    isShowFormAvatar() {
      this.showMenu = false;
      this.showFormAvatar = true;
    },
    isShowFormData() {
      this.showMenu = false;
      this.showFormData = true;
    }
  },
  computed: {
    user() {
      if (this.$store.state.user.id != undefined) {
        return this.$store.state.user;
      }
      return undefined;
    },
    region() {
      if (this.city != undefined) {
        return this.$store.getters["locations/getSubject"](
          this.city.subject_id
        );
      }
      return undefined;
    },
    city() {
      if (this.user.settlement_id != undefined) {
        return this.$store.getters["locations/getSettlement"](
          this.user.settlement_id
        );
      }
      return undefined;
    }
  }
};
</script>

