<?php
namespace App\Models\Api\Ads;

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
            $thisHost = $this->container["hosts"]["this"];
            // передаем параметры в переменные
            $p = $this->request->getQueryParams();

            // //проверяем параметры
            // $exceptions = [];
            // if (!isset($p["session_id"])) {
            //     $exceptions["session_id"] = "Не указан";
            // }
            // if (!isset($p["user_id"])) {
            //     $exceptions["user_id"] = "Не указан";
            // }
            // if (!isset($p["add_id"])) {
            //     $exceptions["add_id"] = "Не указан";
            // }
            // if (!empty($exceptions)) {
            //     throw new \Exception("Не верные параметры");
            // }
            // //устанавливаем параметры
            // $sessionID = $p["session_id"];
            // $userID = $p["user_id"];
            // $addID = $p["add_id"];
            // // проверить аутентификацию пользователя
            // $auths = $this->container['auths'];
            // $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            // if (!$authedUser) {
            //     throw new \Exception("Не прошел аутентификацию");
            // }
            // // проверить есть ли у юзера такое объявление
            // $authedAdd = $auths->AuthAdd->Authed($userID, $addID);
            // if (!$authedAdd) {
            //     throw new \Exception("У пользователя нет такого объявления");
            // }

            // сохраняем файл на сервер
            $db = $this->container['mongodb'];

            // $ad = [
            //     "_id" => 132,
            //     "user_id" => 1,
            //     "date_create" => "2018.06.28",
            //     "likes" => 2,
            //     "dislikes" => 5,
            //     "description" => "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Itaque vel repudiandae consequatur quaerat",
            //     "comments" => [2, 3, 6],
            // ];
            // $collection = $db->ads->ads;
            // $collection->insertOne($ad);
            echo "<pre>";
            print_r($db->ads->ads->findOne(["_id"=>132])["comments"]);
            // пишем в базу
            echo "</pre>";
            // $login = $p["login"];
            // return ["recovery_key" => $recoveryKey, "massege" => "Регистрация прошла успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
