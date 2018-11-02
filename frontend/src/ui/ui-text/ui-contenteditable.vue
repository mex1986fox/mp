<template>
  <div class="ui-contenteditable" @click="isClick()">
    <span class="ui-contenteditable__caption" :class="{'ui-contenteditable__caption_active':modFocus, 
                   'ui-contenteditable__caption_completed':modCompleted,
                   'ui-contenteditable__caption_disabled':dDisabled}" @click="isClick()">
      {{dCaption}}
    </span>
    <div class="ui-contenteditable__input" :class="{'ui-contenteditable__input_active':modFocus,
                   'ui-contenteditable__input_disabled':dDisabled}" 
                   ref="textarea" 
                   contenteditable="true" 
                   @focus="isFocus()" 
                   @blur="isBlur()" 
                   @input="isInputText()" 
                   @keyup.delete="isInputText()" 
                   :name="dName" 
                   :readonly="dReadonly" 
                   :disabled="dDisabled">

    </div>
    <hr class="ui-contenteditable__border" :class="{'ui-contenteditable__border_active':modFocus,
                  'ui-contenteditable__border_disabled':dDisabled}">
    <span class="ui-contenteditable__help" :class="{'ui-contenteditable__help_active':dHelp,
                    'ui-contenteditable__help_disabled':dDisabled}" @click="isClick()">
      {{dHelp}}
    </span>
  </div>
</template>

<script>
export default {
  name: "ui-contenteditable",
  data() {
    return {
      modFocus: false,
      //modCompleted: false,
      dName: this.name,
      dValue: this.value,
      dCaption: this.caption,
      dDisabled: this.disabled,
      dHelp: this.help,
      dReadonly: this.readonly,
      aNode: undefined,
      aOffset: undefined
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
      this.isAutoresize();
    },
    isBlur() {
      this.modFocus = false;
      this.$emit("onBlur");
      this.isAutoresize();
    },
    isClick() {
      this.$emit("onClick");
      this.$refs.textarea.focus();
      this.isAutoresize();
    },
    isInputText() {
      let rng = document.createRange();
      this.endNode = rng.endContainer.activeElement;
      this.endOffset = rng.endOffset;
      rng.setStart(this.endNode, rng.endOffset+1);
      rng.setEnd(this.endNode, rng.endOffset+1);
      let sel = window.getSelection();
      sel.removeAllRanges();
      sel.addRange(rng);

      // let select = window.getSelection();
      // // if (this.aNode != undefined) {
      // //   select.extend(this.aNode, this.aOffset);
      // //   // select.collapseToStart;
      // // }
      // select.collapseToEnd;
      // this.aNode = select.anchorNode;
      // this.aOffset = select.anchorOffset+1;
      // console.log(this.aNode)
      // console.log(this.aOffset)
      // this.fNode =select.focusNode;
      // this.fOffset = select.focusOffset;

      // console.log(window.getSelection());
      this.dValue = toString(this.$refs.textarea.innerHTML);

      this.isAutoresize();
      this.$emit("onInput", this.dValue);
    },
    isAutoresize() {
      if (this.$refs.textarea.clientHeight < this.autoresize) {
        let scrollHeigth = this.$refs.textarea.scrollHeight;
        this.$refs.textarea.style.height = scrollHeigth + "px";
      }
      if (this.$refs.textarea.clientHeight > this.autoresize) {
        this.$refs.textarea.style.height = this.autoresize + "px";
      }
      if (this.autoresize != undefined && this.dValue == "") {
        this.$refs.textarea.style.height = "30px";
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
      this.$refs.textarea.innerHTML = newQ;
    },
    dValue() {
      // console.log(this.dValue);
      this.isAutoresize();
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
