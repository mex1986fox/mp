<template>
  <div v-show="dShow" class="wg-autopag-ad">
    <ui-loader></ui-loader>
    <div class="wg-autopag-ad__title">Загрузка</div>
  </div>
</template>
<script>
export default {
  name: "wg-autopag-ad",
  data() {
    return {
      dShow: this.show
    };
  },
  props: {
    show: {
      type: Boolean,
      default: false
    }
  },
  watch: {
    show(newQ) {
      this.dShow = newQ;
    }
  },
  mounted() {
    window.document.addEventListener("scroll", () => {
      if (
        document.documentElement.scrollHeight <=
        this.getCoordsTop(this.$el) + document.documentElement.clientHeight
      ) {
        this.dShow = true;
        this.$emit("onLoad");
      }
    });
  },
  methods: {
    getCoordsTop(elem) {
      var body = document.body;
      var docEl = document.documentElement;
      var scrollTop = window.pageYOffset || docEl.scrollTop || body.scrollTop;
      var clientTop = docEl.clientTop || body.clientTop || 0;
      var top = scrollTop - clientTop;

      return top;
    }
  }
};
</script>
