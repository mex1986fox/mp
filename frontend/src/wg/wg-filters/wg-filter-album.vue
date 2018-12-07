<template>
  <ui-blind :show="dShow" @onHide="dShow=false" animate="right">
    <div class="container container_right">
      <div class="row">
        <div
          class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
        >
          <div ref="filter" class="wg-filter-add">
            <div class="row">
              <div class="col_12">
                <div class="wg-filter-add__bar">
                  <div
                    class="ui-header ui-header_2 wg-filter-add__header"
                  >Фильтр альбомов фотографий</div>
                  <button
                    class="ui-button ui-button_circle ui-button_flat wg-filter-add__close"
                    @click="isClose"
                  >
                    <i class="fa fa-angle-right"></i>
                  </button>
                  <ui-tabs class="wg-filter-add__tabs">
                    <ui-tabs-tab id="city" :checked="tabs=='city'" @onFocus="isTabs">Города</ui-tabs-tab>
                    <ui-tabs-tab id="model" :checked="tabs=='model'" @onFocus="isTabs">Модели</ui-tabs-tab>
                    <ui-tabs-tab id="param" :checked="tabs=='param'" @onFocus="isTabs">Параметры</ui-tabs-tab>
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
                        :pCountry="JSON.parse(JSON.stringify(menuCountry))"
                        :pSubject="JSON.parse(JSON.stringify(menuSubject))"
                        :pSettlement="JSON.parse(JSON.stringify(menuSettlement))"
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
                  <div class="wg-form-add__hr">Параметры</div>
                  <div class="row">
                    <div class="col_6">
                      <ui-select
                        name="sort"
                        caption="Сортировать по:"
                        :menu="menuSort"
                        @onSelect="setFilterSort"
                      ></ui-select>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col_6">
                      <ui-select
                        name="year"
                        caption="Год от"
                        :menu="menuYear"
                        @onSelect="setFilterYear"
                      ></ui-select>
                    </div>
                    <div class="col_5 col_offset-1">
                      <ui-select
                        name="year_bef"
                        caption="до"
                        :menu="menuYearBef"
                        @onSelect="setFilterYearBef"
                      ></ui-select>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col_12">
                <div class="wg-filter-add__buttons">
                  <button class="ui-button ui-button_blue" @click="unloadFilter">Применить
                    <ui-loader-button v-if="flagUnloadFilter"></ui-loader-button>
                  </button>
                  <button class="ui-button ui-button_flat" @click="isClose">Отмена</button>
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
  name: "wg-filter-album",
  data() {
    return {
      dShow: this.show,
      tabs: "city",
      flagUnloadFilter: false
    };
  },
  props: {
    show: {
      type: Boolean,
      default: false
    }
  },
  watch: {
    show(newQ) {
      this.dShow = newQ;
      this.autoHeight();
    }
  },
  computed: {
    menuTransport() {
      return this.$store.getters["filter_album/getTransports"];
    },
    menuModel() {
      return this.$store.getters["filter_album/getModels"];
    },
    menuBrand() {
      return this.$store.getters["filter_album/getBrands"];
    },
    menuCountry() {
      return this.$store.getters["filter_album/getCountries"];
    },
    menuSettlement() {
      return this.$store.getters["filter_album/getSettlements"];
    },
    menuSubject() {
      return this.$store.getters["filter_album/getSubjects"];
    },
    menuSort() {
      return this.$store.getters["filter_album/getSort"];
    },
    menuYear() {
      return this.$store.getters["filter_album/getYears"];
    },
    menuYearBef() {
      return this.$store.getters["filter_album/getYearsBef"];
    }
  },
  mounted() {
    window.addEventListener("resize", () => {
      this.autoHeight();
    });
    this.autoHeight();
  },
  methods: {
    // устанавливает  длину контейнера контетнта
    autoHeight() {
      setTimeout(() => {
        if (this.$refs.filter != undefined) {
          let height = window.document.body.clientHeight - 258;
          let contents = this.$refs.filter.querySelectorAll(
            ".wg-filter-add__content"
          );
          contents.forEach(content => {
            content.style.cssText = "min-height: " + height + "px";
          });
        }
      }, 4);
    },
    onUpdated() {
      this.$emit("onUpdated");
      this.isClose();
    },
    isTabs(id) {
      this.tabs = id;
      //   console.log(id);
    },
    isClose() {
      this.$emit("onHide");
    },
    unloadFilter() {
      // помещаем фильтр в куки
      this.$cookie.set("filter_albums", JSON.stringify(this.$store.state.filter_album.filter));
      if (this.$cookie.get("user_id") != undefined) {
        this.flagUnloadFilter = true;
        let headers = { "Content-Type": "multipart/form-data" };
        let params = {
          session_id: this.$cookie.get("PHPSESSID"),
          user_id: this.$cookie.get("user_id"),
          filter: this.$cookie.get("filter_albums")
        };
        this.$http
          .post(this.$hosts.albums + "/api/create/filter", params, headers)
          .then(
            response => {
              this.flagUnloadFilter = false;
              this.onUpdated();
            },
            error => {
              this.flagUnloadFilter = false;
            }
          );
      }
    },
    onUpdated() {
      this.$emit("onUpdated");
      this.isClose();
    },
    setFilterSort(sort) {
      this.$store.commit("filter_album/setFilter", {
        name: "sort",
        filter: sort.map(sortv => {
          return sortv.value;
        })
      });
    },
    setFilterLocation(location) {
      this.$store.commit("filter_album/setFilter", {
        name: "countries",
        filter: location.countries.map(countr => {
          return countr.id;
        })
      });
      this.$store.commit("filter_album/setFilter", {
        name: "subjects",
        filter: location.subjects.map(countr => {
          return countr.id;
        })
      });
      this.$store.commit("filter_album/setFilter", {
        name: "settlements",
        filter: location.settlements.map(countr => {
          return countr.id;
        })
      });
    },
    setFilterTransport(transport) {
      this.$store.commit("filter_album/setFilter", {
        name: "brands",
        filter: transport.brands.map(countr => {
          return countr.id;
        })
      });
      this.$store.commit("filter_album/setFilter", {
        name: "models",
        filter: transport.models.map(countr => {
          return countr.id;
        })
      });
      this.$store.commit("filter_album/setFilter", {
        name: "transports",
        filter: transport.transports.map(countr => {
          return countr.id;
        })
      });
    },
    setFilterYear(year) {
      this.$store.commit("filter_album/setFilter", {
        name: "year",
        filter: year.map(sort => {
          return sort.value;
        })[0]
      });
    },
    setFilterYearBef(year) {
      this.$store.commit("filter_album/setFilter", {
        name: "yearBef",
        filter: year.map(sort => {
          return sort.value;
        })[0]
      });
    }
  }
};
</script>
