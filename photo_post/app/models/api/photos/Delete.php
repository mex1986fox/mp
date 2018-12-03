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
            if (!isset($p["post_id"])) {
                $exceptions["post_id"] = "Не указан";
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
            $postID = $p["post_id"];
            $linck = $p["linck"];
            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }
            // проверить есть ли у юзера такой альбом
            $authedPost = $auths->AuthPost->Authed($userID, $postID);
            if (!$authedPost) {
                throw new \Exception("У пользователя нет такого альбома");
            }
            // сохраняем файл на сервер
            $db = $this->container['db'];
            // удаляем фотографию
            $nameFile = str_replace($thisHost . "/public/photos/$userID/$postID", "", $linck);
            $path = MP_PRODIR . "/public/photos/$userID/$postID/$nameFile";
            unlink($path);
            // удаляем ссылку в базе
               echo $qUpdate = "update lincks
                set lincks = jsonb_set(lincks, '{lincks}', (lincks->'lincks')-'{$linck}')
                where posts_id={$postID};";
            $dbLincks = $db->query($qUpdate, \PDO::FETCH_ASSOC)->fetch();
            return ["message" => "Фотография удалена успешно"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
