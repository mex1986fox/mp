<template>
  <div class="wg-multiple-transport">
    <span
      @click.self="showModal=true"
      class="ui-text__caption wg-multiple-transport__caption"
      :class="{ 'ui-text__caption_completed wg-multiple-transport__caption_completed':modCompleted,
            'ui-text__caption_active wg-multiple-transport__caption_active':showModal, 
                  
                   'ui-text__caption_disabled':dDisabled}"
    >{{dCaption}}</span>
    <div @click.self="showModal=true" class="wg-multiple-transport__container">
      <ui-chips
        class="wg-multiple-transport__chips__red"
        @onDeleted="onDeletedChip"
        v-for="(val, key) in transports"
        :key="val.type+'ch2'+key"
        v-if="val.check"
        :name="val.type+'[]'"
        :value="val.id"
        :caption="val.extended_name"
        deleted
      ></ui-chips>
      <ui-chips
        class="wg-multiple-transport__chips__blue"
        @onDeleted="onDeletedChip"
        v-for="(val, key) in brands"
        :key="val.type+'ch2'+key"
        v-if="val.check"
        :name="val.type+'[]'"
        :value="val.id"
        :caption="val.extended_name"
        deleted
      ></ui-chips>
      <ui-chips
        class="wg-multiple-transport__chips__green"
        @onDeleted="onDeletedChip"
        v-for="(val, key) in models"
        :key="val.type+'ch2'+key"
        v-if="val.check"
        :name="val.type+'[]'"
        :value="val.id"
        :caption="val.extended_name"
        deleted
      ></ui-chips>
    </div>
    <hr
      @click.self="showModal=true"
      class="ui-text__border wg-multiple-transport__border"
      :class="{'ui-text__border_active':showModal,
                  'ui-text__border_disabled':dDisabled}"
    >
    <div @click="showModal=true" class="wg-multiple-transport__button">
      <i class="fa fa-car" aria-hidden="true"></i>
    </div>
    <ui-blind :show="showModal" @onHide="onInsert" selector=".ui-modal-window" :centering="true" animate="opacity">
      <div class="container">
        <div class="row">
          <div class="col_4 col_offset-4 col-phone_6 col-phone_offset-0">
            <!--модальное окно-->
            <div class="ui-modal-window">
              <div class="ui-modal-window__header">
                <div
                  @click="onInsert"
                  class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat ui-modal-window__header__button"
                >
                  <i class="fa fa-times" aria-hidden="true"></i>
                </div>Транспорт
              </div>
              <div class="ui-modal-window__content">
                <div class="row">
                  <div class="col_12">
                    Введите в поисковую строку тип транспорта, марку или модель транспорта
                    <ui-search
                      :placeholder="'Тип, марка, модель'"
                      :showMenu="menuSearch.length>0"
                      @onInput="isSearch"
                    >
                      <div class="wg-multiple-transport__menu">
                        <ui-check-box
                          @onClick="isClickCheckbox"
                          v-for="(val, key) in menuSearch"
                          :key="val.type+key"
                          :checked="val.check"
                          :name="val.type+'[]'"
                          :value="val.id"
                        >{{val.extended_name}}</ui-check-box>
                      </div>
                    </ui-search>
                    <div class="wg-multiple-transport__chips-container">
                      <ui-chips
                        class="wg-multiple-transport__chips__red"
                        @onDeleted="isClickCheckbox"
                        v-for="(val, key) in transports"
                        :key="val.type+key"
                        v-if="val.check"
                        :name="val.type+'[]'"
                        :value="val.id"
                        :caption="val.extended_name"
                        deleted
                      ></ui-chips>
                      <ui-chips
                        class="wg-multiple-transport__chips__blue"
                        @onDeleted="isClickCheckbox"
                        v-for="(val, key) in brands"
                        :key="val.type+key"
                        v-if="val.check"
                        :name="val.type+'[]'"
                        :value="val.id"
                        :caption="val.extended_name"
                        deleted
                      ></ui-chips>
                      <ui-chips
                        class="wg-multiple-transport__chips__green"
                        @onDeleted="isClickCheckbox"
                        v-for="(val, key) in models"
                        :key="val.type+key"
                        v-if="val.check"
                        :name="val.type+'[]'"
                        :value="val.id"
                        :caption="val.extended_name"
                        deleted
                      ></ui-chips>
                    </div>
                  </div>
                </div>
              </div>
              <div class="ui-modal-window__footer">
                <!-- <div @click="AllModel" class="ui-button ui-button_blue">
                  все города
                </div>
                <div @click="AllBrand" class="ui-button ui-button_blue">
                  все регионы
                </div>-->
                <div v-if="modCompleted" @click="isClear" class="ui-button ui-button_blue">Очистить</div>
                <div @click="onInsert" class="ui-button ui-button_blue">OK</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </ui-blind>
  </div>
