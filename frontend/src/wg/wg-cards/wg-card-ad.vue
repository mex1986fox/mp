<template>
	<div class="wg-card-ad">
		<div class="wg-card-ad__header">

			<div v-if="dObj.user"
			     class="ui-avatar-block wg-card-ad__avatar-block">
				<ui-avatar :lable="dObj.user.login">
					<img :src="dObj.user.avatar"
					     alt="">
				</ui-avatar>
				<a class="ui-link ui-avatar-block__link">
					{{dObj.user.name+" "+dObj.user.surname}}
				</a>
				<div class="ui-avatar-block__title">
					{{parseDate(dObj.date_create)}}
				</div>

			</div>

			<button @click="showMenu=true"
			        class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-card-ad__header-button">
				<i class="fa fa-ellipsis-v"
				   aria-hidden="true"></i>
			</button>
			<ui-menu :show="showMenu"
			         @onHide="showMenu=false"
			         position="left-bottom">

				<ul v-if="user_id!=undefined && dObj.user!=undefined && user_id==dObj.user.id"
				    class="wg-card-ad__menu">
					<li class="wg-card-ad__menu-li">
						Редактировать
					</li>
					<li class="wg-card-ad__menu-li">
						Отметить проданным
					</li>
					<li class="wg-card-ad__menu-li">
						Поднять
					</li>
				</ul>
				<ul v-else
				    class="wg-card-ad__menu">
					<li @click="(showMenu=false, showContacts=true)"
					    class="wg-card-ad__menu-li">
						Показать контакты
					</li>
					<li @click="(showMenu=false, showMessenger=true)"
					    class="wg-card-ad__menu-li">
						Написать сообщение
					</li>
				</ul>
			</ui-menu>

		</div>
		<router-link class="ui-link wg-card-ad__link"
		             to="/googlre">
			{{brand.name+" "+model.name+" "+dObj.year+"г. "+city.name}}
		</router-link>
		<div class="row">
			<div class="col_6 col-phone_6">
				<wg-slider v-if="dObj.slide!=undefined"
				           class="wg-card-ad__slider"
				           :slide='dObj.slide'
				           :select="1"
				           @onZoom="showZoomSlider=true">
				</wg-slider>
			</div>
			<div class="col_6 col-phone_6">
				<div class="wg-card-ad__info">
					<div class="wg-card-ad__info-header">
						{{mascNumber(dObj.price_corret)}} руб.
					</div>
					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Пробег</span>
						<span class="wg-card-ad__info-value">{{mascNumber(dObj.mileage)}} км.</span>
					</span>
					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Двигатель</span>
						<span class="wg-card-ad__info-value">
							{{(fuel!=undefined?fuel.name:"--") + (dObj.engin_volume!=undefined?" "+dObj.engin_volume+" л.":"") +(dObj.engin_power!=undefined?" "+dObj.engin_power+" л.c.":"")}}
						</span>
					</span>
					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Руль</span>
						<span class="wg-card-ad__info-value">{{wheel !=undefined?wheel:"--"}}</span>
					</span>

					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Коробка</span>
						<span class="wg-card-ad__info-value">{{transmission!=undefined?transmission.name:"--"}}</span>
					</span>
					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Привод</span>
						<span class="wg-card-ad__info-value">{{drive!=undefined?drive.name:"--"}}</span>
					</span>
				</div>
			</div>

		</div>
		<transition name="wg-card-ad__description">
			<span v-show="descActive"
			      class="ui-description ui-description_mini wg-card-ad__description">
				{{dObj.description}}
			</span>
		</transition>

		<div class="wg-card-ad__buttons">
			<button @click="createLike('1')"
			        class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
				<i class="fa fa-thumbs-o-up"
				   aria-hidden="true"></i>

			</button>
			<span class="wg-card-ad__counter">
				{{dObj.likes!=undefined?dObj.likes:"0"}}
			</span>

			<button @click="createLike('-1')"
			        class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
				<i class="fa fa-thumbs-o-down"
				   aria-hidden="true"></i>
			</button>
			<span class="wg-card-ad__counter">
				{{dObj.dislikes!=undefined?dObj.dislikes:"0"}}
			</span>
			<button @click="commentShow=true"
			        class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
				<i class="fa fa-comments-o"
				   aria-hidden="true"></i>
			</button>
			<span class="wg-card-ad__counter">
				{{dObj.commentsLength!=undefined?dObj.commentsLength:"0"}}
			</span>
			<button v-if="dObj.description"
			        class="ui-button ui-button_circle ui-button_flat ui-button_circle_mini wg-card-ad__angel"
			        :class="{'wg-card-ad__angel_transit':descActive}"
			        @click="isDascActive">
				<i class="fa fa-angle-down"
				   aria-hidden="true"></i>
			</button>
		</div>
		<wg-slider-zoom v-if="showZoomSlider&&dObj.slide!=undefined"
		                :slide='dObj.slide'
		                :slideNavigation="dObj.slide"
		                :select="1"
		                :show="showZoomSlider"
		                @onHide="showZoomSlider=false">
		</wg-slider-zoom>
		<ui-blind ref="blind"
		          :show="commentShow"
		          @onHide="commentShow=false"
		          :centering="true"
		          animate="opacity">
			<div class="container">

				<div class="row">
					<div class="col_8 col_offset-2 col-tablet_10 col-tablet_offset-1 col-phone_6 col-phone_offset-0">
						<wg-comments :service_id="dObj.id"
						             :service_type="'ads'"
						             @onHide="commentShow=false">

						</wg-comments>
					</div>
				</div>

			</div>
		</ui-blind>

		<ui-blind @onHide="showContacts=!showContacts"
		          :show="showContacts"
		          animate="opacity"
		          centering
		          class="pg-authorization__blind">
			<div class="container">
				<div class="row">
					<div class="col_6 col_offset-3 col-phone_6 col-phone_offset-0">
						<div class="row">
							<div class="col_12">

								<div class="ui-modal-window">
									<div class="ui-modal-window__header ">
										<button @click="showContacts=false"
										        class="ui-button ui-button_circle ui-button_circle_mini 
                                       ui-button_flat ui-modal-window__header__button">
											<i class="fa fa-times"
											   aria-hidden="true"></i>
										</button>
										Контакты продавца
									</div>
									<div class="ui-modal-window__content">
										<span>Телефон:</span>
										{{dObj.user!=undefined?dObj.user.phone:""}}
										<br /><br />
										<span>Email:</span>
										{{dObj.user!=undefined?(dObj.user.email!=null?dObj.user.email:" не указан"):" не указан"}}
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</ui-blind>
		<ui-blind v-if="dObj.user!=undefined"
		          @onHide="showMessenger=!showMessenger"
		          :show="showMessenger"
		          animate="opacity">
			<div class="container">
				<div class="row">
					<div class="col_8 col_offset-2 col-nbook_10 col-nbook_offset-1 col-tablet_10 col-tablet_offset-1 col-phone_6 col-phone_offset-0">
						<wg-messanger :apponent="dObj.user.id"
						              @onHide="showMessenger=false">

						</wg-messanger>
					</div>
				</div>
			</div>
		</ui-blind>
	</div>
