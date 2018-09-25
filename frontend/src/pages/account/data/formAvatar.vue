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
						<form id="formLoadPhotos" enctype="multipart/form-data" @submit.prevent="loadPhotos">
							<ui-file v-if="!rirendLoader" caption="Выберите фотографии" captionCompleted="Выбранные фотографии" :autoresize="300" accept="image/*" :percent="percentFL">
							</ui-file>
						</form>
						<div class="wg-form-add__buttons">
							<button class="ui-button ui-button_blue" type="submit">
								Загрузить
							</button>
						</div>
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
      descSnackbar: ""
    };
  },
  methods: {
    isClose() {
      this.$emit("onHide");
    },
    update(event) {
      let body = new FormData(event.target);
      this.$http.post("/api/update/users", body).then(
        response => {
          this.$store.commit("user/update", response.body.user);
          this.isClose();
        },
        error => {
          this.descSnackbar = error.body.exceptions.massege;
          this.showSnackbar = true;
        }
      );
    }
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
