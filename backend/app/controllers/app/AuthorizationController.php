<?php
namespace App\Controllers\App;


class AuthorizationController extends \App\Controllers\MainController
{

    public function authorization($request, $response, $args)
    {
        $response = $this->container->view->render($response, "layout.phtml");
        return $response;
    }
}
