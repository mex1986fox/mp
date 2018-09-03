<template>
	<div class="wg-card-ad">
		<div class="wg-card-ad__header">

			<div class="ui-avatar-block wg-card-ad__avatar-block">
				<div class="ui-avatar">
					<img :src="dObj.user.avatar"
					    alt="">
				</div>
				<a class="ui-link ui-avatar-block__link">
					{{dObj.user.name+" "+dObj.user.surname}}
				</a>
				<div class="ui-avatar-block__title">
					{{dObj.date}}
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
		    :to="dObj.link">
			{{dObj.brand+" "+dObj.model+" "+dObj.year+"г. "+dObj.city}}
		</router-link>
		<div class="row">
			<div class="col_6 col-phone_6">
				<wg-slider class="wg-card-ad__slider"
				    :slide="dObj.slide"
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
						<span class="wg-card-ad__info-title">Двигатель</span>
						<span class="wg-card-ad__info-value">{{dObj.fuel +"/"+ dObj.volume}}
						</span>
					</span>
					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Руль</span>
						<span class="wg-card-ad__info-value">{{dObj.helm}}</span>
					</span>
					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Пробег</span>
						<span class="wg-card-ad__info-value">{{dObj. mileage}} км.</span>
					</span>
					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Коробка</span>
						<span class="wg-card-ad__info-value">{{dObj.transmission}}</span>
					</span>
					<span class="wg-card-ad__info-param">
						<span class="wg-card-ad__info-title">Привод</span>
						<span class="wg-card-ad__info-value">{{dObj.drive}}</span>
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
		<wg-slider-zoom 
			v-if="showZoomSlider"
			:slide="dObj.slide"
		    :slideNavigation="dObj.slide_navigation"
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
      dObj: JSON.parse(JSON.stringify(this.object))
    };
  },
  props: {
    object: {
      type: Object,
      default: () => {}
    }
  },
  methods: {
    isDascActive() {
      this.descActive = !this.descActive;
    }
  }
};
</script>
