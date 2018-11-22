<template>
  <div class="wg-multiple-location">
    <span
      class="ui-text__caption wg-multiple-location__caption"
      :class="{ 'ui-text__caption_completed wg-multiple-location__caption_completed':modCompleted,
            'ui-text__caption_active wg-multiple-location__caption_active':showModal, 
                  
                   'ui-text__caption_disabled':dDisabled}"
    >{{dCaption}}</span>
    <div class="wg-multiple-location__container">
      <ui-chips
        class="wg-multiple-location__chips__red"
        @onDeleted="isClickCheckbox"
        v-for="(val, key) in countries"
        :key="val.type+'ch2'+key"
        v-if="val.check"
        :name="val.type+'[]'"
        :value="val.id"
        :caption="val.extended_name"
        deleted
      ></ui-chips>
      <ui-chips
        class="wg-multiple-location__chips__blue"
        @onDeleted="isClickCheckbox"
        v-for="(val, key) in subjects"
        :key="val.type+'ch2'+key"
        v-if="val.check"
        :name="val.type+'[]'"
        :value="val.id"
        :caption="val.extended_name"
        deleted
      ></ui-chips>
      <ui-chips
        class="wg-multiple-location__chips__green"
        @onDeleted="isClickCheckbox"
        v-for="(val, key) in settlements"
        :key="val.type+'ch2'+key"
        v-if="val.check"
        :name="val.type+'[]'"
        :value="val.id"
        :caption="val.extended_name"
        deleted
      ></ui-chips>
    </div>
    <hr
      class="ui-text__border wg-multiple-location__border"
      :class="{'ui-text__border_active':showModal,
                  'ui-text__border_disabled':dDisabled}"
    >
    <div
      @click="showModal=true"
      class="ui-button ui-button_circle ui-button_circle_mini ui-button_blue wg-multiple-location__button"
    >
      <i class="fa fa-map-marker" aria-hidden="true"></i>
    </div>
    <ui-blind :show="showModal" @onHide="onInsert" :centering="true" animate="opacity">
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
                </div>Местоположение
              </div>
              <div class="ui-modal-window__content">
                <div class="row">
                  <div class="col_12">
                    <ui-search
                      :placeholder="'Страна, Регион, Город'"
                      :showMenu="menuSearch.length>0"
                      @onInput="isSearch"
                    >
                      <div class="wg-multiple-location__menu">
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
                    <div class="wg-multiple-location__chips-container">
                      <ui-chips
                        class="wg-multiple-location__chips__red"
                        @onDeleted="isClickCheckbox"
                        v-for="(val, key) in countries"
                        :key="val.type+key"
                        v-if="val.check"
                        :name="val.type+'[]'"
                        :value="val.id"
                        :caption="val.extended_name"
                        deleted
                      ></ui-chips>
                      <ui-chips
                        class="wg-multiple-location__chips__blue"
                        @onDeleted="isClickCheckbox"
                        v-for="(val, key) in subjects"
                        :key="val.type+key"
                        v-if="val.check"
                        :name="val.type+'[]'"
                        :value="val.id"
                        :caption="val.extended_name"
                        deleted
                      ></ui-chips>
                      <ui-chips
                        class="wg-multiple-location__chips__green"
                        @onDeleted="isClickCheckbox"
                        v-for="(val, key) in settlements"
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
                <!-- <div @click="AllCity" class="ui-button ui-button_blue">
                  все города
                </div>
                <div @click="AllRegion" class="ui-button ui-button_blue">
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
      countries: this.$store.state.locations.countries.map(country => {
        return {
          id: country.id,
          type: "countries",
          name: country.name,
          extended_name: country.extended_name,
          check: this.pCountry.some(e => e == country.id)
        };
      }),
      subjects: this.$store.state.locations.subjects.map(subject => {
        return {
          id: subject.id,
          id_country: subject.country_id,
          type: "subjects",
          name: subject.name,
          extended_name: subject.extended_name,
          check: this.pSubject.some(e => e == subject.id)
        };
      }),
      settlements: this.$store.state.locations.settlements.map(settlement => {
        return {
          id: settlement.id,
          id_country: settlement.country_id,
          id_subject: settlement.subject_id,
          type: "settlements",
          name: settlement.name,
          extended_name: settlement.extended_name,
          check: this.pSettlement.some(e => e == settlement.id)
        };
      })
    };
  },
  props: {
    caption: {
      type: String,
      default: ""
    },
    pCountry: {
      type: Array,
      default: () => []
    },
    pSubject: {
      type: Array,
      default: () => []
    },
    pSettlement: {
      type: Array,
      default: () => []
    }
  },
  watch: {
    pCountry(newQ) {
      this.pCountry = newQ;
    },
    pSubject(newQ) {
      this.pSubject = newQ;
    },
    pSettlement(newQ) {
      this.pSettlement = newQ;
    }
  },

  methods: {
    getCountry(id) {
      return this.$store.getters["locations/getCountry"](id);
    },
    getSubject(id) {
      return this.$store.getters["locations/getSubject"](id);
    },
    getSettlement(id) {
      return this.$store.getters["locations/getSettlement"](id);
    },

    AllCity() {
      this.settlements = this.settlements.map(settlement => {
        settlement.check = true;
        return settlement;
      });
    },
    AllRegion() {
      this.subjects = this.subjects.map(subject => {
        subject.check = true;
        return subject;
      });
    },
    isClear() {
      this.countries = this.countries.map(e => {
        e.check = false;
        return e;
      });
      this.subjects = this.subjects.map(e => {
        e.check = false;
        return e;
      });
      this.settlements = this.settlements.map(e => {
        e.check = false;
        return e;
      });
    },
    isSearch(search) {
      this.dSearth = search;
    },
    isClickCheckbox(checkbox) {
      if (checkbox.name == "countries[]") {
        this.isCheckCountry(checkbox.checked, checkbox.value);
        // установить subjects и settlements данной страны в обратное положение
        if (checkbox.checked == true) {
          this.isCheckSubjectForCounry(false, checkbox.value);
          this.isCheckSettlementForCountry(false, checkbox.value);
        }
      }
      if (checkbox.name == "subjects[]") {
        this.isCheckSubject(checkbox.checked, checkbox.value);
        // проверить все Subjects данной страны
        // если все отмечены снять с них отметку
        // и установить ее на страну
        let id_country = this.subjects.filter(subject => {
          return subject.id == checkbox.value;
        })[0].id_country;
        let allCheck = this.subjects
          .filter(subject => {
            return subject.id_country == id_country;
          })
          .every(subject => {
            return subject.check == true;
          });
        if (allCheck == true) {
          setTimeout(() => {
            this.isCheckCountry(true, id_country);
            this.isCheckSubjectForCounry(false, id_country);
            this.isCheckSettlementForCountry(false, id_country);
          }, 4);
        } else {
          this.isCheckCountry(false, id_country);
        }
        // установить settlements данного региона в обратное положение
        if (checkbox.checked == true) {
          this.isCheckSettlementForSubject(false, checkbox.value);
        }
      }
      if (checkbox.name == "settlements[]") {
        this.isCheckSettlement(checkbox.checked, checkbox.value);
        let sub = this.settlements.filter(settlement => {
          return settlement.id == checkbox.value;
        })[0];
        let id_subject = sub.id_subject;
        let id_country = sub.id_country;
        let allCheck = this.settlements
          .filter(settlement => {
            return settlement.id_subject == id_subject;
          })
          .every(settlement => {
            return settlement.check == true;
          });
        if (allCheck == true) {
          setTimeout(() => {
            this.settlements.map(settlement => {
              if (settlement.id_subject == id_subject) {
                settlement.check = false;
              }
              return settlement;
            });
            let checkbox = {
              name: "subjects[]",
              value: id_subject,
              checked: true
            };
            this.isClickCheckbox(checkbox);
          }, 4);
        } else {
          let checkbox = {
            name: "subjects[]",
            value: id_subject,
            checked: false
          };
          this.isClickCheckbox(checkbox);
        }
      }
    },
    isCheckCountry(check, id) {
      this.countries = this.countries.map(country => {
        if (country.id == id) {
          country.check = check;
          return country;
        } else {
          return country;
        }
      });
    },
    isCheckSubject(check, id) {
      this.subjects = this.subjects.map(subject => {
        if (subject.id == id) {
          subject.check = check;
          return subject;
        } else {
          return subject;
        }
      });
    },
    isCheckSubjectForCounry(check, id_country) {
      this.subjects = this.subjects.map(subject => {
        if (subject.id_country == id_country) {
          subject.check = check;
          return subject;
        } else {
          return subject;
        }
      });
    },
    isCheckSettlement(check, id) {
      this.settlements = this.settlements.map(settlement => {
        if (settlement.id == id) {
          settlement.check = check;
          return settlement;
        } else {
          return settlement;
        }
      });
    },
    isCheckSettlementForCountry(check, id_country) {
      this.settlements = this.settlements.map(settlement => {
        if (settlement.id_country == id_country) {
          settlement.check = check;
          return settlement;
        } else {
          return settlement;
        }
      });
    },
    isCheckSettlementForSubject(check, id_subject) {
      this.settlements = this.settlements.map(settlement => {
        if (settlement.id_subject == id_subject) {
          settlement.check = check;
          return settlement;
        } else {
          return settlement;
        }
      });
    },
    onInsert() {
 
      this.showModal = false;
      let countries = this.countries.filter(country => {
        return country.check == true;
      });
      let settlements = this.settlements.filter(settlement => {
        return settlement.check == true;
      });
      let subjects = this.subjects.filter(subject => {
        return subject.check == true;
      });
      this.$emit("onInsert", {
        countries: countries,
        settlements: settlements,
        subjects: subjects
      });
    }
  },
  computed: {
    modCompleted() {
      if (
        this.countries.filter(e => e.check).length > 0 ||
        this.subjects.filter(e => e.check).length > 0 ||
        this.settlements.filter(e => e.check).length > 0
      ) {
        return true;
      }
      return false;
    },
    menuSearch() {
      if (this.dSearth != "" && this.dSearth != undefined) {
        let regexp = new RegExp("^" + this.dSearth, "i");
        let menuCount = this.countries.filter(countre => {
          return -1 != countre.name.search(regexp);
        });
        let menuSubj = this.subjects.filter(subject => {
          return -1 != subject.name.search(regexp);
        });
        let menuSettl = this.settlements.filter(settlement => {
          return -1 != settlement.name.search(regexp);
        });
        let arr = new Array();
        return arr.concat(menuCount, menuSubj, menuSettl);
      }
      return [];
    }
  }
};
</script>
