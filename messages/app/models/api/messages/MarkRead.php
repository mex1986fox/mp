<?php
namespace App\Models\Api\Messages;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class MarkRead
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

            if (empty($p["session_id"])) {
                $exceptions["session_id"] = "Не указана сессия";
            }
            if (empty($p["user_id"])) {
                $exceptions["user_id"] = "Не указан пользователь";
            }

            if (empty($p["dialog_id"])) {
                $exceptions["dialog_id"] = "Не указан диалог";
            }
            $dialogID = $p["dialog_id"];

            if (!empty($exceptions)) {
                throw new \Exception("Не верные параметры");
            }

            //устанавливаем параметры
            $sessionID = $p["session_id"];
            $userID = (int) $p["user_id"];

            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }

            $mdb = $this->container['mongodb'];
            // находим диалог и помечаем все ссобщения аппонента прочитанными
             $mdb->$dialogID->updateMany(['user_id'=>['$ne'=>$userID]], ['$set' => ['status_read' => true]]);
            // db.messages.updateMany({"_id":"U1A5"},{"$set":{"messages.$[elem].status_read":true}},{"arrayFilters":[{"elem.user_id":{$eq:5}}]})
            return ["message" => "Отмечено прочитанными"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['message'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }
    }
}
