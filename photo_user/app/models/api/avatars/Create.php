<?php
namespace App\Models\Api\Avatars;

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
            if (!isset($p["session_id"])) {
                $exceptions["session_id"] = "Не указан";
            }
            if (!isset($p["user_id"])) {
                $exceptions["user_id"] = "Не указан";
            }
            if (!empty($exceptions)) {
                throw new \Exception("Не верные параметры");
            }
            //устанавливаем параметры
            $sessionID = $p["session_id"];
            $userID = $p["user_id"];
            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }
            // проверить есть ли у юзера такое объявление
            $authedAdd = $auths->AuthAdd->Authed($userID, $addID);
            if (!$authedAdd) {
                throw new \Exception("У пользователя нет такого объявления");
            }

            // сохраняем файл на сервер
            $db = $this->container['db'];

            foreach ($_FILES["files"]["name"] as $key => $name) {
                if ($_FILES['files']['error'][$key] == 0) {
                    $path = MP_PRODIR . "/public/photos/avatars/$userID";
                    $links = $thisHost . "/public/photos/avatars/$userID";
                    file_exists($path . "/");
                    if (!file_exists($path)) {
                        mkdir($path, 0777, true);
                        $qInsert = "insert into lincks_avatars (user_id, lincks) values ($userID, '{\"lincks\":[]}');";
                        $db->query($qInsert, \PDO::FETCH_ASSOC)->fetch();
                    }
                    //проверить наличие подобного файла
                    if (!file_exists($path . "/" . $name)) {
                        //сохраняем если нет такого файла
                        move_uploaded_file($_FILES['files']['tmp_name'][$key], $path . "/" . $name);
                        $qUpdate = "update lincks_avatars
                                        set lincks = jsonb_set(lincks, '{lincks}', lincks->'lincks'||'\"{$links}/{$name}\"')
                                        where user_id={$userID};";
                        $db->query($qUpdate, \PDO::FETCH_ASSOC)->fetch();
                    }

                }
            }
            // пишем в базу

            // $login = $p["login"];
            // return ["recovery_key" => $recoveryKey, "massege" => "Регистрация прошла успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
