<?php
namespace App\Models\Api\Users;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Create
{
    protected $request, $response, $container;
    public function __construct($container, $request, $response)
    {
        $this->request = $request;
        $this->response = $response;
        $this->container = $container;

    }
    public function run()
    {
        try {

            // передаем параметры в переменные
            $p = $this->request->getQueryParams();
            $exceptions = [];
            $login = $p["login"];
            $password = $p["password"];
            $name = $p["name"];
            $surname = $p["surname"];
            $birthdate = $p["birthdate"];
            $captcha = $p["captcha"];
            // проверяем капчу
            if (empty($captcha)) {
                $exceptions["captcha"] = "Не ввели символы";
            } elseif (!empty($_SESSION['captcha']) && md5($captcha) !== $_SESSION['captcha']) {
                $exceptions["captcha"] = "Не верно";
            }
            // убиваем капчу из сессии
            unset($_SESSION["captcha"]);

            // проверяем параметры
            $valid = $this->container['validators'];
            $vStLen = $valid->StringLength;
            $vStLen->setMin(1);
            $vStLen->setMax(64);
            if (!$vStLen->isValid($login)) {
                $exceptions["login"] = "От 1 до 64 символов";
            }
            if (!$vStLen->isValid($name)) {
                $exceptions["name"] = "От 1 до 64 символов";
            }
            if (!$vStLen->isValid($surname)) {
                $exceptions["surname"] = "От 1 до 64 символов";
            }
            $vDate = $valid->Date;
            if (!$vDate->isValid($birthdate)) {
                $exceptions["birthdate"] = "Не соответствует";
            }
            $vStLen->setMin(4);
            $vStLen->setMax(32);
            if (!$vStLen->isValid($password)) {
                $exceptions["password"] = "От 4 до 32 символов";
            }
            if (!empty($exceptions)) {
                throw new \Exception("Ошибки в параметрах");
            }

            // создаем  загадку ключ восстановления
            $recoveryKey = "";
            for ($i = 0; $i < rand(7, 10); $i++) {
                if (rand(0, 1) == 1) {
                    $recoveryKey = $recoveryKey . chr(rand(49, 57));
                } else {
                    $recoveryKey = $recoveryKey . chr(rand(97, 122));
                }
            }
            // пишем в базу
            $db = $this->container['db'];
            $q = "  insert into users
                        ( login, password, recovery_key, name, surname, birthdate )
                    values
                        ('{$login}',md5('{$password}'),md5('{$recoveryKey}'),
                            '{$name}','{$surname}','{$birthdate}'
                        ) RETURNING id;";

            $sth = $db->query($q, \PDO::FETCH_ASSOC);
            $user = $sth->fetch();
            // добавить в сессию
            if (isset($user['id'])) {
                $_SESSION["user"]["id"] = $user["id"];
                $_SESSION["user"]["login"] = $login;
            }
            return ["recovery_key" => $recoveryKey, "massege" => "Регистрация прошла успешно"];
        } catch (RuntimeException | \Exception $e) {
            if ($e->getCode() == 23505) {
                $exceptions["login"] = "Этот логин занят";
            }
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
