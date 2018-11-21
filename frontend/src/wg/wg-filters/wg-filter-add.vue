<template>
	<div class="wg-filter-add"
	     :style="{'min-height': windowHeight+'px'}">
		<div class="
	     row">
			<div class="col_12">
				<div class="wg-filter-add__bar">
					<div class="ui-header ui-header_2 wg-filter-add__header">Фильтр объявлений</div>
					<button class="ui-button ui-button_circle ui-button_flat wg-filter-add__close"
					        @click="isClose">
						<i class="fa fa-angle-right"></i>
					</button>
					<ui-tabs class="wg-filter-add__tabs">
						<ui-tabs-tab id="city"
						             :checked="true"
						             @onFocus="isTabs">Города</ui-tabs-tab>
						<ui-tabs-tab id="model"
						             @onFocus="isTabs">Модели</ui-tabs-tab>
						<ui-tabs-tab id="param"
						             @onFocus="isTabs">Параметры</ui-tabs-tab>
					</ui-tabs>
				</div>
			</div>
			<div class="col_12"
			     v-show="tabs=='city'">
				<div class="wg-filter-add__content">
					<div class="wg-form-add__hr">
						<!-- <i class="fa fa-map-marker" aria-hidden="true"></i> -->
						Местоположение
					</div>
					<div class="row">
						<div class="col_12">
							<wg-multiple-location :caption="'Страна, регион, город'"></wg-multiple-location>
						</div>
					</div>
				</div>
			</div>
			<div class="col_12"
			     v-show="tabs=='model'">
				<div class="wg-filter-add__content">
					<div class="wg-form-add__hr">
						<!-- <i class="fa fa-map-marker" aria-hidden="true"></i> -->
						Вид транспорта
					</div>
					<div class="row">
						<div class="col_12">
							<wg-multiple-location :caption="'Тип, фирма, модель'"></wg-multiple-location>
						</div>
					</div>
				</div>
			</div>
			<div class="col_12"
			     v-show="tabs=='param'">
				<div class="wg-filter-add__content">
					<ui-select name="marca"
					           caption="Сортировать по">
					</ui-select>
					<div class="row">
						<div class="col_6">
							<ui-text value=""
							         caption="Цена от"></ui-text>
						</div>
						<div class="col_5 col_offset-1">
							<ui-text value=""
							         caption="до"></ui-text>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="year"
							           caption="Год от">
							</ui-select>
						</div>
						<div class="col_5 col_offset-1">
							<ui-select name="year"
							           caption="до">
							</ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="volume"
							           caption="Объем от">
							</ui-select>
						</div>
						<div class="col_5 col_offset-1">
							<ui-select name="year"
							           caption="до">
							</ui-select>
						</div>
					</div>
					<ui-select name="marca"
					           caption="Привод">
					</ui-select>
					<ui-select name="marca"
					           caption="Коробка">
					</ui-select>
					<ui-select name="marca"
					           caption="Руль">
					</ui-select>
					<ui-select name="marca"
					           caption="Топливо">
					</ui-select>
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
  methods: {
    isTabs(id) {
      this.tabs = id;
      //   console.log(id);
    },
    isClose() {
      this.$emit("onHide");
    }
  }
};
</script>
