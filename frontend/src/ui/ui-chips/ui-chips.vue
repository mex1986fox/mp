<template>
	<div class="ui-chips"
	     v-if="dSelected"
	     @click="isClick">
		<input class="ui-chips__input"
		       type="checkbox"
		       :name="dName"
		       :checked="dSelected"
		       :value="dValue">
		<div class="ui-chips__icon"
		     v-if="dSrc">
			<img class="ui-chips__img"
			     :class="{'ui-chips__img_disabled':dDisabled}"
			     :src="dSrc"
			     alt="">
		</div>
		<span class="ui-chips__caption"
		      :class="{'ui-chips__caption_disabled':dDisabled}"
		      v-if="dCaption">
			{{dCaption}}
		</span>
		<span class="ui-chips__button"
		      :class="{'ui-chips__button_disabled':dDisabled}"
		      v-if="dDeleted"
		      @click="isDeleted">
			<i class="fa fa-times"
			   aria-hidden="true"></i>
		</span>
	</div>
</template>

<script>
export default {
  name: "uiChips",
  data() {
    return {
      dSrc: this.src,
      dValue: this.value,
      dName: this.name,
      dCaption: this.caption,
      dDeleted: this.deleted,
      dDisabled: this.disabled,
      dSelected: true
    };
  },
  methods: {
    isDeleted() {
      if (!this.dDisabled) {
        this.dSelected = false;
        this.$emit("onDeleted");
      }
    },
    isClick() {
      if (!this.dDisabled) {
        this.$emit("onClick");
      }
    }
  },
  props: {
    src: {
      type: String,
      default: ""
    },
    name: {
      type: String,
      default: ""
    },
    value: {
      type: String,
      default: ""
    },
    caption: {
      type: String,
      default: ""
    },
    deleted: {
      type: Boolean,
      default: false
    },
    disabled: {
      type: Boolean,
      default: false
    }
  }
};
</script>
