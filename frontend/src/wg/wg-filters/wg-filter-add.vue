<template>
	<div class="wg-filter-add" :style="{'min-height': windowHeight+'px'}">
		<div class="row">
			<div class="col_12">
				<div class="wg-filter-add__bar">
					<div class="ui-header ui-header_2 wg-filter-add__header">Фильтр объявлений</div>
					<button
						class="ui-button ui-button_circle ui-button_flat wg-filter-add__close"
						@click="isClose"
					>
						<i class="fa fa-angle-right"></i>
					</button>
					<ui-tabs class="wg-filter-add__tabs">
						<ui-tabs-tab id="city" :checked="true" @onFocus="isTabs">Города</ui-tabs-tab>
						<ui-tabs-tab id="model" @onFocus="isTabs">Модели</ui-tabs-tab>
						<ui-tabs-tab id="param" @onFocus="isTabs">Параметры</ui-tabs-tab>
					</ui-tabs>
				</div>
			</div>
			<div class="col_12" v-show="tabs=='city'">
				<div class="wg-filter-add__content">
					<div class="wg-form-add__hr">
						<!-- <i class="fa fa-map-marker" aria-hidden="true"></i> -->
						Местоположение
					</div>
					<div class="row">
						<div class="col_12">
							<wg-multiple-location
								:pCountry="menuCountry"
								:pSubject="menuSubject"
								:pSettlement="menuSettlement"
								:caption="'Страна, регион, город'"
								@onInsert="setFilterLocation"
							></wg-multiple-location>
						</div>
					</div>
				</div>
			</div>
			<div class="col_12" v-show="tabs=='model'">
				<div class="wg-filter-add__content">
					<div class="wg-form-add__hr">
						<!-- <i class="fa fa-map-marker" aria-hidden="true"></i> -->
						Вид транспорта
					</div>
					<div class="row">
						<div class="col_12">
							<wg-multiple-transport
								:pTransport="menuTransport"
								:pModel="menuModel"
								:pBrand="menuBrand"
								:caption="'Тип, фирма, модель'"
								@onInsert="setFilterTransport"
							></wg-multiple-transport>
						</div>
					</div>
				</div>
			</div>
			<div class="col_12" v-show="tabs=='param'">
				<div class="wg-filter-add__content">
					<div class="row">
						<div class="col_6">
							<ui-select
								name="sort_by"
								caption="Сортировать по"
								:menu="menuSortBy"
								@onSelect="setFilterSortBy"
							></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-text
								name="price"
								:value="valuePrice"
								:masc="'mascNumber'"
								caption="Цена от"
								:maxlength="9"
								@onInput="setFilterPrice"
							></ui-text>
						</div>
						<div class="col_5 col_offset-1">
							<ui-text
								name="price_bef"
								:value="valuePriceBef"
								:masc="'mascNumber'"
								caption="до"
								:maxlength="9"
								@onInput="setFilterPriceBef"
							></ui-text>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="year" caption="Год от" :menu="menuYear" @onSelect="setFilterYear"></ui-select>
						</div>
						<div class="col_5 col_offset-1">
							<ui-select name="year_bef" caption="до" :menu="menuYearBef" @onSelect="setFilterYearBef"></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select
								name="fuel"
								caption="Топливо"
								:menu="menuFuels"
								:multiple="true"
								@onSelect="setFilterFuel"
							></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-text
								name="volume"
								:value="valueVolume"
								caption="Объем от"
								:masc="'mascNumber'"
								:maxlength="4"
								@onInput="setFilterVolume"
							></ui-text>
						</div>
						<div class="col_5 col_offset-1">
							<ui-text
								name="volume_bef"
								:value="valueVolumeBef"
								caption="до"
								:masc="'mascNumber'"
								:maxlength="4"
								@onInput="setFilterVolumeBef"
							></ui-text>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select
								name="body"
								caption="Кузов"
								:menu="menuBodies"
								:multiple="true"
								@onSelect="setFilterBody"
							></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select
								name="drive"
								caption="Привод"
								:menu="menuDrives"
								:multiple="true"
								@onSelect="setFilterDrive"
							></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select
								name="transmission"
								caption="Коробка"
								:menu="menuTransmissions"
								:multiple="true"
								@onSelect="setFilterTransmission"
							></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select
								name="helm"
								caption="Руль"
								:menu="menuHelms"
								:multiple="true"
								@onSelect="setFilterHelm"
							></ui-select>
						</div>
					</div>
				</div>
			</div>
			<div class="col_12">
				<div class="wg-filter-add__buttons">
					<button class="ui-button ui-button_blue" @click="loadFilter">Применить</button>
					<button class="ui-button ui-button_flat">Отмена</button>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
