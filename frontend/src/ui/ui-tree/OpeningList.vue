<template>
  <div >
     <ul class="ui-opening-list" v-for="(val, key) in prListData[0]" :key="key" >
        <span  class="ui-opening-list-header"

              @click="show(val)">
          <span v-on:click.stop="check(val, !val.check)">
            <ui-check-box :checked="val.check"></ui-check-box>
          </span>
          &nbsp;&nbsp;
          {{val.value}}
          <i class="fa"
            :class="{'fa-angle-up': val.show, 'fa-angle-down': !val.show}"
          >
          </i>
        </span>
        <div v-show="val.show">

          <ui-opening-list-block
              v-for="(val2, key2) in prListData[1]" :key="key2"
              v-if="(val.pK===val2.fK && prListData[2])">
            <ui-opening-list :prListData="spl(val2.pK)" :listData="listData">
            </ui-opening-list>
          </ui-opening-list-block >

          <ui-opening-list-block v-else-if="val.pK===val2.fK">
            <span v-on:click.stop="check(val2, !val2.check)">
              <ui-check-box :checked="val2.check" ></ui-check-box>
            </span>
            &nbsp;&nbsp;
            {{val2.value}}
          </ui-opening-list-block>

        </div>
    </ul>
  </div>
</template>
<script>
export default {
  name: "uiOpeningList",
  props: {
    prListData: Array,
    listData: Array
  },
  methods: {
    checkeds(child) {
      child.checked = !child.checked;
    },
    show(subj) {
      this.$store.commit("ads/showRef", { subj: subj, dbLists: this.listData });
    },
    // check(subj, val){
    //   this.$store.commit("ads/check", {subj:subj, dbLists:this.listData, val:val});
    // },
    spl(pK) {
      let newArr = [];
      newArr[0] = this.prListData.slice(1)[0].filter(cit => cit.pK == pK);
      let reg = this.prListData.slice(2);
      return newArr.concat(reg);
    },

    check(subj, val) {
      this.$store.commit("ads/downVal", {linkObj:subj, param:"check", val:val});
      this.bottomCheck(subj, this.listData);
      this.topCheck(subj,  this.listData);
    },
    //проверяет все ли check отмечены
    allCheck(arrObg, fK) {
      for (let k in arrObg) {
        if (!arrObg[k].check && arrObg[k].fK == fK) {
          return false;
          break;
        }
      }
      return true;
    },
    //отмечает check у детей
    bottomCheck(subj, dbLists) {
      let pKey = [];
      let newpKey = [];
      for (let k = 0; k < dbLists.length; k++) {
        for (let j in dbLists[k]) {
          if (
            dbLists[k][j].pK == subj.pK &&
            dbLists[k][j].fK == subj.fK &&
            dbLists[k][j].value == subj.value &&
            pKey.length == 0
          ) {
            newpKey.push(dbLists[k][j].pK);
            break;
          }
          if (pKey.length > 0) {
            for (let p in pKey) {
              if (pKey[p] == dbLists[k][j].fK) {
                this.$store.commit("ads/downVal", {linkObj:dbLists[k][j], param:"check", val:subj.check});
                //dbLists[k][j].check = subj.check;
                newpKey.push(dbLists[k][j].pK);
              }
            }
          }
        }
        pKey = newpKey;
        newpKey = [];
      }
    },
    //отмечает check у родителей
    topCheck(subj, dbLists) {
      let pKey = undefined;
      for (let k = dbLists.length - 1; k >= 0; k--) {
        for (let j in dbLists[k]) {
          if (
            dbLists[k][j].pK == subj.pK &&
            dbLists[k][j].fK == subj.fK &&
            dbLists[k][j].value == subj.value &&
            pKey === undefined
          ) {
            pKey = dbLists[k][j].fK;
            break;
          }
          if (pKey != undefined && pKey == dbLists[k][j].pK) {
            //если все true
            if (subj.check) {
              if (this.allCheck(dbLists[k + 1], dbLists[k][j].pK)) {
                this.$store.commit("ads/downVal", {linkObj:dbLists[k][j], param:"check", val:true});
                //dbLists[k][j].check = true;
              }
            }
            if (!subj.check) {
              this.$store.commit("ads/downVal", {linkObj:dbLists[k][j], param:"check", val:false});
              //dbLists[k][j].check = false;
            }
            pKey = dbLists[k][j].fK;
          }
        }
      }
    }
  },
  updated() {
    if (this.$refs.scrollElem) {
      if (this.$refs.scrollElem[0]) {
        console.log(this.$refs.scrollElem[0].offsetTop);
      }
    }
  }
};
</script>
<style lang="scss">
.ui-opening-list {
  padding-left: 0px;
  overflow: hidden;
  transition-duration: 200ms;
  color: #0e6c9a;
  font-size: 14px;
  white-space: nowrap;
  margin: 15px 0 15px 0;
  &-header {
    cursor: pointer;
  }
}
</style>
