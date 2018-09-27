<template>
  <div class="wg-form-add">
    <div class="row">
      <div class="col-12">
        <div class="wg-form-add__bar">
          <div class="ui-header ui-header_2 wg-form-add__header">
            <span>Редактирование аватара</span>
          </div>
          <button class="ui-button ui-button_circle ui-button_flat wg-form-add__close" @click="isClose">
            <i class="fa fa-angle-down"></i>
          </button>
        </div>

        <div class="wg-form-add__content">
          <form @submit.prevent="update">
            <div class="wg-form-add__hr">
              <!-- <i class="fa fa-map-marker" aria-hidden="true"></i> -->
              Аватарка
            </div>
            <div class="pg-account-data__favatar_block">
              <div class="ui-avatar pg-account-data__favatar" v-if="user.avatar">
                <img :src="user.avatar" alt="" srcset="">
              </div>
              </div>

              <form enctype="multipart/form-data" @submit.prevent="loadAvatars">
                <ui-file v-if="!rirendLoader" caption="Выберите картинку для аватара" captionCompleted="Выбранные файлы" :autoresize="300" accept="image/*" :percent="percentFL">
                </ui-file>
              </form>
              
          </form>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col_12">
        <ui-snackbar :show="showSnackbar" @onHide="showSnackbar=false" :time="20000">
          {{descSnackbar}}
        </ui-snackbar>
      </div>
    </div>
  </div>

</template>

<script>
export default {
  name: "pg-account-data-form",
  data() {
    return {
      showSnackbar: false,
      descSnackbar: "",
      selectPhoto: 0,
      rirendLoader: false,
      percentFL: undefined
    };
  },
  methods: {
    isClose() {
      this.$emit("onHide");
    },
    isSelectPhoto(nPhoto) {
      this.selectPhoto = nPhoto;
    },
    loadAvatars() {
      this.numberFL = 1;
      let body = new FormData(event.target);
      body.set("session_id", this.$cookie.get("PHPSESSID"));
      body.set("user_id", this.$cookie.get("user_id"));
      this.$http
        .post(this.$hosts.photosUsers + "/api/create/avatars", body, {
          progress: function(e) {
            if (e.lengthComputable) {
              this.percentFL = (e.loaded / e.total) * 100;
            }
          }.bind(this)
        })
        .then(
          response => {
            this.rirendLoader = true;
            setTimeout(()=>{
               this.rirendLoader = false;
            },100);
           
            this.percentFL = undefined;
            this.$store.dispatch("user/setAvatar");
          },
          error => {}
        );
    },
    
  },
  computed: {
    user() {
      if (this.$store.state.user.id != undefined) {
        return this.$store.state.user;
      }
      return undefined;
    }
  }
};
</script>
