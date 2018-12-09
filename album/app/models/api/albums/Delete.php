<?php
namespace App\Models\Api\Albums;

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
            if (!empty($exceptions)) {
                throw new \Exception("Не верные параметры");
            }
            //устанавливаем параметры
            $sessionID = $p["session_id"];
            $userID = $p["user_id"];
            $albumID = $p["album_id"];

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

            // удаляем фотографии
            $this->removeDirectory(MP_PRODIR . "/public/photos/$userID/$albumID");

            // удаляем фльбом
            $qDelLincks = "delete from lincks where albums_id={$albumID}";
            $db->query($qDelLincks, \PDO::FETCH_ASSOC)->fetch();
            $qDelAlbums = "delete from albums where id={$albumID}";
            $db->query($qDelAlbums, \PDO::FETCH_ASSOC)->fetch();

            return ["message" => "Альбом удален успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
    public function removeDirectory($dir)
    {
        if ($objs = glob($dir . "/*")) {
            foreach ($objs as $obj) {
                is_dir($obj) ? $this->removeDirectory($obj) : unlink($obj);
            }
        }
        rmdir($dir);
    }
}
