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

            //проверяем параметры
            $exceptions = [];
            if (empty($p["ad_id"])) {
                $exceptions["ad_id"] = "Не указан номер объявления";
            }
            // if (empty($p["comment_id"])) {
            //     $exceptions["comment_id"] = "Не указан номер комментария";
            // }
            if (empty($p["description"])) {
                $exceptions["description"] = "Комментарий пустой";
            }
            if (empty($p["session_id"])) {
                $exceptions["session_id"] = "Не указана сессия";
            }
            if (empty($p["user_id"])) {
                $exceptions["user_id"] = "Не указан пользователь";
            }
            if (!empty($exceptions)) {
                throw new \Exception("Не верные параметры");
            }
            //устанавливаем параметры
            $adID = $p["ad_id"];
            $description = $exceptions["description"];
            $sessionID = $p["session_id"];
            $userID = $p["user_id"];
            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }
            // проверить есть ли объект сервиса по id
            $mdb = $this->container['mongodb'];
            $find = $mdb->ads->findOne(["_id" => $adID]);
            // если нет
            if (empty($find["_id"])) {
                $authedAds = $auths->AuthAds->Authed($AdID);
                if (!$authedAds) {
                    throw new \Exception("Нет такого объявления");
                }
                //создать новый объект объявления и коментарий
                $ad = [
                    "_id" => $adID,
                    "comments" => [
                        "id" => 1,
                        "user_id" => $userID,
                        "date_create" => date("Y-m-d H:i:s"),
                        "likes" => 0,
                        "dislikes" => 0,
                        "description" => $description,
                        "comments_id" => [],
                    ]
                ];
                $mdb->ads->save($ad);

            } else {
                //обновить объект объявления и добавить комментарий
                $comment = [
                    "id" => 1,
                    "user_id" => $userID,
                    "date_create" => date("Y-m-d H:i:s"),
                    "likes" => 0,
                    "dislikes" => 0,
                    "description" => $description,
                    "comments_id" => [],
                ];

                $mdb->ads->save($find, ['$push' => ["comments" => $comment], '$inc' => ['commentsLength' => 1]]);
                // получить номер комментария
                // и добавить его к массиву ответов если это нужно
            }
            // сохраняем файл на сервер

            $collAds = $mc->comments->ads;
            $collAds->insertOne($ad);
            echo "<pre>";
            print_r($mc->comments->ads->findOne(["_id" => 132]));
            echo "</pre>";
            // $login = $p["login"];
            // return ["recovery_key" => $recoveryKey, "massege" => "Регистрация прошла успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
