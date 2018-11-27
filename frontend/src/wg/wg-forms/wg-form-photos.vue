<template>
  <ui-blind :show="showFormPhotos" @onHide="showFormPhotos=false" animate="right">
    <div class="container container_right">
      <div class="row">
        <div
          class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
        >
          <div class="wg-form-add" :style="{'min-height': windowHeight+'px'} ">
            <div class="row">
              <div class="col-12">
                <div class="wg-form-add__bar">
                  <div class="ui-header ui-header_2 wg-form-add__header">
                    <span>Форма подачи фотографий</span>
                  </div>
                  <button
                    class="ui-button ui-button_circle ui-button_flat wg-form-add__close"
                    @click="isClose"
                  >
                    <i class="fa fa-angle-right"></i>
                  </button>
                  <ui-tabs class="wg-form-add__tabs">
                    <ui-tabs-tab id="basick" :checked="tabs=='basick'" @onFocus="isTabs">Основное</ui-tabs-tab>
                    <ui-tabs-tab id="photo" :checked="tabs=='photo'" @onFocus="isTabs">Фотографии</ui-tabs-tab>
                  </ui-tabs>
                </div>
                <div class="wg-form-add__content" v-show="tabs=='basick'">
                  <form id="formCreatePhotos" @submit.prevent="create">
                    <div class="wg-form-add__hr">Альбом</div>
                    <div class="row">
                      <div class="col_6">
                        <ui-text name="album" caption="Название нового альбома"></ui-text>
                      </div>
                    </div>
                    <div class="wg-form-add__buttons">
                      <button class="ui-button ui-button_blue" type="submit">Добавить альбом</button>
                    </div>
                  </form>
                </div>
                <div class="wg-form-add__content" v-show="tabs=='photo'">
                  <div class="wg-form-add__hr">
                    <!-- <i class="fa fa-camera" aria-hidden="true"></i> -->
                    Фотографии
                  </div>
                  <div v-if="slide!=undefined">
                    <wg-slider
                      class="wg-card-photo__slider"
                      :slide="slide"
                      :select="selectPhoto"
                      @onSelect="isSelectPhoto"
                    ></wg-slider>
                    <wg-slider-navig
                      class="wg-card-photo__slider-navig"
                      :slide="slide"
                      :select="selectPhoto"
                      @onSelect="isSelectPhoto"
                    ></wg-slider-navig>
                  </div>
                  <form
                    id="formLoadPhotos"
                    enctype="multipart/form-data"
                    @submit.prevent="loadPhotos"
                  >
                    <ui-file
                      v-if="!rirendLoader"
                      caption="Выберите фотографии"
                      captionCompleted="Выбранные фотографии"
                      :autoresize="300"
                      accept="image/*"
                      :percent="percentFL"
                    ></ui-file>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </ui-blind>
</template>
<script>
export default {
    name:"wg-form-photos",
    data(){
        return{
            showFormPhotos: this.show,
            windowHeight: document.body.clientHeight,
            tabs:'basick'
        }
    },
    props:{
        show:{
            type:Boolean,
            default: false
        }
    },
    watch:{
        show(newQ){
            this.showFormPhotos=newQ;
        }
    },
    methods:{
        isClose() {
            this.$emit("onHide");
        },
        isTabs(id) {
            this.tabs = id;
        },
    }
}
</script>

