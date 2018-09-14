<?php
namespace App\Controllers\Api;

use \App\Controllers\MainController;
use \App\Models\Api\Locations\Show as LocationsShow;

class LocationsController extends MainController
{
    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new LocationsShow($cont, $request, $response);
        $answer = $reg->run();
        $response = $response->withJson($answer, 200);
        return $response;
    }
    public function create($request, $response, $args)
    {

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
