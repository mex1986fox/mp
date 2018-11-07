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
            if (empty($p["date_created"])) {
                $exceptions["date_created"] = "Не указана дата создания";
            }
            if (empty($p["dialog_id"])) {
                $exceptions["dialog_id"] = "Не указан номер диалога";
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
            $dateCreated = $p["date_created"];
            $sessionID = $p["session_id"];
            $userID = (int) $p["user_id"];
            $dialogID = $p["dialog_id"];

            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }
 
            $mdb = $this->container['mongodb'];
            // удалить сообщение
            $dialog = $mdb->messages->findOne(['_id' => $dialogID]);
            $messages = iterator_to_array($dialog, true)['messages'];
            foreach ($messages as $key => $value) {
                if ($messages[$key]["user_id"] == $userID && $messages[$key]["date_created"] == $dateCreated) {
                    unset($messages[$key]);
                }
            }
            $mdb->messages->updateOne(['_id' => $dialogID], ['$set' => ['messages' => $messages]]);

            return ["massege" => "Сообщение удалено"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
