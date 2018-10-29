<?php
namespace App\Models\Api\Messages;

use \Zend\Validator\Exception\RuntimeException as RuntimeException;

class Show
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
            if (!empty($exceptions)) {
                throw new \Exception("Не верные параметры");
            }
            if (empty($p["apponent_id"])) {
                $exceptions["apponent_id"] = "Не указан аппонент";
            }
            $apponentID = (int) $p["apponent_id"];

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
            // проверить есть ли диалог
            $aggreg = $mdb->dialogs->aggregate([
                ['$match' => ['_id' => $userID]],
                ['$unwind' => '$dialogs'],
                ['$match' => ['dialogs.apponent_id' => $apponentID]],
                [ '$limit' => 5 ]
            ]);
            $arrDial = iterator_to_array($aggreg, false);
            $dialogId = (count($arrDial) > 0) ? $arrDial[0]["dialogs"]["dialog_id"] : null;
            if (!empty($dialogId)) {
                // создать диалог
                $dialog = $mdb->messages->findOne(["_id" => $dialogId]);
            } else {
                throw new \Exception("Диалога не найдено");
            }
            $messages = iterator_to_array($dialog, true)["messages"];
            return ["messages" => $messages];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['message'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }
    }
}
