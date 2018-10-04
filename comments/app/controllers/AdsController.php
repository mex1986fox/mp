<?php
namespace App\Controllers;

use App\Controllers\MainController;
use \App\Models\Api\Ads\Create as AdsCreate;
use \App\Models\Api\Ads\Length as AdsLength;
use \App\Models\Api\Ads\Show as AdsShow;

class AdsController extends MainController
{
    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AdsShow($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['comments'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function create($request, $response, $args)
    {

        $cont = $this->container;
        $reg = new AdsCreate($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['massege'])) {
            $response = $response->withJson($answer, 200);
        }
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
    public function length($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AdsLength($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['lengths'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
}
