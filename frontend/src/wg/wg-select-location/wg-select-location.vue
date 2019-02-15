<template>
  <div class="wg-select-location">
    <span
      @click="showModal=true"
      class="ui-text__caption wg-select-location__caption"
      :class="{ 'ui-text__caption_completed wg-select-location__caption_completed':modCompleted,
            'ui-text__caption_active wg-select-location__caption_active':showModal, 
                  
                   'ui-text__caption_disabled':dDisabled}"
    >{{dCaption}}</span>
    <div @click="showModal=true" class="wg-select-location__container">
      <ui-chips
        class="wg-multiple-location__chips__red"
        v-if="country!=undefined"
        name="country"
        :value="dSelCountry"
        :caption="country.name"
      ></ui-chips>
      <ui-chips
        class="wg-multiple-location__chips__blue"
        v-if="subject!=undefined"
        name="subject"
        :value="dSelSubject"
        :caption="subject.name"
      ></ui-chips>
      <ui-chips
        class="wg-multiple-location__chips__green"
        v-if="settlement!=undefined"
        name="settlement"
        :value="dSelSettlement"
        :caption="settlement.name"
      ></ui-chips>
    </div>
    <hr
      @click="showModal=true"
      class="ui-text__border wg-select-location__border"
      :class="{'ui-text__border_active':showModal,
                  'ui-text__border_disabled':dDisabled}"
    >
    <div @click="showModal=true" class="wg-select-location__button">
      <i class="fa fa-map-marker" aria-hidden="true"></i>
    </div>
    <span
      class="ui-text__help ui-text__help_active"
     
      @click="showModal=true"
    >{{help}}</span>

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
                </div>Местоположение
              </div>
              <div class="ui-modal-window__content">
                <div class="row">
                  <div class="col_12">
                    <ui-select
                      name="country"
                      caption="Страна"
                      :menu="menuCountry"
                      @onSelect="isSelCountry"
                      typesort = "a-z"
                    ></ui-select>
                    <ui-select
                      :disabled="menuSubjects==undefined"
                      name="subject"
                      caption="Субъект"
                      :menu="menuSubjects"
                      @onSelect="isSelSubject"
                      typesort = "a-z"
                    ></ui-select>
                    <ui-select
                      :disabled="menuSettlements==undefined"
                      name="settlement"
                      caption="Город"
                      :menu="menuSettlements"
                      @onSelect="isSelSettlement"
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
      type: Number,
      default: undefined
    },
    selectedSubject: {
      type: Number,
      default: undefined
    },
    selectedSettlement: {
      type: Number,
      default: undefined
    },
    help: {
      type: String,
      default: ""
    },
  },
  watch: {
    selectedCountry(newQ) {
      this.isSelCountry(newQ);
    },
    selectedSubject(newQ) {
      this.isSelSubject(newQ);
    },
    selectedSettlement(newQ) {
      this.isSelSettlement(newQ);
    }
  },
  methods: {
    isSelCountry(country) {
      if (Array.isArray(country)) {
        country = country[0].value;
      }
      this.dSelSettlement = undefined;
      this.dSelSubject = undefined;
      this.dSelCountry = country;
    },
    isSelSubject(subject) {
      if (Array.isArray(subject)) {
        subject = subject[0].value;
      }
      this.dSelSettlement = undefined;
      this.dSelSubject = subject;
      this.dSelCountry = this.$store.getters["locations/getSubject"](
        this.dSelSubject
      ).country_id;
    },
    isSelSettlement(settlement) {
      if (Array.isArray(settlement)) {
        settlement = settlement[0].value;
      }
      this.dSelSettlement = settlement;
      this.dSelSubject = this.$store.getters["locations/getSettlement"](
        this.dSelSettlement
      ).subject_id;
      this.dSelCountry = this.$store.getters["locations/getSubject"](
        this.dSelSubject
      ).country_id;
    }
  },
  mounted() {
    if (
      this.selectedCountry != undefined &&
      this.selectedSubject == undefined &&
      this.selectedSettlement == undefined
    ) {
      this.isSelCountry(this.selectedCountry);
    }
    if (
      this.selectedSubject != undefined &&
      this.selectedSettlement == undefined
    ) {
      this.isSelSubject(this.selectedSubject);
    }
    if (this.selectedSettlement != undefined) {
      this.isSelSettlement(this.selectedSettlement);
    }
  },
  computed: {
    modCompleted() {
      if (
        this.dSelCountry != undefined ||
        this.dSelSubject != undefined ||
        this.dSelSettlement != undefined
      ) {
        return true;
      }
      return false;
    },
    country(id) {
      if (this.dSelCountry != undefined) {
        return this.$store.getters["locations/getCountry"](this.dSelCountry);
      }
      return undefined;
    },
    subject(id) {
      if (this.dSelSubject != undefined) {
        return this.$store.getters["locations/getSubject"](this.dSelSubject);
      }
      return undefined;
    },
    settlement(id) {
      if (this.dSelSettlement != undefined) {
        return this.$store.getters["locations/getSettlement"](
          this.dSelSettlement
        );
      }
      return undefined;
    },
    menuCountry() {
      let countries = this.$store.state.locations.countries;
      let menu = countries.map(country => {
        return {
          value: country.id,
          option: country.name,
          group: country.name[0],
          selected: country.id == this.dSelCountry ? true : false
        };
      });
      return menu;
    },
    menuSubjects() {
      if (this.dSelCountry != undefined) {
        let subjects = this.$store.state.locations.subjects;
        subjects = subjects.filter(subject => {
          return subject.country_id == this.dSelCountry;
        });
        let menu = subjects.map(subject => {
          return {
            value: subject.id,
            option: subject.name,
            group: subject.name[0],
            selected: subject.id == this.dSelSubject ? true : false
          };
        });
        return menu;
      }
      return undefined;
    },
    menuSettlements() {
      if (this.dSelCountry != undefined && this.dSelSubject != undefined) {
        let settlements = this.$store.state.locations.settlements;
        settlements = settlements.filter(settlement => {
          return settlement.subject_id == this.dSelSubject;
        });
        let menu = settlements.map(settlement => {
          return {
            value: settlement.id,
            option: settlement.name,
            group: settlement.name[0],
            selected: settlement.id == this.dSelSettlement ? true : false
          };
        });
        return menu;
      }
      return undefined;
    }
  }
};
</script>
