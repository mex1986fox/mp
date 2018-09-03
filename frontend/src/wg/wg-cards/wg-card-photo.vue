<template>
	<div class="wg-card-photo">
		<div class="wg-card-photo__header">

			<div class="ui-avatar-block wg-card-photo__avatar-block">
				<div class="ui-avatar">
					<img src="/public/img/avatar.jpg"
					    alt="">
				</div>
				<div class="ui-link ui-avatar-block__link">
					Alisochka Frolova
				</div>
				<div class="ui-avatar-block__title">
					25/17/2018
				</div>

			</div>

			<button @click="showMenu=true"
			    class="ui-button ui-button_flat ui-button_circle ui-button_circle_mini wg-card-photo__header-button">
				<i class="fa fa-ellipsis-v"
				    aria-hidden="true"></i>
			</button>
			<ui-menu :show="showMenu"
			    @onHide="showMenu=false"
			    position="left-bottom">
				<ul class="wg-card-photo__menu">
					<li class="wg-card-photo__menu-li">Комментарии</li>
					<li class="wg-card-photo__menu-li">Пожаловаться</li>
				</ul>
			</ui-menu>

		</div>
		<a class="ui-link wg-card-photo__link"
		    href="http://google.com">
			Фотографии мастодонта Chevrolet Camaro
		</a>

		<wg-slider class="wg-card-photo__slider"
		    :slide='[
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852445.jpg"},
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852304.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852320.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852338.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852364.jpg"},
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852393.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852424.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852445.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852304.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852320.jpg" }
                        ]'
		    :select="numberPhoto"
		    @onSelect="isSelectPhoto"
		    @onZoom="isZoomPhoto">
		</wg-slider>
		<wg-slider-navig class="wg-card-photo__slider-navig"
		    :slide='[
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852445.jpg"},
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852304.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852320.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852338.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852364.jpg"},
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852393.jpg" , },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852424.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852445.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852304.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852320.jpg" }
                        ]'
		    :select="numberPhoto"
		    @onSelect="isSelectPhoto">
		</wg-slider-navig>

		<wg-slider-zoom v-if="showZoomSlider"
		    :slide='[
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852445.jpg"},
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852304.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852320.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852338.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852364.jpg"},
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852393.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852424.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852445.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852304.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen1200_305852320.jpg" }
                        ]'
		    :slideNavigation='[
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852445.jpg"},
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852304.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852320.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852338.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852364.jpg"},
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852393.jpg" , },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852424.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852445.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852304.jpg" },
                            { src: "https://s.auto.drom.ru/i24223/s/photos/30552/30551169/gen115_305852320.jpg" }
                        ]'
		    :select="numberZoomPhoto"
		    :show="showZoomSlider"
		    @onHide="showZoomSlider=false">
		</wg-slider-zoom>

		<div class="wg-card-photo__buttons">
			<button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
				<i class="fa fa-thumbs-o-up"
				    aria-hidden="true"></i>
			</button>
			<span class="wg-card-ad__counter">
				123 000
			</span>
			<button class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
				<i class="fa fa-thumbs-o-down"
				    aria-hidden="true"></i>
			</button>
			<span class="wg-card-ad__counter">
				9 990
			</span>
			<button @click="commentShow=true"
			    class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat">
				<i class="fa fa-comments-o"
				    aria-hidden="true"></i>
			</button>
			<span class="wg-card-ad__counter">
				296
			</span>
		</div>
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
  name: "wg-card-photo",
  data() {
    return {
      showMenu: false,
      descActive: false,
      numberPhoto: 1,
      numberZoomPhoto: 1,
      showZoomSlider: false,
      commentShow: false
    };
  },
  methods: {
    isDascActive() {
      this.descActive = !this.descActive;
    },
    isSelectPhoto(numberPhoto) {
      this.numberPhoto = numberPhoto;
    },
    isZoomPhoto(numberPhoto) {
      //   console.log(numberPhoto);
      this.showZoomSlider = true;
      this.numberZoomPhoto = numberPhoto;
    }
  }
};
</script>
