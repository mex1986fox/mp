<?php
namespace App\Controllers;

use App\Controllers\MainController;
use \App\Models\Api\Albums\Create as AlbumsCreate;
use \App\Models\Api\Albums\Length as AlbumsLength;
use \App\Models\Api\Albums\Show as AlbumsShow;

class AlbumsController extends MainController
{
    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new AlbumsShow($cont, $request, $response);
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
        $reg = new AlbumsCreate($cont, $request, $response);
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
        $reg = new AlbumsLength($cont, $request, $response);
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
