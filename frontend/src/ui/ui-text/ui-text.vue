<template>
  <div class="ui-text" @click="isClick()">
    <span class="ui-text__caption" :class="{'ui-text__caption_active':modFocus, 
                   'ui-text__caption_completed':modCompleted,
                   'ui-text__caption_disabled':dDisabled}" @click="isClick()">
      {{dCaption}}
    </span>
    <input class="ui-text__input" :class="{'ui-text__input_active':modFocus,
                   'ui-text__input_disabled':dDisabled}" ref="input" @focus="isFocus()" @blur="isBlur()" @input="isInputText()" :name="dName" :value="dValue" :readonly="dReadonly" :disabled="dDisabled" :maxlength="maxlength" />
    <hr class="ui-text__border" :class="{'ui-text__border_active':modFocus,
                  'ui-text__border_disabled':dDisabled}">
    <span class="ui-text__help" :class="{'ui-text__help_active':help,
                    'ui-text__help_disabled':dDisabled}" @click="isClick()">
      {{help}}
    </span>
  </div>
</template>

<script>
export default {
  name: "ui-text",
  data() {
    return {
      modFocus: false,
      //modCompleted: false,
      dName: this.name,
      dValue: this.value,
      dCaption: this.caption,
      dDisabled: this.disabled,
      dReadonly: this.readonly,
      dCaretStart: this.caretStart,
      dCaretEnd: this.caretEnd
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
    },
    caretStart: {
      type: Number,
      default: undefined
    },
    caretEnd: {
      type: Number,
      default: undefined
    },
    maxlength: {
      type: Number,
      default: undefined
    },
    masc: {
      type: String,
      default: undefined
    }
  },
  methods: {
    setCaret() {
      if (this.dCaretStart != undefined && this.dCaretEnd != undefined) {
        let ctrl = this.$refs.input;
        ctrl.focus();
        ctrl.setSelectionRange(this.dCaretStart, this.dCaretEnd);
      }
    },
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
      this.setCaret();
    },
    isInputText() {
      this.dValue = this.$refs.input.value;
      this.$emit("onInput", this.dValue);
    },
    mascNumber(value) {
      this.dValue = value.replace(/[^-0-9]/gim, "");
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
    dValue(newQ) {
      if (this.masc != undefined) {
        switch (this.masc) {
          case "number":
            this.mascNumber(newQ);
            break;
        }
      }
    },
    caretStart(newQ) {
      this.dCaretStart = newQ;
    },
    caretEnd(newQ) {
      this.dCaretEnd = newQ;
    },
    disabled(newQ) {
      this.dDisabled = newQ;
    }
  },
  updated() {
    if (this.modFocus == true) {
      this.setCaret();
    }
  }
};
</script>
