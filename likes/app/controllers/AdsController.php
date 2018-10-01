<?php
namespace App\Controllers;

use App\Controllers\MainController;
use \App\Models\Api\Ads\Create as LikesCreate;
use \App\Models\Api\Ads\Show as LikesShow;

class AdsController extends MainController
{
    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new LikesShow($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['likes'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function create($request, $response, $args)
    {

        $cont = $this->container;
        $reg = new LikesCreate($cont, $request, $response);
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
}
