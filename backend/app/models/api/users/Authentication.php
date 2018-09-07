<?php
namespace App\Models\Api\Users;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Authentication
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

            // передаем параметры в переменные
            $p = $this->request->getQueryParams();
            $user_id = $p["user_id"];
            $exceptions = [];
            // проверяем параметры
            if (empty($user_id)) {
                throw new \Exception("Не указали ID пользователя");
            }
            // var_dump($_SESSION);
            if (!isset($_SESSION["user_id"])) {
                throw new \Exception("Пользователь не авторизован2");
            }

            if($_SESSION["user_id"] != $user_id){
                throw new \Exception("Пользователь не авторизован");
            }

            return ["massege" => "Пользователь авторизован"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
