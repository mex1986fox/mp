<?php
namespace App\Models\Api\Ads;

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
            $hosts = $this->container["hosts"];
            $db = $this->container['db'];
            // передаем параметры в переменные
            $p = $this->request->getQueryParams();

            //проверяем параметры
            $exceptions = [];
            if (empty($p["ad_id"])) {
                $exceptions["ad_id"] = "Не указан номер объявления";
            }
            if (empty($p["like"])) {
                $exceptions["like"] = "Не указан лайк";
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
           
            //устанавливаем параметры
            $like = $p["like"];

            if ($like == 1) {
                $qLike = 1;
                $qDislike = 0;
            }
            if ($like == -1) {
                $qLike = 0;
                $qDislike = 1;
            }
            $AdID = $p["ad_id"];
            $sessionID = $p["session_id"];
            $userID = $p["user_id"];

            // проверить аутентификацию пользователя
            $auths = $this->container['auths'];
            $authedUser = $auths->AuthUser->Authed($sessionID, $userID);
            if (!$authedUser) {
                throw new \Exception("Не прошел аутентификацию");
            }

            // проверить есть ли объект сервиса по id
            $qServ = "SELECT ads_id FROM ads WHERE ads_id = {$AdID}";
            $feth = $db->query($qServ, \PDO::FETCH_ASSOC)->fetch();
            if (empty($feth["ads_id"])) {
                $authedAds = $auths->AuthAds->Authed($AdID);
                if (!$authedAds) {
                    throw new \Exception("Нет такого объявления");
                }
                //создать лайки для объявления
                 $qNewLike = "INSERT INTO ads (ads_id, likes, dislikes, users) values ({$AdID}, {$qLike}, {$qDislike}, '{{$userID}}'::integer[])";
                $feth = $db->query($qNewLike, \PDO::FETCH_ASSOC)->fetch();
            } else {
                //проверить голосовал ли пользователь
               $qUser = "SELECT ads_id from ads where ads_id={$AdID} and users @>'{{$userID}}'::integer[]";
                $feth = $db->query($qUser, \PDO::FETCH_ASSOC)->fetch();
                //если не голосовал
                if (empty($feth["ads_id"])) {
                    //добавить лайки для объявления
                    $qNewLike = "UPDATE ads SET users=users||{$userID}, likes=likes+{$qLike}, dislikes=dislikes+{$qDislike} where ads_id={$AdID}";
                    $feth = $db->query($qNewLike, \PDO::FETCH_ASSOC)->fetch();
                } else {
                    throw new \Exception("Пользователь уже голосовал");
                }

            };
           
            return ["massege" => "Голос принят"];
        } catch (RuntimeException | \Exception $e) {
            $exceptions['massege'] = $e->getMessage();
            return ["exceptions" => $exceptions];
        }

    }
}
