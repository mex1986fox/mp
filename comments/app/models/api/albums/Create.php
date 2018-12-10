<?php
namespace App\Models\Api\Albums;

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
            if (empty($p["id"])) {
                $exceptions["id"] = "Не указан номер объявления";
            }
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
            $ID = (int)$p["id"];
            $description = $p["description"];
            $sessionID = $p["session_id"];
            $userID = (int)$p["user_id"];
            if (!empty($p["comment_id"])) {
                $commentID = $p["comment_id"];
            }
            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }
            // проверить есть ли объект сервиса по id
            $mdb = $this->container['mongodb'];
            $find = $mdb->albums->findOne(["_id" => $ID]);
            // если нет
            if (empty($find["_id"])) {
                $authedAlbums = $auths->AuthAlbums->Authed($ID);
                if (!$authedAlbums) {
                    throw new \Exception("Нет такого объявления");
                }
                //создать новый объект объявления и коментарий
                $album = [
                    "_id" => $ID,
                    "commentsLength" => 1,
                    "comments_id" => [1],
                    "comments" => [
                        [
                            "id" => 1,
                            "user_id" => $userID,
                            "date_create" => date("Y-m-d H:i:s"),
                            "likes" => 0,
                            "dislikes" => 0,
                            "description" => $description,
                            "comments_id" => [],
                        ],
                    ],
                ];
                $mdb->albums->insertOne($album);

            } else {
                //обновить объект объявления и добавить комментарий
                $comLeng = $find["commentsLength"] + 1;
                $comment = [
                    "id" => $comLeng,
                    "user_id" => $userID,
                    "date_create" => date("Y-m-d H:i:s"),
                    "likes" => 0,
                    "dislikes" => 0,
                    "description" => $description,
                    "comments_id" => [],
                ];

                $mdb->albums->updateOne(["_id" => $ID], ['$push' => ["comments" => $comment], '$inc' => ['commentsLength' => 1]]);
                // получить номер комментария
                // и добавить его к массиву ответов если это нужно
                if (!empty($commentID)) {

                    $mdb->albums->updateOne(["_id" => $ID, "comments.id" => (int) $commentID], ['$push' => ["comments.$.comments_id" => $comLeng], '$inc' => ['comments.$.ansversLength' => 1]]);
                }else{
                    $mdb->albums->updateOne(["_id" => $ID], ['$push' => ["comments_id" => $comLeng]]);
                }
            }
            return ["massege" => "Комментарий сохранен"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
