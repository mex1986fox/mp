<?php
namespace App\Controllers;

use App\Controllers\MainController;
use \App\Models\Api\Messages\Create as MessagesCreate;
use \App\Models\Api\Messages\Delete as MessagesDelete;
use \App\Models\Api\Messages\Length as MessagesLength;
use \App\Models\Api\Messages\Show as MessagesShow;
use \App\Models\Api\Messages\MarkRead as MessagesMarkRead;

class MessagesController extends MainController
{
    public function markRead($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new MessagesMarkRead($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['message'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new MessagesShow($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['messages'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function create($request, $response, $args)
    {

        $cont = $this->container;
        $reg = new MessagesCreate($cont, $request, $response);
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
        $cont = $this->container;
        $reg = new MessagesDelete($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['massege'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function length($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new MessagesLength($cont, $request, $response);
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
