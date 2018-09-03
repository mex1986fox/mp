<?php
namespace App\Controllers;

class AuthorizationController extends MainController
{

    public function authorization($request, $response, $args)
    {
        $response = $this->container->view->render($response, "layout.phtml");
        return $response;
    }
}
