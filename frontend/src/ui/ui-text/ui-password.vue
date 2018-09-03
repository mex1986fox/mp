<template>
	<div class="ui-password"
	     @click="isClick()">
		<span class="ui-password__caption"
		      :class="{'ui-password__caption_active':modFocus, 
                   'ui-password__caption_completed':modCompleted,
                   'ui-password__caption_disabled':dDisabled}"
		      @click="isClick()">
			{{dCaption}}
		</span>
		<input :type="dTypeInput"
		       class="ui-password__input"
		       :class="{'ui-password__input_active':modFocus,
                   'ui-password__input_disabled':dDisabled}"
		       ref="input"
		       @focus="isFocus()"
		       @blur="isBlur()"
		       @input="isInputText()"
		       :name="dName"
		       :value="dValue"
		       :readonly="dReadonly"
		       :disabled="dDisabled" />
		<hr class="ui-password__border"
		    :class="{'ui-password__border_active':modFocus,
                  'ui-password__border_disabled':dDisabled}">
		<span class="ui-password__help"
		      :class="{'ui-password__help_active':help,
                    'ui-password__help_disabled':dDisabled}"
		      @click="isClick()">
			{{help}}
		</span>
		<span @click="(dShowPass=!dShowPass && !dDisabled)"
		      class="ui-password__eye"
		      :class="{'ui-password__eye_disabled':dDisabled}">
			<i v-if="dShowPass"
			   class="fa fa-eye"
			   aria-hidden="true"></i>
			<i v-if="!dShowPass"
			   class="fa fa-eye-slash"
			   aria-hidden="true"></i>
		</span>
	</div>
</template>

<script>
export default {
  name: "ui-password",
  data() {
    return {
      modFocus: false,
      //modCompleted: false,
      dName: this.name,
      dValue: this.value,
      dCaption: this.caption,
      dDisabled: this.disabled,
      dReadonly: this.readonly,
      dShowPass: false,
      dTypeInput: "password"
    };
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
    caption: {
      type: String,
      default: ""
    },
    readonly: {
      type: Boolean,
      default: false
    },
    help: {
      type: String,
      default: ""
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    isFocus() {
      this.modFocus = true;
      this.$emit("onFocus");
    },
    isBlur() {
      this.modFocus = false;
      this.$emit("onBlur");
    },
    isClick() {
      this.$emit("onClick");
      this.$refs.input.focus();
    },
    isInputText() {
      this.dValue = this.$refs.input.value;
      this.$emit("onInput", this.dValue);
    }
  },
  computed: {
    modCompleted() {
      if (this.dValue == "") {
        return false;
      } else {
        return true;
      }
    }
  },
  watch: {
    value(newQ, oldQ) {
      this.dValue = newQ;
    },
    dShowPass(newQ) {
      if (newQ == true) {
        this.dTypeInput = "text";
      } else {
        this.dTypeInput = "password";
      }
    }
  }
};
</script>
