<?php
namespace App\Controllers\Api;

use \App\Controllers\MainController;
use \App\Models\Api\Albums\Create as AlbumsCreate;
use \App\Models\Api\Albums\Show as AlbumsShow;
use \App\Models\Api\Albums\Update as AlbumsUpdate;

class AlbumsController extends MainController
{

    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AlbumsShow($cont, $request, $response);
        $answer = $reg->run();
        $response = $response->withJson($answer, 200);
        return $response;
    }
    public function create($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AlbumsCreate($cont, $request, $response);
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
        $reg = new AlbumsUpdate($cont, $request, $response);
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
