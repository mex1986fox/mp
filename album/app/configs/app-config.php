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
            'dbname' => "albums",
        ],
    ],
    'hosts' => [
        'this' => 'http://albums.drovito.ru',
        'auth' => 'http://drovito.ru',
    ],
];
