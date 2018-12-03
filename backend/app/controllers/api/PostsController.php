<?php
namespace App\Controllers\Api;

use \App\Controllers\MainController;
use \App\Models\Api\Posts\Create as PostsCreate;
use \App\Models\Api\Posts\Show as PostsShow;
use \App\Models\Api\Posts\Update as PostsUpdate;

class PostsController extends MainController
{

    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new PostsShow($cont, $request, $response);
        $answer = $reg->run();
        $response = $response->withJson($answer, 200);
        return $response;
    }
    public function create($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new PostsCreate($cont, $request, $response);
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
        $reg = new PostsUpdate($cont, $request, $response);
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
