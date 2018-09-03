<?php
namespace App\Controllers;

use \App\Models\Api\Ads\Create as AdsCreate;

class AdsController extends MainController
{

    public function show($request, $response, $args)
    {
        return $response;
    }
    public function create($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AdsCreate($cont, $request, $response);
        $answer = $reg->run();
        $response = $response->withJson($answer, 200);
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
