<template>
	<div class="wg-form-add" :style="{'min-height': windowHeight+'px'} ">
		<div class="row">
			<div class="col-12">
				<div class="wg-form-add__bar">
					<div class="ui-header ui-header_2 wg-form-add__header">
						<span>Форма подачи объявления</span>
					</div>
					<button class="ui-button ui-button_circle ui-button_flat wg-form-add__close" @click="isClose">
						<i class="fa fa-angle-right"></i>
					</button>
					<ui-tabs class="wg-form-add__tabs">
						<ui-tabs-tab id="basick" :checked="tabs=='basick'" @onFocus="isTabs">
							<div class="ui-tabs__icone">1</div>Основное
						</ui-tabs-tab>
						<ui-tabs-tab id="photo" :checked="tabs=='photo'" @onFocus="isTabs" :disabled="disabledTabs">
							<div class="ui-tabs__icone">2</div>Фотографии
						</ui-tabs-tab>
						<ui-tabs-tab id="excess" :checked="tabs=='excess'" @onFocus="isTabs" :disabled="disabledTabs">
							<div class="ui-tabs__icone">3</div>Дополнительно
						</ui-tabs-tab>
					</ui-tabs>
				</div>
				<div class="wg-form-add__content" v-show="tabs=='basick'">
					<form id="formCreateAdd" @submit.prevent="create">
						<div class="wg-form-add__hr">
							<!-- <i class="fa fa-map-marker" aria-hidden="true"></i> -->
							Местоположение
						</div>
						<div class="row">
							<div class="col_12">
								<wg-select-location caption="Страна, регион, город"></wg-select-location>
							</div>
						</div>
						<div class="wg-form-add__hr">
							<!-- <i class="fa fa-car" aria-hidden="true"></i> -->
							Автомобиль
						</div>
						<div class="row">
							<div class="col_5">
								<ui-select name="brand" caption="Марка" :menu="menuBrands" @onSelect="isSelectedBrand"></ui-select>
							</div>
							<div class="col_5 col_offset-2">
								<ui-select
									name="model"
									caption="Модель"
									:menu="menuModels"
									:disabled="(menuModels.length==0?true:false)"
								></ui-select>
							</div>
						</div>
						<ui-textarea name="description" caption="Описание" :autoresize="250"></ui-textarea>
						<div class="row">
							<div class="col_3">
								<ui-select name="year" caption="Год выпуска" :menu="menuYear"></ui-select>
							</div>
							<div class="col_2 col_offset-1">
								<ui-text name="mileage" caption="Пробег км." :masc="{use:mascNumber}" :maxlength="9"></ui-text>
							</div>
						</div>
						<div class="wg-form-add__hr">
							<!-- <i class="fa fa-money" aria-hidden="true"></i> -->
							Стоимость
						</div>
						<div class="row">
							<div class="col_5">
								<ui-text name="price" caption="Цена руб." :masc="{use:mascNumber}" :maxlength="10"></ui-text>
							</div>
						</div>
						<div class="wg-form-add__buttons">
							<button class="ui-button ui-button_blue" type="submit">Добавить объявление</button>
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
					<form id="formLoadPhotos" enctype="multipart/form-data" @submit.prevent="loadPhotos">
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
				<form id="formUpdateAdd" @submit.prevent="updateData">
					<div class="wg-form-add__content" v-show="tabs=='excess'">
						<div class="wg-form-add__hr">Двигатель</div>
						<div class="row">
							<div class="col_4">
								<ui-select name="fuel" caption="Топливо" :menu="menuFuels" @onSelect="isSelectedFuels"></ui-select>
							</div>
							<div class="col_3 col_offset-1">
								<ui-text name="power" caption="Мошьность, л.с." :masc="{use:mascNumber}" :maxlength="4"></ui-text>
							</div>
							<div class="col_3 col_offset-1">
								<ui-select v-if="menuVolums.length>0" name="volume" caption="Объем, л." :menu="menuVolums"></ui-select>
							</div>
						</div>
						<div class="wg-form-add__hr">КПП</div>
						<div class="row">
							<div class="col_4">
								<ui-radio name="transmission" value="1">Автомат</ui-radio>
								<ui-radio name="transmission" value="2">Механика</ui-radio>
								<ui-radio name="transmission" value="3">Робот</ui-radio>
							</div>
						</div>
						<div class="wg-form-add__hr">Привод</div>
						<div class="row">
							<div class="col_4">
								<ui-radio name="drive" value="1">Передний</ui-radio>
								<ui-radio name="drive" value="2">Задний</ui-radio>
								<ui-radio name="drive" value="3">Полный (4WD)</ui-radio>
							</div>
						</div>
						<div class="wg-form-add__hr">Кузов</div>
						<div class="row">
							<div class="col_4">
								<ui-radio
									v-for="(val, key) in menuBodies"
									:key="key"
									name="body"
									:value="val.value"
								>{{val.option}}</ui-radio>
							</div>
						</div>
						<div class="wg-form-add__hr">Руль</div>
						<div class="row">
							<div class="col_4">
								<ui-radio name="wheel" value="l">Левый</ui-radio>
								<ui-radio name="wheel" value="r">Правый</ui-radio>
							</div>
						</div>
						<div class="wg-form-add__hr">
							<!-- <i class="fa fa-exclamation" aria-hidden="true"></i> -->
							Особые отметки
						</div>
						<div class="row">
							<div class="col_12">
								<div class="wg-form-add__checkboxs">
									<ui-check-box name="documentation" value="1" :checked="true">без документов</ui-check-box>
									<ui-check-box name="repair" value="1" :checked="true">требует ремонта</ui-check-box>
									<ui-check-box name="exchange" value="1" :checked="true">готов к обмену</ui-check-box>
								</div>
							</div>
						</div>
						<div class="wg-form-add__buttons">
							<button class="ui-button ui-button_blue" type="submit">Добавить</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col_12">
				<ui-snackbar :show="showSnackbar" @onHide="showSnackbar=false" :time="20000">{{descSnackbar}}</ui-snackbar>
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
      selectedFuel: undefined,
      showSnackbar: false,
      descSnackbar: "",
      photoLincks: undefined,
      disabledTabs: true,
      add_id: undefined,
      selectPhoto: 0,
      percentFL: undefined,
      rirendLoader: false,
      windowHeight: document.body.clientHeight
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
    isSelectedFuels(fuel) {
      this.selectedFuel = fuel[0].value;
    },
    isSelectPhoto(nPhoto) {
      this.selectPhoto = nPhoto;
    },
    create(event) {
      let body = new FormData(event.target);
      this.$http.post("/api/create/ads", body).then(
        response => {
          this.disabledTabs = false;
          this.tabs = "photo";
          this.add_id = response.body.add_id;
          this.showSnackbar = false;
          this.showSnackbar = true;

          this.descSnackbar =
            "Объявление успешно создано. Можете добавить фотографии.";
        },
        error => {
          let massege = error.body.exceptions.massege;

          if (massege != undefined) {
            this.showSnackbar = false;
            this.showSnackbar = true;
            this.descSnackbar = massege;
          }
        }
      );
    },
    updateData(event) {
      let body = new FormData(event.target);
      body.set("add_id", this.add_id);
      this.$http.post("/api/update/ads", body).then(
        response => {
          response;
          this.showSnackbar = false;
          this.showSnackbar = true;
          this.descSnackbar = "Дополнительная информация успешно добавлена.";
        },
        error => {
          console.log(error);
        }
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
              this.percentFL = (e.loaded / e.total) * 100;
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
              this.percentFL = undefined;
              this.rirendLoader = false;
              this.photoLincks = response.body.ads[0].lincks;
              this.showSnackbar = false;
              this.showSnackbar = true;
              this.descSnackbar =
                "Фотографии успешно добавлены. Можете добавить дополнительную информацию к объявлению. ";
            }, 4);
          },
          error => {}
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
      return this.$store.getters["form_add/getYears"];
    },
    menuFuels() {
      return this.$store.getters["form_add/getFuels"];
    },
    menuBodies() {
      return this.$store.getters["form_add/getBodies"];
    },
    menuVolums() {
      if (this.selectedFuel != undefined) {
        return this.$store.getters["form_add/getVolums"](this.selectedFuel);
      } else {
        return [];
      }
    }
  },
  mounted() {
    // console.log(this.$store.getters["form_add/getSubjects"]);
  }
};
</script>

