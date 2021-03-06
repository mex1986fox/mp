<?php
namespace App\Controllers\Api;

use \App\Controllers\MainController;
use \App\Models\Api\Ads\Create as AdsCreate;
use \App\Models\Api\Ads\Show as AdsShow;
use \App\Models\Api\Ads\Update as AdsUpdate;

class AdsController extends MainController
{

    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AdsShow($cont, $request, $response);
        $answer = $reg->run();
        $response = $response->withJson($answer, 200);
        return $response;
    }
    public function create($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AdsCreate($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }else{
            $response = $response->withJson($answer, 200);
        }
        return $response;

    }
    public function update($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AdsUpdate($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }else{
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function delete($request, $response, $args)
    {
        return $response;
    }
}