export default {
  name: "wg-filter-add",
  data() {
    return {
      tabs: "city",
      windowHeight: document.body.clientHeight,
      marca: [
        { value: "2", option: "Убыванию цены", group: "Цена", selected: false },
        { value: "3", option: "Старше", group: "Год", selected: false },
        { value: "3", option: "Моложе", group: "Год", selected: false }
      ]
    };
  },
  computed: {
    menuTransport() {
      return this.$store.getters["filter_add/getTransports"];
    },
    menuModel() {
      return this.$store.getters["filter_add/getModels"];
    },
    menuBrand() {
      return this.$store.getters["filter_add/getBrands"];
    },

    menuCountry() {
      return this.$store.getters["filter_add/getCountries"];
    },
    menuSettlement() {
      return this.$store.getters["filter_add/getSettlements"];
    },
    menuSubject() {
      return this.$store.getters["filter_add/getSubjects"];
    },
    menuSortBy() {
      return this.$store.getters["filter_add/getSortBy"];
    },
    menuFuels() {
      return this.$store.getters["filter_add/getFuels"];
    },
    menuYear() {
      return this.$store.getters["filter_add/getYears"];
    },
    menuYearBef() {
      return this.$store.getters["filter_add/getYearsBef"];
    },
    menuDrives() {
      return this.$store.getters["filter_add/getDrives"];
    },
    menuTransmissions() {
      return this.$store.getters["filter_add/getTransmissions"];
    },
    menuBodies() {
      return this.$store.getters["filter_add/getBodies"];
    },
    menuHelms() {
      return this.$store.getters["filter_add/getHelms"];
    },
    valuePrice() {
      return this.$store.getters["filter_add/getPrice"];
    },
    valuePriceBef() {
      return this.$store.getters["filter_add/getPriceBef"];
    },
    valueVolume() {
      return this.$store.getters["filter_add/getVolume"];
    },
    valueVolumeBef() {
      return this.$store.getters["filter_add/getVolumeBef"];
    }
  },
  methods: {
    isTabs(id) {
      this.tabs = id;
      //   console.log(id);
    },
    isClose() {
      this.$emit("onHide");
    },
    loadFilter() {
			let headers = { "Content-Type": "multipart/form-data" };
      let params = {
        user_id: this.$cookie.get("user_id"),
        filter: JSON.stringify(this.$store.state.filter_add.filter),
      };
      this.$http
        .post(
          this.$hosts.ads + "/api/create/adsFilter",
          params,
          headers
        )
        .then(
          response => {
            console.dir(response);
          },
          error => {}
        );
    },
    setFilterLocation(location) {
      this.$store.commit("filter_add/setFilter", {
        name: "location",
        filter: location
      });
    },
    setFilterTransport(transport) {
      this.$store.commit("filter_add/setFilter", {
        name: "transport",
        filter: transport
      });
    },
    setFilterSortBy(sortBy) {
      this.$store.commit("filter_add/setFilter", {
        name: "sortBy",
        filter: sortBy
      });
    },
    setFilterPrice(price) {
      this.$store.commit("filter_add/setFilter", {
        name: "price",
        filter: price
      });
    },
    setFilterPriceBef(price) {
      this.$store.commit("filter_add/setFilter", {
        name: "priceBef",
        filter: price
      });
    },
    setFilterYear(year) {
      this.$store.commit("filter_add/setFilter", {
        name: "year",
        filter: year
      });
    },
    setFilterYearBef(year) {
      this.$store.commit("filter_add/setFilter", {
        name: "yearBef",
        filter: year
      });
    },
    setFilterFuel(fuel) {
      this.$store.commit("filter_add/setFilter", {
        name: "fuel",
        filter: fuel
      });
    },
    setFilterVolume(volume) {
      this.$store.commit("filter_add/setFilter", {
        name: "volume",
        filter: volume
      });
    },
    setFilterVolumeBef(volume) {
      this.$store.commit("filter_add/setFilter", {
        name: "volumeBef",
        filter: volume
      });
    },
    setFilterBody(body) {
      this.$store.commit("filter_add/setFilter", {
        name: "body",
        filter: body
      });
    },
    setFilterDrive(drive) {
      this.$store.commit("filter_add/setFilter", {
        name: "drive",
        filter: drive
      });
    },
    setFilterTransmission(transmission) {
      this.$store.commit("filter_add/setFilter", {
        name: "transmission",
        filter: transmission
      });
    },
    setFilterHelm(helm) {
      this.$store.commit("filter_add/setFilter", {
        name: "helm",
        filter: helm
      });
    }
  }
};
</script>
