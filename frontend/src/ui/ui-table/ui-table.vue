<template>
<div class="ui-table">

  <div class="ui-table__header">
    <table class="ui-table__table">
      <thead ref="thead" class="ui-table__theade">
        <slot name="header"></slot>
        <!-- <tr class="ui-table__tr">
          <th class="ui-table__th">Отметки</th>
          <th class="ui-table__th">Количество</th>
          <th class="ui-table__th">Цены</th>
        </tr> -->
      </thead>
    </table>
  </div>

  <div class="ui-table__body">
    <table class="ui-table__table">
      <tbody ref="tbody" class="ui-table__tbody">
        <slot name="body"></slot>
        <!-- <tr class="ui-table__tr">
          <td class="ui-table__td"><ui-check-box></ui-check-box></td>
          <td class="ui-table__td">25</td>
          <td class="ui-table__td">$2.90</td>
        </tr>
        <tr class="ui-table__tr">
          <td class="ui-table__td"><ui-check-box></ui-check-box></td>
          <td class="ui-table__td">50</td>
          <td class="ui-table__td">$1.25</td>
        </tr>
        <tr class="ui-table__tr">
          <td class="ui-table__td"><ui-check-box></ui-check-box></td>
          <td class="ui-table__td">10</td>
          <td class="ui-table__td">$2.35</td>
        </tr> -->
      </tbody>
    </table>
  </div>
</div>
<!-- <div class="ui-table">
  <table class="ui-table__table">
    <thead class="ui-table__theade">
      <slot name="header"></slot>
      <tr class="ui-table__tr">
        <th class="ui-table__th">Отметки</th>
        <th class="ui-table__th">Количество</th>
        <th class="ui-table__th">Цены</th>
      </tr>
    </thead>

    <tbody class="ui-table__tbody">
      <slot name="body"></slot>
       <tr class="ui-table__tr">
        <td class="ui-table__td"><ui-check-box></ui-check-box></td>
        <td class="ui-table__td">25</td>
        <td class="ui-table__td">$2.90</td>
      </tr>
      <tr class="ui-table__tr">
        <td class="ui-table__td"><ui-check-box></ui-check-box></td>
        <td class="ui-table__td">50</td>
        <td class="ui-table__td">$1.25</td>
      </tr>
      <tr class="ui-table__tr">
        <td class="ui-table__td"><ui-check-box></ui-check-box></td>
        <td class="ui-table__td">10</td>
        <td class="ui-table__td">$2.35</td>
      </tr>
    </tbody>

  </table>
</div> -->
</template>
<script>
export default {
  data() {
    return {
      sInt: undefined
    };
  },
  methods: {
    // подгоняет ширину колонок шапки
    // под ширину колонок body
    transformWidthTd() {
      if (this.$refs.thead || this.$refs.tbody) {
        let thCol = this.$refs.thead.getElementsByClassName("ui-table__th");
        let tdCol = this.$refs.tbody.getElementsByClassName("ui-table__td");
        if (tdCol.length != 0) {
          for (let k = 0; k < thCol.length; k++) {

               thCol[k].style.width = tdCol[k].clientWidth + "px";

          }
        }
      }
    }
  },
  mounted() {
    this.transformWidthTd();
    window.addEventListener(
      "resize",
      () => {
        clearTimeout(this.sInt);
        this.sInt = setTimeout(() => {
          this.transformWidthTd();
        }, 100);
      },
      true
    );
  },
  updated() {
    this.transformWidthTd();
  }
};
</script>
<style lang="scss">

</style>
