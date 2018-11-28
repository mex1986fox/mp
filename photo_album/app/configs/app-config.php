<?php
$config = [
    'settings' => [
        'displayErrorDetails' => true,
        'addContentLengthHeader' => false,
        'db' => [
            'host' => "127.0.0.1",
            'port' => '5432',
            'user' => "drovito",
            'pass' => "drovito",
            'dbname' => "photos_albums",
        ],
    ],
    'hosts' => [
        'this' => 'http://photos-albums.ru',
        'auth' => 'http://drovito.ru',
    ],
];
