<template>
  <div class="wg-select-transport">
    <span
      @click="showModal=true"
      class="ui-text__caption wg-select-transport__caption"
      :class="{ 'ui-text__caption_completed wg-select-transport__caption_completed':modCompleted,
            'ui-text__caption_active wg-select-transport__caption_active':showModal, 
                  
                   'ui-text__caption_disabled':dDisabled}"
    >{{dCaption}}</span>
    <div @click="showModal=true" class="wg-select-transport__container">
      <ui-chips
        class="wg-multiple-transport__chips__red"
        v-if="transport!=undefined"
        name="transport"
        :value="dSelTransport"
        :caption="transport.name"
      ></ui-chips>
      <ui-chips
        class="wg-multiple-transport__chips__blue"
        v-if="brand!=undefined"
        name="brand"
        :value="dSelBrand"
        :caption="brand.name"
      ></ui-chips>
      <ui-chips
        class="wg-multiple-transport__chips__green"
        v-if="model!=undefined"
        name="model"
        :value="dSelModel"
        :caption="model.name"
      ></ui-chips>
    </div>
    <hr
      @click="showModal=true"
      class="ui-text__border wg-select-transport__border"
      :class="{'ui-text__border_active':showModal,
                  'ui-text__border_disabled':dDisabled}"
    >
    <div @click="showModal=true" class="wg-select-transport__button">
      <i aria-hidden="true" class="fa fa-car"></i>
    </div>
    <ui-blind :show="showModal" @onHide="showModal=false" selector=".ui-modal-window" :centering="true" animate="opacity">
      <div class="container">
        <div class="row">
          <div class="col_4 col_offset-4 col-phone_6 col-phone_offset-0">
            <!--модальное окно-->
            <div class="ui-modal-window">
              <div class="ui-modal-window__header">
                <div
                  @click="showModal=false"
                  class="ui-button ui-button_circle ui-button_circle_mini ui-button_flat ui-modal-window__header__button"
                >
                  <i class="fa fa-times" aria-hidden="true"></i>
                </div>Транспорт
              </div>
              <div class="ui-modal-window__content">
                <div class="row">
                  <div class="col_12">
                    <ui-select
                      name="transport"
                      caption="Тип транспорта"
                      :menu="menuTransport"
                      @onSelect="isSelTransport"
                      typesort = "a-z"
                    ></ui-select>
                    <ui-select
                      :disabled="menuBrands==undefined"
                      name="brand"
                      caption="Марка"
                      :menu="menuBrands"
                      @onSelect="isSelBrand"
                      typesort = "a-z"
                    ></ui-select>
                    <ui-select
                      :disabled="menuModels==undefined"
                      name="model"
                      caption="Модель"
                      :menu="menuModels"
                      @onSelect="isSelModel"
                      typesort = "a-z"
                    ></ui-select>
                  </div>
                </div>
              </div>
              <div class="ui-modal-window__footer">
                <div @click="showModal=false" class="ui-button ui-button_blue">OK</div>
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
      dCaption: this.caption,
      showModal: false,
      dDisabled: false,
      dSelTransport: this.selectedTransport,
      dSelBrand: this.selectedBrand,
      dSelModel: this.selectedModel
    };
  },
  props: {
    caption: {
      transport: String,
      default: ""
    },
    selectedTransport: {
      transport: Number,
      default: undefined
    },
    selectedBrand: {
      transport: Number,
      default: undefined
    },
    selectedModel: {
      transport: Number,
      default: undefined
    }
  },
  watch: {
    selectedTransport(newQ) {
      this.isSelTransport(newQ);
    },
    selectedBrand(newQ) {
      this.isSelBrand(newQ);
    },
    selectedModel(newQ) {
      this.isSelModel(newQ);
    }
  },
  methods: {
    isSelTransport(transport) {
      if (Array.isArray(transport)) {
        transport = transport[0].value;
      }
      this.dSelModel = undefined;
      this.dSelBrand = undefined;
      this.dSelTransport = transport;
    },
    isSelBrand(brand) {
      if (Array.isArray(brand)) {
        brand = brand[0].value;
      }
      this.dSelModel = undefined;
      this.dSelBrand = brand;
      this.dSelTransport = this.$store.getters["transports/getBrand"](
        this.dSelBrand
      ).transport_id;
    },
    isSelModel(model) {
      if (Array.isArray(model)) {
        model = model[0].value;
      }
      this.dSelModel = model;
      this.dSelBrand = this.$store.getters["transports/getModel"](
        this.dSelModel
      ).brand_id;
      this.dSelTransport = this.$store.getters["transports/getBrand"](
        this.dSelBrand
      ).transport_id;
    }
  },
  mounted() {
    if (
      this.selectedTransport != undefined &&
      this.selectedBrand == undefined &&
      this.selectedModel == undefined
    ) {
      this.isSelTransport(this.selectedTransport);
    }
    if (this.selectedBrand != undefined && this.selectedModel == undefined) {
      this.isSelBrand(this.selectedBrand);
    }
    if (this.selectedModel != undefined) {
      this.isSelModel(this.selectedModel);
    }
  },
  computed: {
    modCompleted() {
      if (
        this.dSelTransport != undefined ||
        this.dSelBrand != undefined ||
        this.dSelModel != undefined
      ) {
        return true;
      }
      return false;
    },
    transport(id) {
      if (this.dSelTransport != undefined) {
        return this.$store.getters["transports/getTransport"](
          this.dSelTransport
        );
      }
      return undefined;
    },
    brand(id) {
      if (this.dSelBrand != undefined) {
        return this.$store.getters["transports/getBrand"](this.dSelBrand);
      }
      return undefined;
    },
    model(id) {
      if (this.dSelModel != undefined) {
        return this.$store.getters["transports/getModel"](this.dSelModel);
      }
      return undefined;
    },
    menuTransport() {
      let transports = this.$store.state.transports.transports;
      let menu = transports.map(transport => {
        return {
          value: transport.id,
          option: transport.name,
          group: transport.name[0],
          selected: transport.id == this.dSelTransport ? true : false
        };
      });
      return menu;
    },
    menuBrands() {
      if (this.dSelTransport != undefined) {
        let brands = this.$store.state.transports.brands;
        brands = brands.filter(brand => {
          return brand.transport_id == this.dSelTransport;
        });
        let menu = brands.map(brand => {
          return {
            value: brand.id,
            option: brand.name,
            group: brand.name[0],
            selected: brand.id == this.dSelBrand ? true : false
          };
        });
        return menu;
      }
      return undefined;
    },
    menuModels() {
      if (this.dSelTransport != undefined && this.dSelBrand != undefined) {
        let models = this.$store.state.transports.models;
        models = models.filter(model => {
          return model.brand_id == this.dSelBrand;
        });
        let menu = models.map(model => {
          return {
            value: model.id,
            option: model.name,
            group: model.name[0],
            selected: model.id == this.dSelModel ? true : false
          };
        });
        return menu;
      }
      return undefined;
    }
  }
};
</script>
