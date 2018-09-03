<template>
    <li class="ui-opening-list-block" >
        <slot></slot>
    </li>
</template>
<script>
export default {
  name: "uiOpeningListBlock",
  data(){
      return{
          liShow: false
      }
  }

};
</script>
<style lang="scss">
.ui-opening-list-block {
    list-style-type: none;
    padding-left: 20px;
    margin-top: 15px;
    margin-bottom: 15px;
}
</style>
