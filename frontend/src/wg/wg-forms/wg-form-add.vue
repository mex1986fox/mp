<template>
	<div class="wg-form-add">
		<div class="row">
			<div class="col-12">
				<div class="wg-form-add__bar">
					<div class="ui-header ui-header_2 wg-form-add__header">
						<span>Форма подачи объявления</span>
					</div>
					<button class="ui-button ui-button_circle ui-button_flat wg-form-add__close" @click="isClose">
						<i class="fa fa-angle-up"></i>
					</button>
					<ui-tabs class=" wg-form-add__tabs">
						<ui-tabs-tab id="basick" :checked="tabs=='basick'" @onFocus="isTabs">
							<div class="ui-tabs__icone">
								1
							</div>
							Основное
						</ui-tabs-tab>
						<ui-tabs-tab id="photo" :checked="tabs=='photo'" @onFocus="isTabs" :disabled="disanledTabs">
							<div class="ui-tabs__icone">
								2
							</div>
							Фотографии
						</ui-tabs-tab>
						<ui-tabs-tab id="excess" :checked="tabs=='excess'" @onFocus="isTabs" :disabled="disanledTabs">
							<div class="ui-tabs__icone">
								3
							</div>
							Дополнительно
						</ui-tabs-tab>
					</ui-tabs>

				</div>

				<div class="wg-form-add__content" v-show="tabs=='basick'">
					<form id="formCreateAdd" @submit.prevent="create">
						<div class="wg-form-add__hr">
							<i class="fa fa-map-marker" aria-hidden="true"></i>
							Местоположение
						</div>
						<div class="row">
							<div class="col_5">
								<ui-select name="subject" caption="Субъект" :menu='menuSubjects' @onSelect='isSelectedRegion'>
								</ui-select>
							</div>
							<div class="col_5 col_offset-2">
								<ui-select name="settlement" caption="Город" :menu='menuSettlements' :disabled='(menuSettlements.length==0?true:false)'>
								</ui-select>
							</div>
						</div>

						<div class="wg-form-add__hr">
							<i class="fa fa-car" aria-hidden="true"></i>

							Автомобиль
						</div>
						<div class="row">
							<div class="col_5">
								<ui-select name="brand" caption="Марка" :menu='menuBrands' @onSelect='isSelectedBrand'>
								</ui-select>
							</div>
							<div class="col_5 col_offset-2">
								<ui-select name="model" caption="Модель" :menu='menuModels' :disabled="(menuModels.length==0?true:false)">
								</ui-select>
							</div>
						</div>

						<ui-textarea name="description" caption="Описание" :autoresize="250">
						</ui-textarea>
						<div class="row">
							<div class="col_4">
								<ui-select name="year" caption="Год выпуска" :menu='menuYear'>
								</ui-select>
							</div>
						</div>
						<div class="row">
							<div class="col_4">
								<ui-text name="mileage" caption="Пробег"></ui-text>
							</div>
						</div>

						<div class="wg-form-add__hr">
							<i class="fa fa-exclamation" aria-hidden="true"></i>
							Особые отметки
						</div>
						<div class="wg-form-add__checkboxs">
							<ui-check-box name="documentation" value="1" :checked="true">
								без документов
							</ui-check-box>
							<ui-check-box name="repair" value="1" :checked="true">
								требует ремонта
							</ui-check-box>
							<ui-check-box name='exchange' value="1" :checked="true">
								готов к обмену
							</ui-check-box>
						</div>
						<div class="wg-form-add__hr">
							<i class="fa fa-money" aria-hidden="true"></i>
							Стоимость
						</div>
						<div class="row">
							<div class="col_5">
								<ui-text name="price" caption="Цена"></ui-text>
							</div>
						</div>
						<div class="wg-form-add__buttons">
							<button class="ui-button ui-button_blue  " type="submit">
								Добавить объявление
							</button>
						</div>
					</form>
				</div>

				<div class="wg-form-add__content" v-show="tabs=='photo'">

					<div class="wg-form-add__hr">
						<i class="fa fa-camera" aria-hidden="true"></i>

						Фотографии
					</div>
					<div v-if="slide!=undefined">
						<wg-slider class="wg-card-photo__slider" :slide='slide' :select="selectPhoto" @onSelect="isSelectPhoto">
						</wg-slider>
						<wg-slider-navig class="wg-card-photo__slider-navig" :slide='slide' :select="selectPhoto" @onSelect="isSelectPhoto">
						</wg-slider-navig>
					</div>
					<form id="formLoadPhotos" enctype="multipart/form-data" @submit.prevent="loadPhotos">
						<ui-file v-if="!rirendLoader" caption="Выберите фотографии" captionCompleted="Выбранные фотографии" :autoresize="300" accept="image/*" :percent="percentFL">
						</ui-file>
					</form>
				</div>

			</div>
		</div>
	</div>