</template>
<script>
export default {
  data() {
    return {
      dSearth: "",
      dCaption: this.caption,
      showModal: false,
      dDisabled: false,
      transports: this.$store.state.transports.transports.map(transport => {
        return {
          id: transport.id,
          type: "transports",
          name: transport.name,
          extended_name: transport.extended_name,
          check: this.pTransport.some(e => e == transport.id)
        };
      }),
      brands: this.$store.state.transports.brands.map(brand => {
        return {
          id: brand.id,
          id_transport: brand.transport_id,
          type: "brands",
          name: brand.name,
          extended_name: brand.extended_name,
          check: this.pBrand.some(e => e == brand.id)
        };
      }),
      models: this.$store.state.transports.models.map(model => {
        return {
          id: model.id,
          id_transport: model.transport_id,
          id_brand: model.brand_id,
          type: "models",
          name: model.name,
          extended_name: model.extended_name,
          check: this.pModel.some(e => e == model.id)
        };
      })
    };
  },
  props: {
    caption: {
      type: String,
      default: ""
    },
    pTransport: {
      type: Array,
      default: () => []
    },
    pBrand: {
      type: Array,
      default: () => []
    },
    pModel: {
      type: Array,
      default: () => []
    }
  },
  watch: {
    pTransport(newQ) {
      this.pTransport = newQ;
    },
    pBrand(newQ) {
      this.pBrand = newQ;
    },
    pModel(newQ) {
      this.pModel = newQ;
    }
  },

  methods: {
    getTransport(id) {
      return this.$store.getters["transports/getTransport"](id);
    },
    getBrand(id) {
      return this.$store.getters["transports/getBrand"](id);
    },
    getModel(id) {
      return this.$store.getters["transports/getModel"](id);
    },

    AllModel() {
      this.models = this.models.map(model => {
        model.check = true;
        return model;
      });
    },
    AllBrand() {
      this.brands = this.brands.map(brand => {
        brand.check = true;
        return brand;
      });
    },
    isClear() {
      this.transports = this.transports.map(e => {
        e.check = false;
        return e;
      });
      this.brands = this.brands.map(e => {
        e.check = false;
        return e;
      });
      this.models = this.models.map(e => {
        e.check = false;
        return e;
      });
    },
    isSearch(search) {
      this.dSearth = search;
    },
    isClickCheckbox(checkbox) {
      if (checkbox.name == "transports[]") {
        this.isChecktransport(checkbox.checked, checkbox.value);
        // установить brands и models данной страны в обратное положение
        if (checkbox.checked == true) {
          this.isCheckbrandForCounry(false, checkbox.value);
          this.isCheckmodelFortransport(false, checkbox.value);
        }
      }
      if (checkbox.name == "brands[]") {
        this.isCheckbrand(checkbox.checked, checkbox.value);
        // проверить все brands данной страны
        // если все отмечены снять с них отметку
        // и установить ее на страну
        let id_transport = this.brands.filter(brand => {
          return brand.id == checkbox.value;
        })[0].id_transport;
        let allCheck = this.brands
          .filter(brand => {
            return brand.id_transport == id_transport;
          })
          .every(brand => {
            return brand.check == true;
          });
        if (allCheck == true) {
          setTimeout(() => {
            this.isChecktransport(true, id_transport);
            this.isCheckbrandForCounry(false, id_transport);
            this.isCheckmodelFortransport(false, id_transport);
          }, 4);
        } else {
          this.isChecktransport(false, id_transport);
        }
        // установить models данного региона в обратное положение
        if (checkbox.checked == true) {
          this.isCheckmodelForbrand(false, checkbox.value);
        }
      }
      if (checkbox.name == "models[]") {
        this.isCheckmodel(checkbox.checked, checkbox.value);
        let sub = this.models.filter(model => {
          return model.id == checkbox.value;
        })[0];
        let id_brand = sub.id_brand;
        let id_transport = sub.id_transport;
        let allCheck = this.models
          .filter(model => {
            return model.id_brand == id_brand;
          })
          .every(model => {
            return model.check == true;
          });
        if (allCheck == true) {
          setTimeout(() => {
            this.models.map(model => {
              if (model.id_brand == id_brand) {
                model.check = false;
              }
              return model;
            });
            let checkbox = {
              name: "brands[]",
              value: id_brand,
              checked: true
            };
            this.isClickCheckbox(checkbox);
          }, 4);
        } else {
          let checkbox = {
            name: "brands[]",
            value: id_brand,
            checked: false
          };
          this.isClickCheckbox(checkbox);
        }
      }
    },
    isChecktransport(check, id) {
      this.transports = this.transports.map(transport => {
        if (transport.id == id) {
          transport.check = check;
          return transport;
        } else {
          return transport;
        }
      });
    },
    isCheckbrand(check, id) {
      this.brands = this.brands.map(brand => {
        if (brand.id == id) {
          brand.check = check;
          return brand;
        } else {
          return brand;
        }
      });
    },
    isCheckbrandForCounry(check, id_transport) {
      this.brands = this.brands.map(brand => {
        if (brand.id_transport == id_transport) {
          brand.check = check;
          return brand;
        } else {
          return brand;
        }
      });
    },
    isCheckmodel(check, id) {
      this.models = this.models.map(model => {
        if (model.id == id) {
          model.check = check;
          return model;
        } else {
          return model;
        }
      });
    },
    isCheckmodelFortransport(check, id_transport) {
      this.models = this.models.map(model => {
        if (model.id_transport == id_transport) {
          model.check = check;
          return model;
        } else {
          return model;
        }
      });
    },
    isCheckmodelForbrand(check, id_brand) {
      this.models = this.models.map(model => {
        if (model.id_brand == id_brand) {
          model.check = check;
          return model;
        } else {
          return model;
        }
      });
    },
    onDeletedChip(checkbox) {
      this.isClickCheckbox(checkbox);
      this.onInsert();
    },
    onInsert() {
      this.showModal = false;
      let transports = this.transports.filter(transport => {
        return transport.check == true;
      });
      let brands = this.brands.filter(brand => {
        return brand.check == true;
      });
      let models = this.models.filter(model => {
        return model.check == true;
      });
      this.$emit("onInsert", {
        transports: JSON.parse(JSON.stringify(transports)),
        brands: JSON.parse(JSON.stringify(brands)),
        models: JSON.parse(JSON.stringify(models))
      });
    }
  },
  computed: {
    modCompleted() {
      if (
        this.transports.filter(e => e.check).length > 0 ||
        this.brands.filter(e => e.check).length > 0 ||
        this.models.filter(e => e.check).length > 0
      ) {
        return true;
      }
      return false;
    },
    menuSearch() {
      if (this.dSearth != "" && this.dSearth != undefined) {
        let regexp = new RegExp("^" + this.dSearth, "i");
        let menuCount = this.transports.filter(countre => {
          return -1 != countre.name.search(regexp);
        });
        let menuSubj = this.brands.filter(brand => {
          return -1 != brand.name.search(regexp);
        });
        let menuSettl = this.models.filter(model => {
          return -1 != model.name.search(regexp);
        });
        let arr = new Array();
        return arr.concat(menuCount, menuSubj, menuSettl);
      }
      return [];
    }
  }
};
</script>
