<?php

//добавляем в контейнер зависимостей PDO
$container['db'] = function ($c) {
    $db = $c['settings']['db'];
    $pdo = new PDO("pgsql:host=" . $db['host'] . ";port=" . $db['port'] . ";dbname=" . $db['dbname'],
        $db['user'], $db['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    return $pdo;
};

// база данных фотографий объявлений
$container['db_photos_ads'] = function ($c) {
    $db = $c['settings']['db_photos_ads'];
    $pdo = new PDO("pgsql:host=" . $db['host'] . ";port=" . $db['port'] . ";dbname=" . $db['dbname'],
        $db['user'], $db['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    return $pdo;
};

//добавляем вьюхи
$container['view'] = function ($container) {
    return new \Slim\Views\PhpRenderer('../app/views/');
};

//добавляем в контейнер зависимостей фильтры
// фильтры взяты из Zend Fr. 3
$container['filters'] = function ($c) {
    $filters = new \App\Services\Filter\FilterFactory();
    return $filters;
};

//добавляем в контейнер зависимостей валидаторы
// валидаторы взяты из Zend Fr. 3
$container['validators'] = function ($c) {
    $validators = new \App\Services\Validator\ValidatorFactory();
    return $validators;
};
