<?php
namespace App\Models\Api\Photos;

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
            if (!isset($p["session_id"])) {
                $exceptions["session_id"] = "Не указан";
            }
            if (!isset($p["user_id"])) {
                $exceptions["user_id"] = "Не указан";
            }
            if (!isset($p["album_id"])) {
                $exceptions["album_id"] = "Не указан";
            }
            if (!isset($p["linck"])) {
                $exceptions["linck"] = "Не указан";
            }
            if (!empty($exceptions)) {
                throw new \Exception("Не верные параметры");
            }
            //устанавливаем параметры
            $sessionID = $p["session_id"];
            $userID = $p["user_id"];
            $albumID = $p["album_id"];
            $linck = $p["linck"];
            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }
            // проверить есть ли у юзера такой альбом
            $db = $this->container['db'];
            $qInsert = "select id from albums where id={$albumID} and user_id={$userID}";
            $qUser = $db->query($qInsert, \PDO::FETCH_ASSOC)->fetch();
            if (!$qUser && $qUser->id != $albumID) {
                throw new \Exception("У пользователя нет такого альбома");
            }

            // удаляем фотографию
            $nameFile = str_replace($thisHost . "/public/photos/$userID/$albumID", "", $linck);
            $path = MP_PRODIR . "/public/photos/$userID/$albumID/$nameFile";
            unlink($path);
            // удаляем ссылку в базе
            $qUpdate = "update lincks
                set lincks = jsonb_set(lincks, '{lincks}', (lincks->'lincks')-'{$linck}')
                where albums_id={$albumID};";
            $dbLincks = $db->query($qUpdate, \PDO::FETCH_ASSOC)->fetch();
            return ["message" => "Фотография удалена успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
