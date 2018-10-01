<?php
$config = [
    'settings' => [
        'displayErrorDetails' => true,
        'addContentLengthHeader' => false,
        'mongodb' => [
            'host' => "127.0.0.1",
            'port' => '27017',
            'user' => "drovito",
            'pass' => "drovito",
            'dbname' => "comments",
        ],
    ],
    'hosts' => [
        'this' => 'http://comments.ru',
        'auth' => 'http://drovito.ru',
    ],
];
