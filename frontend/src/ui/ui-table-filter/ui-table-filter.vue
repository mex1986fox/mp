<template>
<div class="ui-table-filter">
  <div class="ui-border_5">
  <div class="ui-table-filter__title">
      {{title}}


  </div>
  <div class="ui-table-filter__search">
    <input v-model="input" class="ui-table-filter__text" type="text" name="" id="">
  <div class="ui-table-filter__button">
    <button @click="sortDirect()"
            class="ui-button ui-button_circle
            ui-button_mini ui-button_flat ">
      <i class="fa" :class="{'fa-angle-down': !sort, 'fa-angle-up': sort}"></i>
    </button>
  </div>
  </div>

  </div>
</div>
</template>
<script>
export default {
  data() {
    return {
      propKey: this.searchKey ? this.searchKey : undefined,
      // propArrObj: this.arreyObjects ? this.arreyObjects : undefined,
      input: undefined,
      sort: false
    };
  },
  computed: {
    propArrObj() {
      return this.arreyObjects ? this.arreyObjects : undefined;
    }
  },
  props: {
    searchKey: String,
    arreyObjects: Array,
    title: String
  },
  watch: {
    input(newQ) {
      let reg = new RegExp(newQ, "i");

      this.propArrObj.filter((elem, key) => {
        if (reg.test(elem[this.propKey])) {
          this.propArrObj[key]["checkHide"] = false;
        } else {
          this.propArrObj[key]["checkHide"] = true;
        }
      });
      this.$emit("onSort", this.propArrObj);
    }
  },
  methods: {
    sortDirect() {
      this.sort = !this.sort;
      let arrObj;
      if (this.sort) {
        arrObj = this.propArrObj.sort((a, b) => {
          if (a[this.searchKey] < b[this.searchKey]) {
            return -1;
          }
          if (a[this.searchKey] > b[this.searchKey]) {
            return 1;
          }
          if ((a[this.searchKey] = b[this.searchKey])) {
            return 0;
          }
        });
      } else {
        arrObj = this.propArrObj.sort((a, b) => {
          if (a[this.searchKey] > b[this.searchKey]) {
            return -1;
          }
          if (a[this.searchKey] < b[this.searchKey]) {
            return 1;
          }
          if ((a[this.searchKey] = b[this.searchKey])) {
            return 0;
          }
        });
      }

      this.$emit("onSort", arrObj);
    }
  }
};
</script>

