<?php
namespace App\Controllers;

use App\Controllers\MainController;
use \App\Models\Api\Photos\Create as PhotosCreate;
use \App\Models\Api\Photos\Show as PhotosShow;
use \App\Models\Api\Photos\Delete as PhotosDelete;

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
        if (isset($answer['posts'])) {
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
        if (isset($answer['message'])) {
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
        $cont = $this->container;
        $reg = new PhotosDelete($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['message'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
}
