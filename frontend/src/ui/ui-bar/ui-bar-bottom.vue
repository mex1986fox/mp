<template>
    <transition name="ui-bar-bottom">
        <div v-show="show==true"
             class="ui-bar-bottom">
            <div class="ui-bar-bottom__content">
                <div class="content">
                    <div class="row">
                        <div class="col_12">
                            <slot>

                            </slot>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </transition>
</template>
<script>
export default {
  data() {
    return {
      show: true
    };
  },
  mounted() {
    document.addEventListener("onTouchTop", () => {
      this.show = true;
    });
    document.addEventListener("onTouchBottom", () => {
      this.show = false;
    });
  }
};
</script>
