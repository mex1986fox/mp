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
            'dbname' => "messages",
        ],
    ],
    'hosts' => [
        'this' => 'http://messages.ru',
        'auth' => 'http://drovito.ru',
        'ads' => 'http://drovito.ru',
    ],
];
