<template>
	<div class="wg-filter-add">
		<div class="row">
			<div class="col_12">
				<div class="wg-filter-add__bar">
					<div class="ui-header ui-header_2 wg-filter-add__header">
						Фильтр объявлений
					</div>
					<button class="ui-button ui-button_circle ui-button_flat wg-filter-add__close"
					        @click="isClose">
						<i class="fa fa-angle-right"></i>
					</button>
					<ui-tabs class=" wg-filter-add__tabs">
						<ui-tabs-tab id="city"
						             :checked="true"
						             @onFocus="isTabs">
							Города
						</ui-tabs-tab>
						<ui-tabs-tab id="model"
						             @onFocus="isTabs">
							Модели
						</ui-tabs-tab>
						<ui-tabs-tab id="param"
						             @onFocus="isTabs">
							Параметры
						</ui-tabs-tab>
					</ui-tabs>

				</div>
			</div>

			<div class="col_12"
			     v-show="tabs=='city'">
				<div class="wg-filter-add__content">
					<ui-select name="region"
					           caption="Выберите субъект"
					           :menu='[{value:"1",option:"Кемеровская", group:"Область", selected:true},
                                        {value:"2",option:"Новосибирская", group:"Область", selected:false},
                                        {value:"3",option:"Омская", group:"Области", selected:false},
                                        {value:"4",option:"Алтайский", group:"Край",selected:false},
                                        {value:"5",option:"Камчатский", group:"Край",selected:false}]'>
					</ui-select>
					<ui-select name="city"
					           caption="Выберите город"
					           :multiple="true"
					           :menu='[{value:"1",option:"Анжеро-Судженск", group:"Город", selected:true},
                                        {value:"2",option:"Новосибирск", group:"Город", selected:false},
                                        {value:"3",option:"Кемерово", group:"Город", selected:false},
                                        {value:"4",option:"Алтай", group:"Город",selected:false},
                                        {value:"5",option:"Яя", group:"Поселок",selected:false}]'>
					</ui-select>
					<div class="wg-filter-add__block-chips">

						<ui-chips name="chips45"
						          value="45"
						          caption="Кемерово"
						          deleted>
						</ui-chips>
						<ui-chips name="chips25"
						          value="25"
						          caption="Анжеро-судженск"
						          deleted>
						</ui-chips>
						<ui-chips name="chips45"
						          value="45"
						          caption="Кемерово"
						          deleted>
						</ui-chips>
					</div>

				</div>
			</div>
			<div class="col_12"
			     v-show="tabs=='model'">
				<div class="wg-filter-add__content">
					<ui-select name="marca"
					           caption="Выберите марку"
					           :menu='[{value:"1",option:"Audi", group:"Марка", selected:true},
                                        {value:"2",option:"Toyota", group:"Марка", selected:false},
                                        {value:"3",option:"Chevrolet", group:"Марка", selected:false},
                                        {value:"4",option:"BMV", group:"Марка",selected:false},
                                        {value:"5",option:"Honda", group:"Марка",selected:false}]'>
					</ui-select>
					<ui-select name="model"
					           caption="Выберите модель"
					           :multiple="true"
					           :menu='[{value:"11",option:"TT-100", group:"Audi", selected:true},
                                        {value:"22",option:"fd-500", group:"Audi", selected:false},
                                        {value:"32",option:"A-150", group:"Audi", selected:false},
                                        {value:"42",option:"A-200", group:"Audi",selected:false},
                                        {value:"52",option:"A-250", group:"Audi",selected:false}]'>
					</ui-select>
					<div class="wg-filter-add__block-chips">
						<ui-chips name="chips125"
						          value="25"
						          caption="fd-500"
						          deleted>
						</ui-chips>
						<ui-chips name="chips145"
						          value="45"
						          caption="Chevrolet"
						          deleted>
						</ui-chips>
					</div>
				</div>
			</div>
			<div class="col_12"
			     v-show="tabs=='param'">
				<div class="wg-filter-add__content">
					<ui-select name="marca"
					           caption="Сортировать по"
					           :menu='[{value:"1",option:"Возростанию цены", group:"Цена", selected:true},
                                        {value:"2",option:"Убыванию цены", group:"Цена", selected:false},
                                        {value:"3",option:"Старше", group:"Год", selected:false},
                                        {value:"3",option:"Моложе", group:"Год", selected:false}]'>
					</ui-select>
					<div class="row">
						<div class="col_6">
							<ui-text value=""
							         caption="Цена от">
							</ui-text>
						</div>
						<div class="col_5 col_offset-1">
							<ui-text value=""
							         caption="до">
							</ui-text>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="year"
							           caption="Год от"
							           :menu='[{value:"1",option:"2011", group:"год", selected:true},
                                        {value:"2",option:"2012", group:"год", selected:false},
                                        {value:"3",option:"2015", group:"Год", selected:false},
                                        {value:"3",option:"2016", group:"Год", selected:false}]'>
							</ui-select>
						</div>
						<div class="col_5 col_offset-1">
							<ui-select name="year"
							           caption="до"
							           :menu='[{value:"1",option:"2011", group:"год", selected:true},
                                        {value:"2",option:"2012", group:"год", selected:false},
                                        {value:"3",option:"2015", group:"Год", selected:false},
                                        {value:"3",option:"2016", group:"Год", selected:false}]'>
							</ui-select>
						</div>
					</div>
					<div class="row">
						<div class="col_6">
							<ui-select name="volume"
							           caption="Объем от"
							           :menu='[{value:"1",option:"2011", group:"год", selected:true},
                                        {value:"2",option:"2012", group:"год", selected:false},
                                        {value:"3",option:"2015", group:"Год", selected:false},
                                        {value:"3",option:"2016", group:"Год", selected:false}]'>
							</ui-select>
						</div>
						<div class="col_5 col_offset-1">
							<ui-select name="year"
							           caption="до"
							           :menu='[{value:"1",option:"2011", group:"год", selected:true},
                                        {value:"2",option:"2012", group:"год", selected:false},
                                        {value:"3",option:"2015", group:"Год", selected:false},
                                        {value:"3",option:"2016", group:"Год", selected:false}]'>
							</ui-select>
						</div>
					</div>
					<ui-select name="marca"
					           caption="Привод"
					           :menu='[{value:"1",option:"Возростанию цены", group:"Цена", selected:true},
                                        {value:"2",option:"Убыванию цены", group:"Цена", selected:false},
                                        {value:"3",option:"Старше", group:"Год", selected:false},
                                        {value:"3",option:"Моложе", group:"Год", selected:false}]'>
					</ui-select>
					<ui-select name="marca"
					           caption="Коробка"
					           :menu='[{value:"1",option:"Возростанию цены", group:"Цена", selected:true},
                                        {value:"2",option:"Убыванию цены", group:"Цена", selected:false},
                                        {value:"3",option:"Старше", group:"Год", selected:false},
                                        {value:"3",option:"Моложе", group:"Год", selected:false}]'>
					</ui-select>
					<ui-select name="marca"
					           caption="Руль"
					           :menu='[{value:"1",option:"Возростанию цены", group:"Цена", selected:true},
                                        {value:"2",option:"Убыванию цены", group:"Цена", selected:false},
                                        {value:"3",option:"Старше", group:"Год", selected:false},
                                        {value:"3",option:"Моложе", group:"Год", selected:false}]'>
					</ui-select>
					<ui-select name="marca"
					           caption="Топливо"
					           :menu='[{value:"1",option:"Возростанию цены", group:"Цена", selected:true},
                                        {value:"2",option:"Убыванию цены", group:"Цена", selected:false},
                                        {value:"3",option:"Старше", group:"Год", selected:false},
                                        {value:"3",option:"Моложе", group:"Год", selected:false}]'>
					</ui-select>
				</div>

			</div>
			<div class="col_12">
				<div class="wg-filter-add__buttons">
					<button class="ui-button ui-button_blue  ">
						Применить
					</button>
					<button class="ui-button ui-button_flat ">
						Отмена
					</button>

				</div>

			</div>
		</div>
	</div>
</template>
<script>
export default {
  name: "wg-filter-add",
  data() {
    return { tabs: "city" };
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
