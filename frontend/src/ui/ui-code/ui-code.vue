<template>
    <div class="ui-code">
        <span class="ui-code__header">
          <span class="ui-header ui-header_3">{{header}}</span>
        </span>
        <div class="ui-code__text" ref="code"></div>
    </div>
</template>
<script>
export default {
  name: "ui-code",
  data() {
    return {
      code: this.value
    };
  },
  props: {
    value: {
      type: String,
      default: ""
    },
    header: {
      type: String,
      default: function(){return "Пример кода:"}
    }
  },
  mounted() {
    let code = this.value;
    code = code.replace(new RegExp("<", "g"), "&lt");
    code = code.replace(new RegExp(">", "g"), "&gt");
    code = code.replace(/\n/g, "{n}");
    code = code.replace(/\s/g, "&nbsp;");
    code = code.replace(new RegExp("=", "g"), "{=}");
    code = code.replace(
      new RegExp("/", "g"),
      '{/}'
    );
    code = code.replace(/[\"\']{1}[^\"\']*[\"\']{1}/gm,
      '<span style="color:#05d400">$&</span>'
    );
    code = code.replace(
      new RegExp("{=}", "g"),
      '<span style="color:#e28964">=</span>'
    );
    code = code.replace(/{n}/g, "<br/>");
        code = code.replace(
      new RegExp("{/}", "g"),
      '<span style="color:#e28964">/</span>'
    ); 
    this.$refs.code.innerHTML = code;
  }
};
</script>
