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
            empty($p["album_id"])? $exceptions["album_id"] = "Не указан" : $albumID = $p["album_id"];
            empty($p['session_id']) ? $exceptions["session_id"] = "Не указан" : $sessionID = $p['session_id'];
            empty($p['user_id']) ? $exceptions["user_id"] = "Не указан" : $userID = $p['user_id'];
            if (!empty($exceptions)) {
                throw new \Exception("Ошибки в парамметрах");
            }

            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }
           
            // проверить есть ли у юзера такой альбом
            $db = $this->container['db'];
            
            $qInsert = "select id from albums where id={$albumID} and user_id={$userID}";
            $qUser=$db->query($qInsert, \PDO::FETCH_ASSOC)->fetch();
            if (!$qUser && $qUser->id!=$albumID) {
                throw new \Exception("У пользователя нет такого альбома");
            }

            foreach ($_FILES["files"]["name"] as $key => $name) {
                if ($_FILES['files']['error'][$key] == 0) {
                    $path = MP_PRODIR . "/public/photos/$userID/$albumID";
                    $links = $thisHost . "/public/photos/$userID/$albumID";
                    file_exists($path . "/");
                    if (!file_exists($path)) {
                        mkdir($path, 0777, true);
                        $qInsert = "insert into lincks (albums_id, lincks) values ($albumID, '{\"lincks\":[]}');";
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
