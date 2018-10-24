<?php
namespace App\Models\Api\Dialogs;

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
    
            $aggreg = $mdb->dialogs->find(['_id' => $userID]);
            $arrDial = iterator_to_array($aggreg, false);
            $dialogs = $arrDial[0]["dialogs"];
            return ["dialogs" => $dialogs];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['message'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }
    }
}
