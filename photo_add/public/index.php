<?php

use \App\Middleware\CORSResponse;
use \App\Middleware\DepController;
use \App\Middleware\StandardFiltering;
use \Psr\Http\Message\ResponseInterface as Response;
use \Psr\Http\Message\ServerRequestInterface as Request;

ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

require '../vendor/autoload.php';

//подключаем файл с конфигурацией
require '../app/configs/app-config.php';
//подключаем констаты
require '../app/configs/global-consts.php';

//создаем приложение и скармливаем ему конфигурацию
$app = new \Slim\App($config);

// контейнер зависимом\стей
$container = $app->getContainer();
//подключаем файл зависимостей
require '../app/dependences/app-dependences.php';

//добавляет зависимости к главному контроллеру
$app->add(new DepController($container));

// $app->options('/api/{action}/{controller}', function ($request, $response, $args) {
//     $header = $request->getHeader('Access-Control-Request-Headers');
//     $origin = $request->getHeader('Origin');

//     $newResponse = $response->withHeader('Access-Control-Allow-Origin', $origin);
//     $newResponse = $newResponse->withHeader('Access-Control-Request-Method', "POST, GET, OPTIONS");
//     if (!empty($header)) {
//         $newResponse = $newResponse->withHeader('Access-Control-Request-Headers', $header);
//     };
//     $newResponse = $newResponse->withHeader('Access-Control-Max-Age', "86400");
//     return $newResponse;
// });
$app->post('/api/{action}/{controller}',
    function (Request $request, Response $response, $args) {
        $nameController = 'App\\Controllers\\' . ucfirst($args['controller'] . 'Controller');
        $nameAction = $args['action'];
        $controller = new $nameController();
        $response = $controller->$nameAction($request, $response, $args);
        return $response;
    }

)->add(new StandardFiltering($container))
    ->add(new CORSResponse($container));

$app->get('/api/{action}/{controller}',
    function (Request $request, Response $response, $args) {
        $nameController = 'App\\Controllers\\' . ucfirst($args['controller'] . 'Controller');
        $nameAction = $args['action'];
        $controller = new $nameController();
        $response = $controller->$nameAction($request, $response, $args);
        return $response;
    }

)->add(new StandardFiltering($container))
    ->add(new CORSResponse($container));

$app->run();
