<?php
namespace App\Models\Api\Users;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Update
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
            $user_id=$_SESSION["user_id"];
            $login = $p["login"];
            $name = $p["name"];
            $surname = $p["surname"];
            $birthdate = $p["birthdate"];
            $settlement = $p["settlement"];
            $phone = $p["phone"];
            $email = $p["email"];

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
            if (!empty($exceptions)) {
                throw new \Exception("Ошибки в параметрах");
            }

            // пишем в базу
            // формируем запрос
            $qSet = "";
            $qSet = $qSet . (empty($login) ? "" : " login='{$login}',");
            $qSet = $qSet . (empty($name) ? "" : " name='{$name}',");
            $qSet = $qSet . (empty($surname) ? "" : " surname='{$surname}',");
            $qSet = $qSet . (empty($birthdate) ? "" : " birthdate='{$birthdate}',");
            $qSet = $qSet . (empty($settlement) ? "" : " settlement_id={$settlement},");
            $qSet = $qSet . (empty($phone) ? "" : " phone='{$phone}',");
            $qSet = $qSet . (empty($email) ? "" : " email='{$email}',");
            $qSet = (empty($qSet) ? "" : substr($qSet, 0, -1));
            $q = "update users set {$qSet} where id={$user_id} RETURNING login, name, surname, birthdate, settlement_id, phone, email;";
            $db = $this->container['db'];
            $user = $db->query($q, \PDO::FETCH_ASSOC)->fetch();
            return ["user" => $user, "massege" => "данные изменены успешно"];
        } catch (RuntimeException | \Exception $e) {
            if ($e->getCode() == 23505) {
                $exceptions["login"] = "Этот логин занят";
            }
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
