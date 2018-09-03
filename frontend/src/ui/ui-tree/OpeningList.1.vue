<template>
    <ul class="ui-opening-list">
            <span class="ui-opening-list-header" @click="liShow=!liShow">
                <slot name="header">

                </slot>
                <i class="fa" 
                   :class="{'fa-angle-up': liShow, 'fa-angle-down': !liShow}" 
                   aria-hidden="true">
                </i>
            </span>
            <div v-if="liShow">  
                <slot name="blocks">
                    
                </slot>
            </div>
    </ul>  
</template>
<script>
export default {
  name: "uiOpeningList",
  data() {
    return {
      liShow: true
    };
  },
  mounted(){
      this.liShow=this.prLiShow;
  },
  props: ["prLiShow"]
};
</script>
<style lang="scss" scoped>
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
