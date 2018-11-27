<template>
  <layout>
    <div class="container">
      <div class="row">
        <!-- левый блок -->
        <div class="col_3 col-tablet_4 col-phone_clean">
          <ui-fixed-block>
            <div class="row">
              <div class="col-12 col-nbook_clean col-desktop_clean">
                <div class="wg-content-frame wg-content-frame_left wg-content-frame__padding">
                  <div
                    @click="showFormPhotos=true"
                    class="ui-button ui-button_blue pg-ads__button-add"
                  >добавить фотографии</div>
                </div>
                <div class="wg-content-frame wg-content-frame_left wg-content-frame_no-border">
                  <div @click="showFilterPhotos=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-sliders"></i>
                    </div>Фильтр фотографий
                  </div>
                  <div @click="showMessenger=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-envelope"></i>
                    </div>Мессенджер
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_left">
                  <wg-frame-friends></wg-frame-friends>
                </div>
              </div>
            </div>
          </ui-fixed-block>
        </div>
        <!-- центральный блок -->
        <div class="col_6 col-tablet_8 col-phone_6">
          <div class="row" v-for=" key in 10" :key="key">
            <div class="col-12">
              <div class="wg-content-frame wg-content-frame_center">
                <wg-card-photo></wg-card-photo>
                <!-- <wg-card-photos :photo="JSON.parse(JSON.stringify(photo))"></wg-card-photos> -->
              </div>
            </div>
          </div>
        </div>
        <!-- правый блок -->
        <div class="col_3 col-phone_3 col-tablet_clean col-phone_clean">
          <ui-fixed-block>
            <div class="row">
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame__padding">
                  <div
                    @click="showFormPhotos=true"
                    class="ui-button ui-button_blue pg-ads__button-add"
                  >добавить фотографии</div>
                </div>
              </div>
              <div class="col-12">
                <div class="wg-content-frame wg-content-frame_right wg-content-frame_no-border">
                  <div @click="showFilterPhotos=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-sliders"></i>
                    </div>Фильтр фотографий
                  </div>
                  <div @click="showMessenger=true" class="ui-navigation__unit__button">
                    <div class="ui-navigation__unit__icon">
                      <i aria-hidden="true" class="fa fa-envelope"></i>
                    </div>Мессенджер
                  </div>
                </div>
              </div>
            </div>
          </ui-fixed-block>
        </div>
      </div>
    </div>
    <div class="row">
      <!-- Фильтр фотографий -->
      <div class="col_12">
        <ui-blind :show="showFilterPhotos" @onHide="showFilterPhotos=false" animate="right">
          <div class="container container_right">
            <div class="row">
              <div
                class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
              >
                <wg-filter-photos @onHide="showFilterPhotos=false"></wg-filter-photos>
              </div>
            </div>
          </div>
        </ui-blind>
      </div>
      <!-- форма размещения фотографий -->
      <div class="col_12">
        <wg-form-photos :show="showFormPhotos" @onHide="showFormPhotos=false"></wg-form-photos>
      </div>
      <!-- мессенджер -->
      <div class="col_12">
        <ui-blind @onHide="showMessenger=!showMessenger" :show="showMessenger" animate="opacity">
          <div class="container">
            <div class="row">
              <div
                class="col_8 col_offset-2 col-nbook_10 col-nbook_offset-1 col-tablet_12 col-tablet_offset-0 col-phone_6 col-phone_offset-0"
              >
                <wg-messanger @onHide="showMessenger=false"></wg-messanger>
              </div>
            </div>
          </div>
        </ui-blind>
      </div>
    </div>
    <div class="row">
      <div class="col_12 col-desktop_clean col-nbook_clean col-tablet_clean">
        <transition name="pg-ads__button-show-form-add">
          <div
            v-if="!showFormPhotos"
            @click="showFormPhotos=true"
            class="ui-button ui-button_circle pg-ads__button-show-form-add"
            :class="{'pg-ads__button-show-form-add_bottom': buttonShowFormPhotosBottom }"
          >
            <i class="fa fa-plus" aria-hidden="true"></i>
          </div>
        </transition>
        <ui-bar-bottom>
          <div @click="showFilterPhotos=true" class="ui-bar-bottom__tab">
            <i aria-hidden="true" class="fa fa-sliders"></i>
            <ui-click-feedback></ui-click-feedback>
          </div>
          <div @click="showMessenger=true" class="ui-bar-bottom__tab">
            <i class="fa fa-envelope" aria-hidden="true"></i>
            <ui-click-feedback></ui-click-feedback>
          </div>
          <div class="ui-bar-bottom__tab">
            <i class="fa fa-user-o" aria-hidden="true"></i>
            <ui-click-feedback></ui-click-feedback>
          </div>
          <div class="ui-bar-bottom__tab">
            <i aria-hidden="true" class="fa fa-sliders"></i>
            <ui-click-feedback></ui-click-feedback>
          </div>
        </ui-bar-bottom>
      </div>
    </div>
  </layout>
</template>

<script>
export default {
  name: "pg-photos",
  data() {
    return {
      photos: undefined,
      showFilterPhotos: false,
      showMessenger: false,
      showFormPhotos: true,
      buttonShowFormPhotosBottom: false
    };
  },
  computed: {},
  methods: {
      isShowFormPhotos(){
          
      }
  },
  mounted() {
    document.addEventListener("onTouchTop", () => {
      this.buttonShowFormPhotosBottom = false;
    });
    document.addEventListener("onTouchBottom", () => {
      this.buttonShowFormPhotosBottom = true;
    });
  }
};
</script>