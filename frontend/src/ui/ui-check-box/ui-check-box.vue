<template>
	<div class="ui-checkbox"
	     @click="isClick()">
		<span class="ui-checkbox__check"
		      :class="{'ui-checkbox__check_disabled': dDisabled,
                    'ui-checkbox__check_disabled_checked': dChecked && dDisabled,
                    'ui-checkbox__check_checked': dChecked && !dDisabled}">
			<i class="fa fa-check"
			   aria-hidden="true"></i>
		</span>
		<input class="ui-checkbox__input"
		       type="checkbox"
		       :name="dName"
		       :disabled="dDisabled"
		       :checked="dChecked"
		       :value="dValue" />
		<span class="ui-checkbox__caption"
		      :class="{'ui-checkbox__caption_disabled': dDisabled}">
			<slot></slot>
		</span>
	</div>
</template>
<script>
export default {
  name: "uiCheckBox",
  data() {
    return {
      dChecked: this.checked,
      dName: this.name,
      dValue: this.value,
      dDisabled: this.disabled
    };
  },
  methods: {
    isClick() {
      if (this.dDisabled == false) {
        this.dChecked = !this.dChecked;
      }
      this.$emit("onClick", this.dChecked);
    }
  },

  props: {
    name: {
      type: String,
      default: ""
    },
    value: {
      type: String,
      default: ""
    },
    checked: {
      type: Boolean,
      default: false
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  watch: {
    checked(newQ, oldQ) {
      this.dChecked = newQ;
      // console.log(newQ);
    },
    value(newQ) {
      this.dValue = newQ;
    }
  }
};
</script>
