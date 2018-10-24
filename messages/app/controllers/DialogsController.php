<?php
namespace App\Controllers;

use App\Controllers\MainController;
use \App\Models\Api\Dialogs\Create as DialogsCreate;
use \App\Models\Api\Dialogs\Length as DialogsLength;
use \App\Models\Api\Dialogs\Show as DialogsShow;

class DialogsController extends MainController
{
    public function show($request, $response, $args)
    {
        $cont = $this->container;
        $reg = new DialogsShow($cont, $request, $response);
        $answer = $reg->run();
        if (isset($answer['exceptions'])) {
            $response = $response->withJson($answer, 400);
        }
        if (isset($answer['dialogs'])) {
            $response = $response->withJson($answer, 200);
        }
        return $response;
    }
    public function create($request, $response, $args)
    {

        $cont = $this->container;
        $reg = new DialogsCreate($cont, $request, $response);
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
        $reg = new DialogsLength($cont, $request, $response);
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
