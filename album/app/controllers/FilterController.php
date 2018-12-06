<?php
namespace App\Controllers;

use \App\Controllers\MainController;
use \App\Models\Api\Filter\Create;
use \App\Models\Api\Filter\Show;

class FilterController extends MainController
{

    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new Show($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['filter'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function create($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new Create($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['massege'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;

        return $response;

    }
    public function update($request, $response, $args)
    {

        return $response;
    }
    public function delete($request, $response, $args)
    {
        return $response;
    }
}
