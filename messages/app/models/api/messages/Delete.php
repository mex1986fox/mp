<?php
namespace App\Models\Api\Messages;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Delete
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
            if (empty($p["message_id"])) {
                $exceptions["message_id"] = "Не указана номер сообщения";
            }
            if (empty($p["apponent_id"])) {
                $exceptions["apponent_id"] = "Не указан аппонент";
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
            // устанавливаем параметры
            $messageID = $p["message_id"];
            $sessionID = $p["session_id"];
            $userID = (int) $p["user_id"];
            $apponentID = $p["apponent_id"];

            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }

            $mdb = $this->container['mongodb'];
            // удалить сообщение
            // проверить есть ли диалог
            // проверить есть ли диалог
            $aggreg = $mdb->dialogs->aggregate([
                ['$match' => ['_id' => $userID]],
                ['$unwind' => '$dialogs'],
                ['$match' => ['dialogs.apponent_id' => (int) $apponentID]],
                ['$limit' => 5],
            ]);

            $arrDial = iterator_to_array($aggreg, true);
            $dialogID = $arrDial[0]["dialogs"]["dialog_id"];
            $dialogID = (count($arrDial) > 0) ? $arrDial[0]["dialogs"]["dialog_id"] : null;
            if (!empty($dialogID)) {
                $mdb->$dialogID->deleteOne(['_id' => new \MongoDB\BSON\ObjectId($messageID)]);
                return ["massege" => "Сообщение удалено", "message_id" => $messageID];
            }else{
                throw new \Exception("Нет такого диалога");
            }

        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
