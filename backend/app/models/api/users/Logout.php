<?php
namespace App\Models\Api\Users;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Logout
{
    protected $request, $container;
    public function __construct($container, $request)
    {
        $this->request = $request;
        $this->container = $container;

    }
    public function run()
    {
        try {
            if (!isset($_SESSION["user_id"])) {
                throw new \Exception("Пользователь не был авторизован");
            }else{
                unset($_SESSION["user_id"]);
                setcookie("user_id", $user["id"], time() - 60*60*12, "/");
            }
            
            
            return ["massege"=>"Выход из системы прошел успешно"];
        } catch (RuntimeException | \Exception $e) {

            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
