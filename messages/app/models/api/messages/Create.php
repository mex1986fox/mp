<?php
namespace App\Models\Api\Messages;

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
            if (empty($p["message"])) {
                $exceptions["message"] = "Сообщение пустое";
            }
            if (empty($p["session_id"])) {
                $exceptions["session_id"] = "Не указана сессия";
            }
            if (empty($p["user_id"])) {
                $exceptions["user_id"] = "Не указан пользователь";
            }
            if (empty($p["apponent_id"])) {
                $exceptions["apponent_id"] = "Не указан аппонент";
            }
            if (!empty($exceptions)) {
                throw new \Exception("Не верные параметры");
            }
            //устанавливаем параметры
            $message = $p["message"];
            $sessionID = $p["session_id"];
            $userID = (int) $p["user_id"];
            $apponentID = (int) $p["apponent_id"];
            if ($userID == $apponentID) {
                throw new \Exception("Нельзя отправить сообщение самому седбе");
            }
            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }
            // проверить существование аппонента в системе
            $authedApponent = $auths->AuthApponent->Authed($apponentID);
            if (!$authedApponent) {
                throw new \Exception("Нет такого аппонента в системе");
            }

            $mdb = $this->container['mongodb'];
            //проверить есть ли пользователь и аппонет
            //в коллекции диалогов
            // $find = $mdb->dialogs->findOne(["_id" => $userID], ["_id" => 1]);
            // if(empty($find['_id'])){
            //     $mdb->dialogs->insertOne(["_id"=>$userID, "dialogs"=>[]]);
            // }
            // $find = $mdb->dialogs->findOne(["_id" => $apponentID], ["_id" => 1]);
            // if(empty($find['_id'])){
            //     $mdb->dialogs->insertOne(["_id"=>$apponentID, "dialogs"=>[]]);
            // }

            // проверить есть ли диалог
            $aggreg = $mdb->dialogs->aggregate([
                ['$match' => ['_id' => $userID]],
                ['$unwind' => '$dialogs'],
                ['$match' => ['dialogs.apponent_id' => $apponentID]],
            ]);
            // var_dump(iterator_to_array($aggreg, false));
            // var_dump(count(iterator_to_array($aggreg, false)));
            $arrDial=iterator_to_array($aggreg, false);
            $dialogId = (count($arrDial) > 0) ? $arrDial[0]["dialogs"]["dialog_id"] : null;
                // var_dump($arrDial);
            // если нет диалога
            if (empty($dialogId)) {
                // создать диалог
                $dialogId = "U" . $userID . "A" . $apponentID;
                $dialogU = [
                    'apponent_id' => $apponentID,
                    'dialog_id' => $dialogId,
                ];
                $dialogA = [
                    'apponent_id' => $userID,
                    'dialog_id' => $dialogId,
                ];
                // и записать его к обеим пользователям
                $mdb->dialogs->updateOne(["_id" => $userID], ['$push' => ["dialogs" => $dialogU]], ["upsert" => true]);
                $mdb->dialogs->updateOne(["_id" => $apponentID], ['$push' => ["dialogs" => $dialogA]], ["upsert" => true]);

            }
            // добавить сообщение к диалогу
            $upMessage = [
                "message" => $message,
                "user_id" => $userID,
                "date_created" => date("Y-m-d H:i:s"),
                "status_read"=>false
            ];
            $mdb->messages->updateOne(["_id" => $dialogId], ['$push' => ['messages' => $upMessage]], ["upsert" => true]);

            return ["massege" => "Сообщение отправленно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
