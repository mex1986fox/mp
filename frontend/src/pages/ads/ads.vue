<template>
	<layout>
		<div class="container"
		     v-if="showAds">
			<div class="row">
				<div class="col_12">
					<ui-snackbar :show="showSnackbar"
					             @onHide="showSnackbar=false"
					             :time="15000">
						{{descSnackbar}}
					</ui-snackbar>
				</div>
				<div class="col_6 col_offset-3 col-phone_6 col-phone_offset-0">
					<div class="row">
						<div class="col-12">
							<div v-for="(val, key) in cads"
							     :key="key"
							     class="wg-content-frame wg-content-frame_center">
								<wg-card-ad :object="JSON.parse(JSON.stringify(val))">
								</wg-card-ad>
							</div>
						</div>
					</div>
				</div>
				<div class="col_12">

					<ui-blind :show="showFormAdd"
					          @onHide="showFormAdd=false"
					          animate="right">
						<div class="container container_right">
							<div class="row">
								<div class="col_8 col_offset-4 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0">
									<wg-form-add @onHide="
								     showFormAdd=false
								     ">

									</wg-form-add>
								</div>
							</div>
						</div>
					</ui-blind>
				</div>
			</div>
		</div>
		<div v-if="!showFormAdd"
		     @click="isShowFormAdd"
		     class="ui-button ui-button_circle ui-button_red pg-ads__button-show-form-add">
			<i class="fa fa-plus"
			   aria-hidden="true"></i>
		</div>
	</layout>
</template>

<script>
export default {
  name: "pg-ads",
  data() {
    return {
      showFormAdd: false,
      showSnackbar: false,
      descSnackbar: "",
      ads: undefined
    };
  },
  computed: {
    cads() {
      return this.ads;
    },
    showAds() {
      if (
        this.ads != undefined &&
        this.$store.state.transports.brands != undefined &&
        this.$store.state.locations.subjects != undefined
      ) {
        return true;
      }
      return false;
    }
  },
  methods: {
    isShowFormAdd() {
      if (this.$store.state.user.id != undefined) {
        this.showFormAdd = true;
      } else {
        this.descSnackbar =
          "Добавлять объявления могут только авторизованные пользователи. Войдите или зарегистрируйтесь.";
        this.showSnackbar = true;
      }
    },
    show(event) {
      this.$http.post("/api/show/ads").then(
        response => {
          this.ads = response.body.ads;
          this.updateUsers();
        },
        error => {}
      );
    },
    updateUsers() {
      let users_id = [];
      this.ads.forEach(element => {
        users_id.push(element.user_id);
      });
      let params = {
        users_id: users_id.filter((e, i, a) => a.indexOf(e) == i)
      };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http.post("/api/show/users", params, headers).then(
        response => {
          let users = response.body.users;
          users.forEach(user => {
            this.ads = this.ads.map((ad, key, arr) => {
              if (ad.user_id == user.id) {
                arr[key].user = user;
              }
              return ad;
            });
          });

          this.updatePhotoAvatars();
        },
        error => {}
      );
    },

    updatePhotoAvatars() {
      let users_id = [];
      this.ads.forEach(element => {
        users_id.push(element.user_id);
      });
      let params = {
        users_id: users_id.filter((e, i, a) => a.indexOf(e) == i)
      };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.photosUsers + "/api/show/avatars", params, headers)
        .then(
          response => {
            let avatars = response.body.avatars;
            avatars.forEach(avatar => {
              this.ads = this.ads.map((ad, key, arr) => {
                if (ad.user_id == avatar.user_id) {
                  arr[key].user.avatar = avatar.lincks[0];
                }
                return ad;
              });
            });

            this.updatePhotoLincks();
          },
          error => {}
        );
    },
    updatePhotoLincks() {
      let ads_id = [];
      this.ads.forEach(element => {
        ads_id.push(element.id);
      });
      let params = { ads_id: ads_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.photosAds + "/api/show/photos", params, headers)
        .then(
          response => {
            let lincks = response.body.ads;
            lincks.forEach(linck => {
              this.ads = this.ads.map((ad, key) => {
                if (ad.id == linck.id) {
                  ad.slide = linck.lincks.map(src => {
                    return { src: src };
                  });
                }
                return ad;
              });
            });
            this.updateLikes();
          },
          error => {}
        );
    },
    updateLikes() {
      let ads_id = [];
      this.ads.forEach(element => {
        ads_id.push(element.id);
      });
      let params = { ads_id: ads_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.likes + "/api/show/ads", params, headers)
        .then(
          response => {
            let likes = response.body.likes;
            likes.forEach(like => {
              this.ads = this.ads.map((ad, key) => {
                if (ad.id == like.ads_id) {
                  ad.likes = like.likes;
                  ad.dislikes = like.dislikes;
                }
                return ad;
              });
            });
            this.updateComments();
          },
          error => {}
        );
    },
    updateComments() {
      let ads_id = [];
      this.ads.forEach(element => {
        ads_id.push(element.id);
      });
      let params = { ads_id: ads_id };
      let headers = { "Content-Type": "multipart/form-data" };

      this.$http
        .post(this.$hosts.comments + "/api/length/ads", params, headers)
        .then(
          response => {
            let lengths = response.body.lengths;
            lengths.forEach(length => {
              this.ads = this.ads.map((ad, key) => {
                if (ad.id == length.ads_id) {
                  ad.commentsLength = length.length;
                }
                return ad;
              });
            });
          },
          error => {}
        );
    }
  },

  mounted() {
    this.show();
  }
};
</script>
