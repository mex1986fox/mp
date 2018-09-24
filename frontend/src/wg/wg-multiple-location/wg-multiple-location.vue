<template>
	<div class="wg-multiple-location">
		<span class="ui-text__caption wg-multiple-location__caption"
		      :class="{ 'ui-text__caption_completed':modCompleted,
            'ui-text__caption_active':showModal, 
                  
                   'ui-text__caption_disabled':dDisabled}">
			{{dCaption}}
		</span>
		<div class="wg-multiple-location__container">
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
										<ui-search :placeholder="'Страна, Регион, Город'"
										           :showMenu="true"
										           @onInput="isSearch">
											<div class="wg-multiple-location__menu">
												<ui-check-box>
												</ui-check-box>
											</div>
										</ui-search>
										<div class="wg-multiple-location__chips-container">

										</div>
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
      modCompleted: false
    };
  },
  props: {
    caption: {
      type: String,
      default: ""
    },
    pСountry: {
      type: Array,
      default: () => []
    },
    pSubject: {
      type: Array,
      default: () => []
    },
    pSttlement: {
      type: Array,
      default: () => []
    }
  },
  watch: {
    pCountry(newQ) {
      this.dSelCountry = newQ;
    },
    pSubject(newQ) {
      this.dSelSubject = newQ;
    },
    pSettlement(newQ) {
      this.dSelSettlement = newQ;
    }
  },

  methods: {
    isSearch() {}
  },
  computed: {
    countries() {
      return this.$store.state.locations.countries.map(country => {
        return {
          id: country.id,
          name: country.name,
          check: false,
          subjects: this.$store.state.locations.subjects
            .map(subject => {
              if (subject.country_id == country.id) {
                return {
                  id: subject.id,
                  name: subject.name,
                  check: false,
                  settlements: this.$store.state.locations.settlements
                    .map(settlement => {
                      if (settlement.subject_id == subject.id) {
                        return {
                          id: settlement.id,
                          name: settlement.name,
                          check: false
                        };
                      }
                    })
                    .filter(function(x) {
                      return typeof x !== "undefined";
                    })
                };
              }
            })
            .filter(function(x) {
              return typeof x !== "undefined";
            })
        };
      });
    }
  }
};
</script>