</template>
<script>
export default {
  name: "wg-card-ad",
  data() {
    return {
      user_id: this.$cookie.get("user_id"),
      showMenu: false,
      showContacts: false,
      showMessenger: false,
      descActive: false,
      showZoomSlider: false,
      commentShow: false,
      dObj: this.object
    };
  },
  props: {
    object: {
      type: Object,
      default: () => {}
    }
  },
  watch: {
    object(newQ) {
      this.dObj = newQ;
    }
  },
  computed: {
    city() {
      return this.$store.getters["locations/getSettlement"](
        this.dObj.settlements_id
      );
    },
    brand() {
      return this.$store.getters["transports/getBrand"](this.model.brand_id);
    },
    model() {
      return this.$store.getters["transports/getModel"](this.dObj.model_id);
    },
    fuel() {
      return this.$store.getters["transports/getFuel"](this.dObj.fuel_id);
    },
    wheel() {
      if (this.dObj.wheel != undefined) {
        return this.dObj.wheel == "l" ? "левый" : "правый";
      }
      return undefined;
    },
    transmission() {
      return this.$store.getters["transports/getTransmission"](
        this.dObj.transmission_id
      );
    },
    drive() {
      return this.$store.getters["transports/getDrive"](this.dObj.drive_id);
    }
  },
  methods: {
    isDascActive() {
      this.descActive = !this.descActive;
    },
    createLike(like) {
      let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        user_id: this.$cookie.get("user_id"),
        session_id: this.$cookie.get("PHPSESSID"),
        ad_id: this.dObj.id,
        like: like
      };
      this.$http
        .post(this.$hosts.likes + "/api/create/ads", params, headers)
        .then(
          response => {
            console.log(response);
          },
          error => {}
        );
    },
    updateUsers() {
      let users_id = [];
      this.ads.forEach(element => {
        users_id.push(element.user_id);
      });
      let params = {
        users_id: users_id.filter((e, i, a) => a.indexOf(e) == i)
      };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http.post("/api/show/users", params, headers).then(
        response => {
          let users = response.body.users;
          users.forEach(user => {
            this.ads = this.ads.map((ad, key, arr) => {
              if (ad.user_id == user.id) {
                arr[key].user = user;
              }
              return ad;
            });
          });

          // this.updatePhotoAvatars();
        },
        error => {}
      );
    },
    addZero(i) {
      if (i < 10) {
        i = "0" + i;
      }
      return i;
    },
    parseDate(date) {
      let newDate = new Date(date);

      return (
        newDate.getFullYear() +
        "-" +
        newDate.getMonth() +
        "-" +
        newDate.getDate() +
        " " +
        this.addZero(newDate.getHours()) +
        ":" +
        this.addZero(newDate.getMinutes())
      );
    },
    mascNumber(val) {
      let newQ = val.replace(/[^0-9]/gim, "");
      if (newQ[0] == 0) {
        newQ = newQ.substr(1);
      }
      if (newQ.length > 4) {
        let spl = newQ.split("");
        spl.splice(-3, 0, " ");
        newQ = spl.join("");
      }
      if (newQ.length > 7) {
        let spl = newQ.split("");
        spl.splice(-7, 0, " ");
        newQ = spl.join("");
      }
      return newQ;
    }
  }
};
</script>
