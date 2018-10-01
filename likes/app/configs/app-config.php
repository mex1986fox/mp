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
            'dbname' => "likes",
        ],
    ],
    'hosts' => [
        'this' => 'http://likes.ru',
        'auth' => 'http://drovito.ru',
        'ads' => 'http://drovito.ru',
    ],
];
