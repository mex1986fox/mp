<template>
  <div class="ui-accordion">
    <ui-list>

      <!-- Заголовок -->
      <li class="ui-list__item">
        <!-- иконка заголовка -->
        <slot name="ui-accordion__icon">

        </slot>
        <!-- описание заголовка -->
        <span class="ui-list__caption">

          <span class="ui-accordion__header" @click="isContentShow()">

            <slot name="ui-accordion__header">
            Заголовок
            </slot>
            <span class="ui-accordion__angel">
                <i class="fa" :class="{'fa-angle-up': show, 'fa-angle-down': !show}"></i>
            </span>
          </span>
          

        </span>
        <!-- событие заголовка, например чекбокс -->
        <slot name="ui-accordion__action">
        </slot>
      </li>

      <!-- контент -->
      <transition  name="content">
          <li  class="ui-list__item" ref="content" v-if="show">
            <span class="ui-list__caption ">
              <slot name="ui-accordion__content">
              </slot>
            </span>
          </li>
      </transition>
    </ui-list>
  </div>
</template>
<script>
export default {
  data(){
    return{
      show: this.contentShow?true:false
    }
  },
  props:{
    contentShow:{
      type: Boolean,
      default: false
    }
  },
  methods:{
    isContentShow(){
      this.show=!this.show;
      if(this.show){
        this.$emit("onContentShow");
      }else{
        this.$emit("onContentHide");
      }
    }
  }

};
</script>
