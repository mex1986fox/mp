<template>
	<div class="ui-textarea"
	     @click="isClick()">
		<span class="ui-textarea__caption"
		      :class="{'ui-textarea__caption_active':modFocus, 
                   'ui-textarea__caption_completed':modCompleted,
                   'ui-textarea__caption_disabled':dDisabled}"
		      @click="isClick()">
			{{dCaption}}
		</span>
		<textarea class="ui-textarea__input"
		          :class="{'ui-textarea__input_active':modFocus,
                   'ui-textarea__input_disabled':dDisabled}"
		          ref="textarea"
		          @focus="isFocus()"
		          @blur="isBlur()"
		          @input="isInputText()"
		          :name="dName"
		          :value="dValue"
		          :readonly="dReadonly"
		          :disabled="dDisabled">

    </textarea>
		<hr class="ui-textarea__border"
      :class="{'ui-textarea__border_active':modFocus,
                  'ui-textarea__border_disabled':dDisabled}">
		<span class="ui-textarea__help"
		      :class="{'ui-textarea__help_active':dHelp,
                    'ui-textarea__help_disabled':dDisabled}"
		      @click="isClick()">
			{{dHelp}}
		</span>
	</div>
</template>

<script>
export default {
  name: "ui-textarea",
  data() {
    return {
      modFocus: false,
      //modCompleted: false,
      dName: this.name,
      dValue: this.value,
      dCaption: this.caption,
      dDisabled: this.disabled,
      dHelp: this.help,
      dReadonly: this.readonly
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
    resize: {
      type: String,
      default: "vertical"
      // both 	Можно растягивать элемент по ширине и высоте.
      // horizontal 	Можно растягивать элемент только по ширине.
      // vertical 	Можно растягивать элемент только по высоте.
      // none 	Изменять размеры элемента нельзя.
      // inherit от родителя
    },
    autoresize: {
      type: Number,
      default: undefined
    },
    disabled: {
      type: Boolean,
      default: false
    },
    height: {
      type: Number,
      default: undefined
    },
    focus: {
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
      this.$refs.textarea.focus();
    },
    isInputText() {
      this.dValue = this.$refs.textarea.value;
      this.isAutoresize();
      this.$emit("onInput", this.dValue);
    },
    isAutoresize() {
      if (
        this.$refs.textarea.clientHeight != undefined &&
        this.$refs.textarea.clientHeight < this.autoresize
      ) {
        let scrollHeigth = this.$refs.textarea.scrollHeight;
        this.$refs.textarea.style.height = scrollHeigth + "px";
      }
      if (this.$refs.textarea.clientHeight < this.height) {
        this.$refs.textarea.style.height = this.height + "px";
      }
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
    }
  },
  mounted() {
    if (this.focus == true) {
      this.modFocus = true;
      let ctrl = this.$refs.textarea;
      ctrl.focus();
    }
    this.$refs.textarea.style.resize = this.resize;
    this.isAutoresize();
  }
};
</script>
