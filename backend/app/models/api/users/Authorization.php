<?php
namespace App\Models\Api\Users;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Authorization
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
            if (isset($_SESSION["user_id"])) {
                throw new \Exception("Пользователь уже авторизован");
            }
            // передаем параметры в переменные
            $p = $this->request->getQueryParams();
            $exceptions = [];
            $login = $p["login"];
            $password = $p["password"];

            // проверяем параметры
            $valid = $this->container['validators'];
            $vStLen = $valid->StringLength;
            $vStLen->setMin(1);
            $vStLen->setMax(64);
            if (!$vStLen->isValid($login)) {
                $exceptions["login"] = "Не соответсвет диапозону длины";
            }
            $vStLen->setMin(4);
            $vStLen->setMax(32);
            if (!$vStLen->isValid($password)) {
                $exceptions["password"] = "Не соответсвет диапозону длины";
            }
            if (!empty($exceptions)) {
                throw new \Exception("Ошибки в параметрах");
            }
            // пишем в базу
            $db = $this->container['db'];
            $q = "select * from users where login = '{$login}';";
            $sth = $db->query($q, \PDO::FETCH_ASSOC);
            $user = $sth->fetch();
            
            if(!isset($user["id"])){
                $exceptions["login"] = "Такой логин не зарегистрирован";
                throw new \Exception("Ошибки в параметрах");
            }
            if($user['password']!==md5($password)){
                $exceptions["password"] = "Не верный пароль";
                throw new \Exception("Ошибки в параметрах");
            }
            if ($user['password']==md5($password)) {
                $_SESSION["user_id"] = $user["id"];
                setcookie("user_id", $user["id"], time() + 60*60*12, "/");
            }
            return ["massege"=>"Авторизация прошла успешно"];
        } catch (RuntimeException | \Exception $e) {

            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
