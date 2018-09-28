<template>
	<div class="wg-card-ad">
		<div class="wg-card-ad__header">

			<div v-if="dObj.user"
			     class="ui-avatar-block wg-card-ad__avatar-block">
				<ui-avatar :lable="dObj.user.login">
					<img  :src="dObj.user.avatar"
					    alt="">
				</ui-avatar>
					<a class="ui-link ui-avatar-block__link">
						{{dObj.user.name+" "+dObj.user.surname}}
					</a>
					<div class="ui-avatar-block__title">
						Дата создания
						<!-- {{dObj.date}} -->
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
					<ul class="wg-card-ad__menu">
						<li class="wg-card-ad__menu-li">Комментарии</li>
						<li class="wg-card-ad__menu-li">Пожаловаться</li>
						<li class="wg-card-ad__menu-li">Авто продан</li>
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
							{{dObj.price}} руб.
						</div>
						<span class="wg-card-ad__info-param">
							<span class="wg-card-ad__info-title">Пробег</span>
							<span class="wg-card-ad__info-value">{{dObj.mileage}} км.</span>
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
				<button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
					<i class="fa fa-thumbs-o-up"
					   aria-hidden="true"></i>

				</button>
				<span class="wg-card-ad__counter">
					123
				</span>

				<button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
					<i class="fa fa-thumbs-o-down"
					   aria-hidden="true"></i>
				</button>
				<span class="wg-card-ad__counter">
					12
				</span>
				<button @click="commentShow=true"
				        class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
					<i class="fa fa-comments-o"
					   aria-hidden="true"></i>
				</button>
				<span class="wg-card-ad__counter">
					12 300
				</span>
				<button class="ui-button ui-button_circle ui-button_flat ui-button_circle_mini wg-card-ad__angel"
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
						<div class="col_8 col_offset-2">
							<button @click="commentShow=false"
							        class="ui-button ui-button_circle ui-button_circle_big ui-button_flat wg-card-ad__comments-close">
								<i aria-hidden="true"
								   class="fa fa-times"></i>
							</button>
							<wg-comments>

							</wg-comments>
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
      showMenu: false,
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
    }
  }
};
</script>
