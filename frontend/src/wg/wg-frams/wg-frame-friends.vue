<template>
    <div>
        <span class="ui-header ui-header_4 wg-frame-friends__header">Ваши друзья</span>
        <div class="ui-avatar-block wg-card-ad__avatar-block" v-for="key in 5" :key="key">
            <div class="ui-avatar">
                <span class="ui-avatar__simbol">f</span>
                <img alt="" src="http://photos-users.ru/public/photos/avatars/6/Koala.jpg">
            </div>
            <a class="ui-link ui-avatar-block__link">firefox firefox</a>
            <div class="ui-avatar-block__title">2018-10-17 18:21</div>
        </div>
    </div>
</template>
