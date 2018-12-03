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
            'dbname' => "photos_posts",
        ],
    ],
    'hosts' => [
        'this' => 'http://photos-posts.ru',
        'auth' => 'http://drovito.ru',
    ],
];
