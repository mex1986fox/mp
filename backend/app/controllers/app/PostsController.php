<?php
namespace App\Controllers\App;


class PostsController extends \App\Controllers\MainController
{

    public function show($request, $response, $args)
    {
        $response = $this->container->view->render($response, "layout.phtml");
        return $response;
    }
}
