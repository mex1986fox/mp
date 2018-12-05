<template>
  <div class="ui-text" @click="isClick()">
    <span
      class="ui-text__caption"
      :class="{'ui-text__caption_completed':modCompleted,
            'ui-text__caption_active':modFocus, 
                   
                   'ui-text__caption_disabled':dDisabled}"
      @click="isClick()"
    >{{dCaption}}</span>
    <input
      class="ui-text__input"
      :class="{'ui-text__input_active':modFocus,
                   'ui-text__input_disabled':dDisabled}"
      ref="input"
      @focus="isFocus()"
      @blur="isBlur()"
      @input="isInputText()"
      :name="dName"
      :value="dValue"
      :readonly="dReadonly"
      :disabled="dDisabled"
      :maxlength="maxlength"
    >
    <hr
      class="ui-text__border"
      :class="{'ui-text__border_active':modFocus,
                  'ui-text__border_disabled':dDisabled}"
    >
    <span
      class="ui-text__help"
      :class="{'ui-text__help_active':help,
                    'ui-text__help_disabled':dDisabled}"
      @click="isClick()"
    >{{help}}</span>
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
      type: [Object, String],
      default: undefined
    },
    focus: {
      type: Boolean,
      default: false
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
    mascNumber(val) {
      let newQ = val.replace(/[^0-9]/gim, "");
      if (newQ[0] == 0) {
        newQ = newQ.substr(1);
      }
      if (newQ.length > 4) {
        let spl = newQ.split("");
        spl.splice(-3, 0, " ");
        newQ = spl.join("");
      }
      if (newQ.length > 7) {
        let spl = newQ.split("");
        spl.splice(-7, 0, " ");
        newQ = spl.join("");
      }
      return newQ;
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
      if (newQ == undefined) {
        this.dValue = "";
      } else {
        this.dValue = newQ;
      }
    },
    dValue(newV) {
      if (this.masc != undefined) {
        switch (this.masc) {
          case "mascNumber":
            this.dValue = this.mascNumber(newV);
            break;
          default:
            this.dValue = this.masc.use(newV);
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
  moundet() {
    if (this.focus == true) {
      this.modFocus == true;
      let ctrl = this.$refs.input;
      ctrl.focus();
    }
  },
  updated() {
    if (this.modFocus == true) {
      this.setCaret();
    }
  }
};
</script>
