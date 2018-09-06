<?php
namespace App\Controllers\PhotoAds;

use App\Controllers\MainController;
use \App\Models\Api\Photos\Create as PhotosCreate;

class PhotosController extends MainController
{
    public function show($request, $response, $args)
    {
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
