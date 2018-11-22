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
							<wg-multiple-location :caption="'Страна, регион, город'" @onInsert="setFilterLocation"></wg-multiple-location>
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
							<wg-multiple-transport :caption="'Тип, фирма, модель'" @onInsert="setFilterTransport"></wg-multiple-transport>
						</div>
					</div>
				</div>
			</div>
			<div class="col_12" v-show="tabs=='param'">
				<div class="wg-filter-add__content">
					<div class="row">
						<div class="col_6">
							<ui-select name="marca" caption="Сортировать по" :menu="menuSortBy"></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-text name="price" value="" :masc="'mascNumber'" caption="Цена от" :maxlength="9"></ui-text>
						</div>
						<div class="col_5 col_offset-1">
							<ui-text name="pricebef" value="" :masc="'mascNumber'" caption="до" :maxlength="9"></ui-text>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="year" caption="Год от" :menu="menuYear"></ui-select>
						</div>
						<div class="col_5 col_offset-1">
							<ui-select name="yearbef" caption="до" :menu="menuYearBef"></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="fuel" caption="Топливо" :menu="menuFuels" :multiple="true"></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-text name="volume" value="" caption="Объем от" :masc="'mascNumber'" :maxlength="4"></ui-text>
						</div>
						<div class="col_5 col_offset-1">
							<ui-text name="volumebef" value="" caption="до" :masc="'mascNumber'" :maxlength="4"></ui-text>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="body" caption="Кузов" :menu="menuBodies" :multiple="true"></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="drive" caption="Привод" :menu="menuDrives" :multiple="true"></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="transmission" caption="Коробка" :menu="menuTransmissions" :multiple="true"></ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="helm" caption="Руль" :menu="menuHelms" :multiple="true"></ui-select>
						</div>
					</div>
				</div>
			</div>
			<div class="col_12">
				<div class="wg-filter-add__buttons">
					<button class="ui-button ui-button_blue">Применить</button>
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
    }
  }
};
</script>
