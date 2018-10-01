<?php

//добавляем в контейнер зависимостей PDO
$container['mongodb'] = function ($c) {
    $dbc = $c['settings']['mongodb'];
    $mongo = new \MongoDB\Client("mongodb://{$dbc['host']}:{$dbc['port']}");
    return $mongo;
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
//добавляем в контейнер сервисы авторизации
$container['auths'] = function ($c) {
    $auths = new \App\Services\Auth\FactoryAuth($c);
    return $auths;
};
