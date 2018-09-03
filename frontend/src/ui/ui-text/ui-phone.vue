<template>
	<div class="ui-phone">
		<ui-text ref="text"
		         :name="name"
		         :value="dValue"
		         :caption="caption"
		         :readonly="readonly"
		         :disabled="disabled"
		         :help="help"
		         @onInput="isInputPhone"
		         :caretStart="dCarret"
		         :caretEnd="dCarret"
		         :maxlength="17">
		</ui-text>
	</div>
</template>

<script>
export default {
  name: "ui-phone",
  data() {
    return {
      dValue: "+8(___)___-__-__",
      dCarret: 3
    };
  },
  props: {
    name: {
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
    isInputPhone(phone) {
      let arrPhone = phone.match(/[0-9]/g);
      if (arrPhone != null) {
        let arrP = [];
        for (let k = 1; k <= 10; k++) {
          if (arrPhone[k] != undefined) {
            arrP[k] = String(arrPhone[k]);
          } else {
            arrP[k] = "_";
          }
        }
        let newPhone =
          "+8(" +
          arrP[1] +
          arrP[2] +
          arrP[3] +
          ")" +
          arrP[4] +
          arrP[5] +
          arrP[6] +
          "-" +
          arrP[7] +
          arrP[8] +
          "-" +
          arrP[9] +
          arrP[10];
        // определяем позицию карретки
        for (let k = 0; k <= newPhone.length; k++) {
          if (newPhone[k] == "_") {
            this.dCarret = k;
            if (k == 3 || k == 7 || k == 11 || k == 14) {
              this.dCarret = k - 1;
            }
            break;
          }
        }
        //   console.log(newPhone);
        this.$refs.text.dValue = newPhone;
      } else {
        this.$refs.text.dValue = "+8(___)___-__-__";
      }
    }
  }
};
</script>
