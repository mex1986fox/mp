<template>
  <div class="wg-multiple-location">
    <span class="ui-text__caption wg-multiple-location__caption" :class="{ 'ui-text__caption_completed':modCompleted,
            'ui-text__caption_active':showModal, 
                  
                   'ui-text__caption_disabled':dDisabled}">
      {{dCaption}}
    </span>
    <div class="wg-multiple-location__container">
      <ui-chips @onDeleted="isClickCheckbox" v-for="(val, key) in countries" :key="val.type+key" :name="val.type+'[]'" :value="val.id" :caption="val.name" deleted>
      </ui-chips>
      <ui-chips @onDeleted="isClickCheckbox" v-for="(val, key) in subjects" :key="val.type+key" :name="val.type+'[]'" :value="val.id" :caption="val.name" deleted>
      </ui-chips>
      <ui-chips @onDeleted="isClickCheckbox" v-for="(val, key) in settlements" :key="val.type+key" :name="val.type+'[]'" :value="val.id" :caption="val.name" deleted>
      </ui-chips>
    </div>
    <hr class="ui-text__border wg-multiple-location__border" :class="{'ui-text__border_active':showModal,
                  'ui-text__border_disabled':dDisabled}">
    <div @click="showModal=true" class="ui-button  ui-button_circle ui-button_circle_mini ui-button_blue wg-multiple-location__button">
      <i class="fa fa-map-marker" aria-hidden="true"></i>
    </div>
    <ui-blind :show="showModal" @onHide="showModal=false" :centering="true" animate="opacity">
      <div class="container">
        <div class="row">
          <div class="col_4 col_offset-4 col-phone_6 col-phone_offset-0">

            <!--модальное окно-->
            <div class="ui-modal-window">
              <div class="ui-modal-window__header">
                <div @click="showModal=false" class="ui-button ui-button_circle ui-button_circle_mini 
                                       ui-button_flat ui-modal-window__header__button">
                  <i class="fa fa-times" aria-hidden="true"></i>
                </div>
                Местоположение
              </div>
              <div class="ui-modal-window__content">
                <div class="row">
                  <div class="col_12">
                    <ui-search :placeholder="'Страна, Регион, Город'" :showMenu="menuSearch.length>0" @onInput="isSearch">
                      <div class="wg-multiple-location__menu">
                        <ui-check-box @onClick="isClickCheckbox" v-for="(val, key) in menuSearch" :key="val.type+key" :checked="val.checked" :name="val.type+'[]'" :value="val.id">
                          {{val.name}}
                        </ui-check-box>
                      </div>
                    </ui-search>
                    <div class="wg-multiple-location__chips-container">
                      <ui-chips @onDeleted="isClickCheckbox" v-for="(val, key) in countries" :key="val.type+key" :name="val.type+'[]'" :value="val.id" :caption="val.name" deleted>
                      </ui-chips>
                      <ui-chips @onDeleted="isClickCheckbox" v-for="(val, key) in subjects" :key="val.type+key" :name="val.type+'[]'" :value="val.id" :caption="val.name" deleted>
                      </ui-chips>
                      <ui-chips @onDeleted="isClickCheckbox" v-for="(val, key) in settlements" :key="val.type+key" :name="val.type+'[]'" :value="val.id" :caption="val.name" deleted>
                      </ui-chips>
                    </div>
                  </div>
                </div>
              </div>
              <div class="ui-modal-window__footer">
                <div @click="showModal=false" class="ui-button ui-button_blue">
                  OK
                </div>
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
      dSelCountry: this.selectedCountry,
      dSelSubject: this.selectedSubject,
      dSelSettlement: this.selectedSettlement
    };
  },
  props: {
    caption: {
      type: String,
      default: ""
    },
    selectedCountry: {
      type: Array,
      default: () => {
        return [];
      }
    },
    selectedSubject: {
      type: Array,
      default: () => {
        return [];
      }
    },
    selectedSettlement: {
      type: Array,
      default: () => {
        return [];
      }
    }
  },
  watch: {
    selectedCountry(newQ) {
      this.dSelCountry = newQ;
    },
    selectedSubject(newQ) {
      this.dSelSubject = newQ;
    },
    selectedSettlement(newQ) {
      this.dSelSettlement = newQ;
    }
  },
  methods: {
    isSearch(search) {
      this.dSearth = search;
    },
    isClickCheckbox(checkbox) {
      if (checkbox.name == "countries[]") {
        this.dSelCountry = this.dSelCountry.filter(element => {
          return element != checkbox.value;
        });
        if (checkbox.checked == true) {
          this.dSelCountry.push(checkbox.value);
        }
      }
      if (checkbox.name == "subjects[]") {
        this.dSelSubject = this.dSelSubject.filter(element => {
          return element != checkbox.value;
        });
        if (checkbox.checked == true) {
          this.dSelSubject.push(checkbox.value);
        }
      }
      if (checkbox.name == "settlements[]") {
        this.dSelSettlement = this.dSelSettlement.filter(element => {
          return element != checkbox.value;
        });
        if (checkbox.checked == true) {
          this.dSelSettlement.push(checkbox.value);
        }
      }
    }
  },
  computed: {
    modCompleted() {
      if (
        this.dSelCountry.length > 0 ||
        this.dSelSubject.length > 0 ||
        this.dSelSettlement.length > 0
      ) {
        return true;
      }
      return false;
    },
    countries() {
      let countries = this.$store.state.locations.countries;
      let menu = countries.filter(country => {
        return this.dSelCountry.some(param => {
          return param == country.id;
        });
      });
      return menu;
    },
    subjects() {
      let subjects = this.$store.state.locations.subjects;
      let menu = subjects.filter(subject => {
        return this.dSelSubject.some(param => {
          return param == subject.id;
        });
      });
      return menu;
    },
    settlements() {
      let settlements = this.$store.state.locations.settlements;
      let menu = settlements.filter(settlement => {
        return this.dSelSettlement.some(param => {
          return param == settlement.id;
        });
      });
      return menu;
    },
    menuSearch() {
      if (this.dSearth != "" && this.dSearth != undefined) {
        let regexp = new RegExp("^" + this.dSearth, "i");
        let countries = this.$store.state.locations.countries;
        let menuCount = countries.filter(countre => {
          return -1 != countre.name.search(regexp);
        });
        menuCount = menuCount.map(country => {
          country.type = "countries";
          country.checked = this.dSelCountry.some(param => {
            return param == country.id;
          });
          return country;
        });
        let subjects = this.$store.state.locations.subjects;
        let menuSubj = subjects.filter(subject => {
          return -1 != subject.name.search(regexp);
        });
        menuSubj = menuSubj.map(subject => {
          subject.type = "subjects";
          subject.checked = this.dSelSubject.some(param => {
            return param == subject.id;
          });
          return subject;
        });
        let settlements = this.$store.state.locations.settlements;
        let menuSettl = settlements.filter(settlement => {
          return -1 != settlement.name.search(regexp);
        });
        menuSettl = menuSettl.map(settlement => {
          settlement.type = "settlements";
          settlement.checked = this.dSelSettlement.some(param => {
            return param == settlement.id;
          });
          return settlement;
        });
        return Array.concat(menuCount, menuSubj, menuSettl);
      }
      return [];
    }
  }
};
</script>
