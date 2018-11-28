<?php
namespace App\Models\Api\Photos;

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
            $authedAlbum = $auths->AuthAlbum->Authed($userID, $albumID);
            if (!$authedAlbum) {
                throw new \Exception("У пользователя нет такого альбома");
            }

            // сохраняем файл на сервер
            $db = $this->container['db'];

            foreach ($_FILES["files"]["name"] as $key => $name) {
                if ($_FILES['files']['error'][$key] == 0) {
                    $path = MP_PRODIR . "/public/photos/$userID/$albumID";
                    $links = $thisHost . "/public/photos/$userID/$albumID";
                    file_exists($path . "/");
                    if (!file_exists($path)) {
                        mkdir($path, 0777, true);
                        echo $qInsert = "insert into lincks (albums_id, lincks) values ($albumID, '{\"lincks\":[]}');";
                        $db->query($qInsert, \PDO::FETCH_ASSOC)->fetch();
                    }
                    //проверить наличие подобного файла
                    if (!file_exists($path . "/" . $name)) {
                        //сохраняем если нет такого файла
                        move_uploaded_file($_FILES['files']['tmp_name'][$key], $path . "/" . $name);
                        $qUpdate = "update lincks
                                        set lincks = jsonb_set(lincks, '{lincks}', lincks->'lincks'||'\"{$links}/{$name}\"')
                                        where albums_id={$albumID};";
                        $db->query($qUpdate, \PDO::FETCH_ASSOC)->fetch();
                    }

                }
            }
            return ["message" => "Фотографии добавлены успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
