<template>
	<div class="ui-file"
	     tabindex="0"
	     @click="isClickAddFile">
		<input class="ui-file__input"
		       ref="file"
		       type="file"
		       name="file"
		       :accept="accept"
		       multiple>
		<span class="ui-file__caption"
		      :class="{ 'ui-file__caption_completed':modCompleted,
                    'ui-file__caption_disabled':disabled}">
			{{captionCompleted!="" && modCompleted?captionCompleted:caption}}
		</span>
		<div ref="files"
		     class="ui-file__files">
			<div class="ui-file__files-file"
			     v-for="(val, key) in dFiles"
			     :key="key"
			     @click="isSelectFile(key)">
				<div class="ui-file__files-icon">
					<i class="fa fa-file-o"
					   aria-hidden="true"></i>
				</div>
				<div class="ui-file__files-type">
					{{val.type.split("/")[1]}}
				</div>
				<div class="ui-file__files-src">
					{{val.name}}
				</div>
			</div>

		</div>

		<hr class="ui-file__border"
		    :class="{ 'ui-file__border_disabled':disabled}">
		<span v-if="dFiles.length==0"
		      class="ui-file__badge"
		      :class="{'ui-file__badge_disabled':disabled}">
			<i class="fa fa-plus"
			   aria-hidden="true"></i>

		</span>
		<button v-if="dFiles.length>0"
		        @click="isClickEditFile"
		        class="ui-button ui-button_circle ui-button_circle_mini ui-file__edit">
			<i class="fa fa-pencil"
			   aria-hidden="true"></i>
		</button>

	</div>
</template>

<script>
export default {
  name: "ui-file",
  data() {
    return {
      dFiles: [],
      dPath: undefined,
      modCompleted: false
    };
  },
  props: {
    name: {
      type: String,
      default: ""
    },
    caption: {
      type: String,
      default: ""
    },
    captionCompleted: {
      type: String,
      default: ""
    },
    disabled: {
      type: Boolean,
      default: false
    },
    help: {
      type: String,
      default: ""
    },
    autoresize: {
      type: Number,
      default: undefined
    },
    accept: {
      type: String,
      default: ""
    }
  },

  methods: {
    isClickAddFile() {
      if (this.modCompleted == false && this.disabled == false) {
        this.$el.focus();
        this.$refs.file.click();
      }
    },
    isClickEditFile() {
      if (this.modCompleted == true) {
        this.$el.focus();
        this.$refs.file.click();
      }
    },
    isAutoresize() {
      if (this.$refs.files.clientHeight < this.autoresize) {
        this.$refs.files.style.maxHeight = this.autoresize + "px";
      }
    },
    isSelectFile(number) {
      for (let k in this.dFiles) {
        if (k == number) {
          this.$emit("onSelect", this.dPath + this.dFiles[k].name);
        }
      }
    }
  },
  mounted() {
    this.isAutoresize();
    this.$refs.file.addEventListener("change", event => {
      let split = event.target.value.split("\\");
      let newstring = "";
      for (let k in split) {
        if (k < split.length - 1) {
          newstring = newstring + split[k] + "\\";
        }
      }
      this.dPath = newstring;
      this.dFiles = [];
      this.dFiles = event.target.files;
      if (this.dFiles.length > 0) {
        this.modCompleted = true;
      }
    });
  }
};
</script>