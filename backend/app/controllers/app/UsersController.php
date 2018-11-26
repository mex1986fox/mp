<?php
namespace App\Controllers\App;


class UsersController extends \App\Controllers\MainController
{

    public function show($request, $response, $args)
    {
        $response = $this->container->view->render($response, "layout.phtml");
        return $response;
    }
}
