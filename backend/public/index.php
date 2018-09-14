<?php
session_start(); //стартуем сессию для всех запросов
use \App\Middleware\DepController;
use \App\Middleware\StandardFiltering;
use \Psr\Http\Message\ResponseInterface as Response;
use \Psr\Http\Message\ServerRequestInterface as Request;

// ini_set('error_reporting', E_ALL);
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);

require '../vendor/autoload.php';

//подключаем файл с конфигурацией
require '../app/configs/app-config.php';

//создаем приложение и скармливаем ему конфигурацию
$app = new \Slim\App($config);

// контейнер зависимом\стей
$container = $app->getContainer();
//подключаем файл зависимостей
require '../app/dependences/app-dependences.php';

//добавляет зависимости к главному контроллеру
$app->add(new DepController($container));

$app->post('/api/{action}/{controller}',
    function (Request $request, Response $response, $args) {
        $nameController = 'App\\Controllers\\Api\\' . ucfirst($args['controller'] . 'Controller');
        $nameAction = $args['action'];
        $controller = new $nameController();
        $response = $controller->$nameAction($request, $response, $args);
        return $response;
    }

)->add(new StandardFiltering($container));
$app->get('/api/{action}/{controller}',
    function (Request $request, Response $response, $args) {
        $nameController = 'App\\Controllers\\Api\\' . ucfirst($args['controller'] . 'Controller');
        $nameAction = $args['action'];
        $controller = new $nameController();
        $response = $controller->$nameAction($request, $response, $args);
        return $response;
    }

)->add(new StandardFiltering($container));
$app->get('/authorization', \App\Controllers\App\AuthorizationController::class . ":authorization")->add(new StandardFiltering($container));
$app->get('/ads', \App\Controllers\App\AdsController::class . ":show")->add(new StandardFiltering($container));

$app->run();
