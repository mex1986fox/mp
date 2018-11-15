import Vue from "vue/dist/vue.js";
const users = {
    namespaced: true,
    state: {
        buffer: {},
        flagUpdate: 0
    },
    getters: {},
    mutations: {
        add(state, users) {
            users.forEach(user => {
                if (user.id != undefined) {
                    state.buffer[String(user.id)] = user;
                }
            });
            let buf= state.buffer;
            state.buffer=undefined;
            state.buffer=buf;
        },
        addAvatars(state, avatars) {
            avatars.forEach(avatar => {
                if (avatar.user_id != undefined) {
                    state.buffer[String(avatar.user_id)].avatar = avatar.lincks[0];
                }
            });
            let buf= state.buffer;
            state.buffer=undefined;
            state.buffer=buf;
            state.flagUpdate++;
        }
    },
    actions: {
        add(context, users_id) {
            if (users_id != undefined) {
                //сравнить с закачанными юзерами
                //еслли когото нет тогда докачать
                let newUse = []
                users_id.forEach(id => {
                    if (id!=null && context.state.buffer[id] == undefined) {
                        newUse.push(id)
                    }
                });
                newUse = Array.from(new Set(newUse))
                if (newUse.length > 0) {
                    let body = { users_id: newUse };
                    Vue.http.post("/api/show/users", body).then(
                        response => {
                            // context.commit("update", response.body.users[0]);
                            // context.dispatch("setAvatar");
                            let users = response.body.users;
                            context.commit("add", users);
                            context.dispatch("addAvatars", newUse);
                        },
                        error => { }
                    );
                }
            }
        },
        addAvatars(context, users_id) {
            if (users_id != undefined && users_id.length != undefined) {
                users_id = Array.from(new Set(users_id))
                let body = { users_id: users_id };
                Vue.http.post(Vue.prototype.$hosts.photosUsers + "/api/show/avatars", body).then(
                    response => {
                        // context.commit("update", response.body.users[0]);
                        // context.dispatch("setAvatar");
                        let avatars = response.body.avatars;
                        context.commit("addAvatars", avatars);
                        // console.log(response.body.avatars);
                    },
                    error => { }
                );

            }
        }
    }
};
export default users;