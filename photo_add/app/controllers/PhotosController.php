<?php
namespace App\Controllers;

use App\Controllers\MainController;
use \App\Models\Api\Photos\Create as PhotosCreate;
use \App\Models\Api\Photos\Show as PhotosShow;

class PhotosController extends MainController
{
    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new PhotosShow($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['ads'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function create($request, $response, $args)
    {

        $cont = $this->container;
        $reg = new PhotosCreate($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['recovery_key'])) {
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
