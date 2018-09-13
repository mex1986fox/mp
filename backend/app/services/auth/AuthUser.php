<?php
namespace App\Services\Auth;

class AuthUser
{
    protected $container;
    public function __construct($container)
    {
        $this->container = $container;
    }
    public function Authed()
    {
        $user_id = $_SESSION["user_id"];
        if (!empty($user_id)) {
            return true;
        }
        return false;

    }
}
