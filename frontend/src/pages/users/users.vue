<template>
    <layout>
        <div class="container">
            <div class="row">
                <!-- левый блок -->
                <div class="col_3 col-tablet_4 col-phone_clean">
                    <ui-fixed-block>
                        <div class="row">
                            <div class="col-12">
                                <div class="wg-content-frame wg-content-frame_left">
                                    <wg-frame-friends></wg-frame-friends>
                                </div>
                            </div>
                        </div>
                    </ui-fixed-block>
                </div>
                <!-- центральный блок -->
                <div class="col_6 col-tablet_8 col-phone_6">
                    <div
                        v-if="users!=undefined"
                        class="row"
                        v-for="(user, key) in users"
                        :key="key"
                    >
                        <div class="col-12">
                            <div class="wg-content-frame wg-content-frame_center">
                                <wg-card-users :user="JSON.parse(JSON.stringify(user))"></wg-card-users>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- правый блок -->
                <div class="col_3 col-phone_3 col-tablet_clean col-phone_clean">
                    <ui-fixed-block>
                        <div class="row">
                            <div class="col-12">
                                <div
                                    class="wg-content-frame wg-content-frame_right wg-content-frame__padding"
                                >
                                    <div
                                        @click="showFilterUsers=true"
                                        class="ui-navigation__unit__button"
                                    >
                                        <div class="ui-navigation__unit__icon">
                                            <i aria-hidden="true" class="fa fa-sliders"></i>
                                        </div>Фильтр пользователей
                                    </div>
                                    <div
                                        @click="showMessenger=true"
                                        class="ui-navigation__unit__button"
                                    >
                                        <div class="ui-navigation__unit__icon">
                                            <i aria-hidden="true" class="fa fa-envelope"></i>
                                        </div>Мессенджер
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ui-fixed-block>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Фильтр сообщений -->
            <div class="col_12">
                <ui-blind :show="showFilterUsers" @onHide="showFilterUsers=false" animate="right">
                    <div class="container container_right">
                        <div class="row">
                            <div
                                class="col_7 col_offset-5 col-nbook_9 col-nbook_offset-3 col-tablet_10 col-tablet_offset-2 col-phone_6 col-phone_offset-0"
                            >
                                <wg-filter-users @onHide="showFilterUsers=false"></wg-filter-users>
                            </div>
                        </div>
                    </div>
                </ui-blind>
            </div>
            <!-- мессенджер -->
            <ui-blind
                @onHide="showMessenger=!showMessenger"
                :show="showMessenger"
                animate="opacity"
            >
                <div class="container">
                    <div class="row">
                        <div
                            class="col_8 col_offset-2 col-nbook_10 col-nbook_offset-1 col-tablet_12 col-tablet_offset-0 col-phone_6 col-phone_offset-0"
                        >
                            <wg-messanger @onHide="showMessenger=false"></wg-messanger>
                        </div>
                    </div>
                </div>
            </ui-blind>
        </div>
    </layout>
</template>

<script>
export default {
  name: "pg-ads",
  data() {
    return {
      users: undefined,
      showFilterUsers: false,
      showMessenger: false
    };
  },
  computed: {},
  methods: {
    loadUsers() {
      // console.dir(this.$store.state.filter_add.filter);
      let params = this.$store.state.filter_add.filter;
      let headers = { "Content-Type": "multipart/form-data" };
      this.$http.post("/api/show/users", params, headers).then(
        response => {
          this.users = response.body.users;
          this.loadAvatars();
        },
        error => {}
      );
    },
    loadAvatars() {
      let users_id = [];
      this.users.forEach(element => {
        users_id.push(element.id);
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
              this.users = this.users.map((ad, key, arr) => {
                if (ad.id == avatar.user_id) {
                  arr[key]["avatar"] = avatar.lincks[0];
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
    this.loadUsers();
  }
};
</script>