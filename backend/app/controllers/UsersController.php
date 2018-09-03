<?php
namespace App\Controllers;

use \App\Models\Api\Users\Authorization as UsersAuthorization;
use \App\Models\Api\Users\Create as UsersCreate;
use \App\Models\Api\Users\Show as UsersShow;

class UsersController extends MainController
{
    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new UsersShow($cont, $request, $response);
        $answer = $reg->run();
        $response = $response->withJson($answer, 200);
        return $response;
    }
    public function create($request, $response, $args)
    {

        $cont = $this->container;
        $reg = new UsersCreate($cont, $request, $response);
        $answer = $reg->run();
        $response = $response->withJson($answer, 200);
        return $response;

    }
    public function update($request, $response, $args)
    {
        echo "update hello";
        return $response;
    }
    public function delete($request, $response, $args)
    {
        echo "delete hello";
        return $response;
    }
    public function authorization($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new UsersAuthorization($cont, $request);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 200);
        }
        if (isset($answer['user'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
}
