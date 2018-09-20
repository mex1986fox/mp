<template>
	<div class="wg-multiple-location">
		<span class="ui-text__caption wg-multiple-location__caption"
		      :class="{ 'ui-text__caption_completed':modCompleted,
            'ui-text__caption_active':showModal, 
                  
                   'ui-text__caption_disabled':dDisabled}">
			{{dCaption}}
		</span>
		<div class="wg-multiple-location__container">
			<ui-chips v-if="country!=undefined"
			          name="country"
			          :value="dSelCountry"
			          :caption="country.name">
			</ui-chips>
			<ui-chips v-if="subject!=undefined"
			          name="subject"
			          :value="dSelSubject"
			          :caption="subject.name">
			</ui-chips>
			<ui-chips v-if="settlement!=undefined"
			          name="settlement"
			          :value="dSelSettlement"
			          :caption="settlement.name">
			</ui-chips>

		</div>
		<hr class="ui-text__border wg-multiple-location__border"
		    :class="{'ui-text__border_active':showModal,
                  'ui-text__border_disabled':dDisabled}">
		<div @click="showModal=true"
		     class="ui-button  ui-button_circle ui-button_circle_mini ui-button_blue wg-multiple-location__button">
			<i class="fa fa-map-marker"
			   aria-hidden="true"></i>
		</div>
		<ui-blind :show="showModal"
		          @onHide="showModal=false"
		          :centering="true"
		          animate="opacity">
			<div class="container">
				<div class="row">
					<div class="col_4 col_offset-4 col-phone_6 col-phone_offset-0">

						<!--модальное окно-->
						<div class="ui-modal-window">
							<div class="ui-modal-window__header">
								<div @click="showModal=false"
								     class="ui-button ui-button_circle ui-button_circle_mini 
                                       ui-button_flat ui-modal-window__header__button">
									<i class="fa fa-times"
									   aria-hidden="true"></i>
								</div>
								Местоположение
							</div>
							<div class="ui-modal-window__content">
								<div class="row">
									<div class="col_12">
										<ui-search :showMenu="menuSearch.length>0"
										           @onInput="isSearch">
											<div class="wg-multiple-location__menu">
												<ui-check-box @onClick="isClickChekbox"
												              v-for="(val, key) in menuSearch"
												              :key="key"
												              :name="val.type+'[]'"
												              :value="val.id">
													{{val.name}}
												</ui-check-box>
											</div>
										</ui-search>
									</div>
								</div>
							</div>
							<div class="ui-modal-window__footer">
								<div @click="showModal=false"
								     class="ui-button ui-button_blue">
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
    isSearch(search) {
      this.dSearth = search;
    },
    isClickChekbox() {},
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
    menuSearch() {
      if (this.dSearth != "" && this.dSearth != undefined) {
        let regexp = new RegExp("^" + this.dSearth, "i");

        let countries = this.$store.state.locations.countries;
        let menuCount = countries.filter(countre => {
          return -1 != countre.name.search(regexp);
        });
        menuCount = menuCount.map(country => {
          country.type = "countries";
          return country;
        });
        let subjects = this.$store.state.locations.subjects;
        let menuSubj = subjects.filter(subject => {
          return -1 != subject.name.search(regexp);
        });
        menuSubj = menuSubj.map(subject => {
          subject.type = "subjects";
          return subject;
        });
        let settlements = this.$store.state.locations.settlements;
        let menuSettl = settlements.filter(settlement => {
          return -1 != settlement.name.search(regexp);
        });
        menuSettl = menuSettl.map(settlement => {
          settlement.type = "settlements";
          return settlement;
        });
        return Array.concat(menuCount, menuSubj, menuSettl);
      }
      return [];
    }
  }
};
</script>