</template>

<script>
export default {
  name: "wg-form-add",
  data() {
    return {
      tabs: "basick",
      selectedRegion: undefined,
      selectedBrand: undefined,
      photoLincks: undefined,
      disanledTabs: true,
      add_id: undefined,
      selectPhoto: 0,
			percentFL: undefined,
			rirendLoader:false
    };
  },
  methods: {
    isTabs(id) {
      this.tabs = id;
      //   console.log(id);
    },
    isClose() {
      this.$emit("onHide");
    },
    isSelectedRegion(region) {
      this.selectedRegion = region[0].value;
    },
    isSelectedBrand(brand) {
      this.selectedBrand = brand[0].value;
    },
    isSelectPhoto(nPhoto) {
      this.selectPhoto = nPhoto;
    },
    create(event) {
      let form = document.getElementById("formCreateAdd");
      let body = new FormData(form);
      this.$http.post("/api/create/ads", body).then(
        response => {
          this.disanledTabs = false;
          this.tabs = "photo";
          this.add_id = response.body.add_id;
        },
        error => {}
      );
    },
    loadPhotos() {
      this.numberFL = 1;
      let form = document.getElementById("formLoadPhotos");
      let body = new FormData(form);
      body.set("session_id", this.$cookie.get("PHPSESSID"));
      body.set("user_id", this.$cookie.get("user_id"));
      body.set("add_id", this.add_id);
      this.$http
        .post(this.$hosts.photosAds + "/api/create/photos", body, {
          progress: function(e) {
            if (e.lengthComputable) {
              this.percentFL = e.loaded / e.total * 100;
						}
					
          }.bind(this)
        })
        .then(
          response => {
            this.updatePhotoLincks();
          },
          error => {}
        );
    },
    updatePhotoLincks() {
      let params = { add_id: this.add_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.photosAds + "/api/show/photos", params, headers)
        .then(
          response => {
            this.photoLincks = undefined;
            this.rirendLoader = true;
            setTimeout(() => {
							this.percentFL=undefined;
              this.rirendLoader = false;
              this.photoLincks = response.body.ads[0].lincks;
            }, 100);
          },
          error => {}
        );
    }
  },
  computed: {
    slide() {
      if (this.photoLincks != undefined) {
        return this.photoLincks.map(function(slide) {
          return { src: slide };
        });
      }
      return undefined;
    },
    menuSubjects() {
      return this.$store.getters["form_add/getSubjects"];
    },
    menuSettlements() {
      if (this.selectedRegion != undefined) {
        return this.$store.getters["form_add/getSettlements"](
          this.selectedRegion
        );
      } else {
        return [];
      }
    },
    menuBrands() {
      return this.$store.getters["form_add/getBrands"];
    },
    menuModels() {
      if (this.selectedBrand != undefined) {
        return this.$store.getters["form_add/getModels"](this.selectedBrand);
      } else {
        return [];
      }
    },
    menuYear() {
      let maxDate = new Date().getFullYear();
      let minDate = 1935;
      let menu = [];

      // {value:"1",option:"Audi", group:"Область", selected:true}
      while (minDate != maxDate) {
        menu.push({
          value: maxDate,
          option: maxDate,
          group: "Года",
          selected: menu.length == 0 ? true : false
        });
        maxDate--;
      }
      return menu;
    }
  },
  mounted() {
    // console.log(this.$store.getters["form_add/getSubjects"]);
  }
};
</script>

